import 'package:apu_market/src/models/user.dart';
import 'package:apu_market/src/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email: $email');
    print('Password: $password');

    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {
      User user = User(
          email: email,
          name: name,
          lastname: lastname,
          phone: phone,
          password: password);

      Response response = await usersProvider.create(user);

      print('RESPONSE Body: ${response.body}');
      print('RESPONSE Status Code: ${response.statusCode}');

      Get.snackbar('Formulario válido', 'Estas listo para loguearte');
    }
  }

  bool isValidForm(String email, String name, String lastName, String phone,
      String password, String confirmPassword) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no válido', 'El email no es válido');
      return false;
    }
    if (name.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar el nombre');
      return false;
    }
    if (lastName.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar tus apellidos');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar(
          'Formulario no válido', 'Debes ingresar tu número de celular');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar el password');
      return false;
    }
    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes confirmar el password');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario no válido', 'Las contraseñas no coinciden');
      return false;
    }

    return true;
  }
}
