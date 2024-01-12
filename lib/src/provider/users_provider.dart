import 'package:apu_market/src/environment/environment.dart';
import 'package:apu_market/src/models/user.dart';
import 'package:get/get.dart';

import '../environment/environment.dart';
import '../models/user.dart';

class UsersProvider extends GetConnect {
  String url = '${Enviroment.API_URL}api/users';

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
