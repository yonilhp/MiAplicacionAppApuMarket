import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:apu_market/src/models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:apu_market/src/environment/environment.dart';
import 'package:apu_market/src/models/product.dart';
import 'package:get/get.dart';

class ProductsProvider extends GetConnect {
  String url = '${Enviroment.API_URL}api/products';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});
  /*Para almacenar imagenes grandes */

  Future<List<Product>> findByCategory(String idCategory) async {
    Response response = await get(
      '$url/findByCategory/$idCategory',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': userSession.sessionToken ?? ''
      },
    ); // Esperar hasta que el servidor nos devuelva la respuesta

    if (response.statusCode == 401) {
      Get.snackbar('Petición denegada',
          'Tu usuario no está permitido leer esta información');
      return [];
    }
    //Convierte el cuerpo de la respuesta en una lista de categorías utilizando el método estático fromJsonList()
    List<Product> products = Product.fromJsonList(response.body);

    return products;
  }

  Future<Stream> create(Product product, List<File> images) async {
    Uri uri = Uri.http(Enviroment.API_URL_OLD, '/api/products/create');
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = userSession.sessionToken ?? '';

    for (int i = 0; i < images.length; i++) {
      request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(images[i].openRead().cast()),
          await images[i].length(),
          filename: basename(images[i].path)));
    }

    request.fields['product'] = json.encode(product);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }
}
