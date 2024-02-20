import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:apu_market/src/environment/environment.dart';
import 'package:apu_market/src/models/response_api.dart';
import 'package:apu_market/src/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends GetConnect {
  String url = '${Enviroment.API_URL}api/users';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<Response> create(User user) async {
    Response response = await post(
      '$url/create',
      user.toJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
  //Sin imagen

  Future<ResponseApi> update(User user) async {
    Response response = await put(
      '$url/updateWithoutImage',
      user.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': userSession.sessionToken ?? ''
      },
    );

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la información');
      return ResponseApi();
    }

    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No esta autorizado para realizar esta petición');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  /*Para almacenar imagenes grandes */
  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Enviroment.API_URL_OLD, '/api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<Stream> updateWithImage(User user, File image) async {
    Uri uri = Uri.http(Enviroment.API_URL_OLD, '/api/users/update');
    final request = http.MultipartRequest('PUT', uri);
    request.headers['Authorization'] = userSession.sessionToken ?? '';
    request.files.add(http.MultipartFile(
        'image', http.ByteStream(image.openRead().cast()), await image.length(),
        filename: basename(image.path)));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
      '$url/login',
      {'email': email, 'password': password},
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print('RESPONSE Body: ${response.body}');
    print('RESPONSE Status Code: ${response.statusCode}');

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la petición');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
