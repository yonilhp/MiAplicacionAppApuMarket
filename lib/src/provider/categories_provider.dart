import 'package:apu_market/src/environment/environment.dart';
import 'package:apu_market/src/models/category.dart';
import 'package:apu_market/src/models/response_api.dart';
import 'package:apu_market/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoriesProvider extends GetConnect {
  String url = '${Enviroment.API_URL}api/categories';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Category>> getAll() async {
    Response response = await get(
      '$url/getAll',
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
    List<Category> categories = Category.fromJsonList(response.body);

    print(categories);
    return categories;
  }

  Future<ResponseApi> create(Category category) async {
    Response response = await post(
      '$url/create',
      category.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': userSession.sessionToken ?? ''
      },
    ); // Esperar hasta que el servidor nos devuelva la respuesta

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
