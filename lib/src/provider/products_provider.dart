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
  // Aqui se crea url que va recibir la url de la API de productos
  String url = '${Enviroment.API_URL}api/products';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});
  /*Para almacenar imagenes grandes */
// Future<List<Product>> Esto es para que el metodo retorne una lista de productos
//Parametro que va recibir es el String idCategory (id de la categoria)
  Future<List<Product>> findByCategory(String idCategory) async {
    Response response = await get(
      // Hacer una petición GET a la URL /api/products/findByCategory/$idCategory
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
    if (response.body != null) {
      List<Product> products = Product.fromJsonList(response.body);
      return products;
    } else {
      // Manejar el caso en que el cuerpo de la respuesta sea nulo
      // Puedes devolver una lista vacía o lanzar una excepción según tus necesidades
      return [];
    }
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

  Future<Stream> update(Product product, List<File> images) async {
    Uri uri = Uri.http(Enviroment.API_URL_OLD, '/api/products/update');
    final request = http.MultipartRequest('PUT', uri);
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

  Future<void> deleteProduct(String productId) async {
    try {
      // Realiza una solicitud HTTP DELETE al backend para eliminar el producto por su ID
      final response = await http.delete(
        Uri.parse(
            '$url/deleteProduct/$productId'), // URL para eliminar el producto por su ID
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
          // Aquí puedes incluir cualquier encabezado adicional necesario, como el token de autorización
        },
      );

      // Maneja la respuesta del backend
      if (response.statusCode == 200) {
        // El producto se eliminó correctamente
        print('Producto eliminado exitosamente');
      } else {
        // Ocurrió un error al eliminar el producto
        print('Error al eliminar el producto: ${response.statusCode}');
      }
    } catch (error) {
      // Maneja el error si ocurre durante la solicitud HTTP
      print('Error al eliminar el producto: $error');
    }
  }
}
