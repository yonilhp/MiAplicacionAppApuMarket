import 'dart:convert';

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
}
