import 'package:apu_market/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  // Aqui se crea una instancia de la clase User con key user
  //que asignamos en login controller
  // si viene nulo le asignamos un objeto vacio
  User user = User.fromJson(GetStorage().read('user') ?? {});

  HomeController() {
    print('User De Sesión: ${user.toJson()}');
  }

  void signOut() {
    GetStorage().remove('user');

    Get.offNamedUntil('/', (route) => false);
  }
}
