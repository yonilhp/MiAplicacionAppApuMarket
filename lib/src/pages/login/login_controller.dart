import 'package:apu_market/src/models/response_api.dart';
import 'package:apu_market/src/models/user.dart';
import 'package:apu_market/src/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
// aqui se crea una instancia de la clase UsersProvider
  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email: $email');
    print('Password: $password');

    if (isValidForm(email, password)) {
      // Aqui se llama a la función login del proveedor
      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response Api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        GetStorage().write(
            'user',
            responseApi
                .data); // Ya estamos almacenando datos del usuario des sessión con key 'user'
        User myUser = User.fromJson(GetStorage().read('user') ?? {});
        // Si el usuario tiene mas de un rol, lo enviamos a la página de roles
        if (myUser.roles!.length > 1) {
          goToRolesPage();
          // Si el usuario tiene un solo rol, lo enviamos a la página de homePage
        } else {
          goToClientHomePage();
        }
      } else {
        Get.snackbar('Login fallido', responseApi.message ?? '');
      }
    }
  }

  void goToClientHomePage() {
    Get.offNamedUntil('/client/home', (route) => false);
  }

  void goToRolesPage() {
    Get.offNamedUntil('/roles', (route) => false);
  }

  bool isValidForm(String email, String password) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no válido', 'El email no es válido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar el password');
      return false;
    }

    return true;
  }
}
