import 'package:apu_market/src/environment/environment.dart';
import 'package:apu_market/src/models/user.dart';
import 'package:get/get.dart';

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
