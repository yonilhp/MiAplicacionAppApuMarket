import 'dart:convert';
import 'dart:io';
import 'package:apu_market/src/models/response_api.dart';
import 'package:apu_market/src/models/user.dart';
import 'package:apu_market/src/provider/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email: $email');
    print('Password: $password');

    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Cargando...');
      User user = User(
          email: email,
          name: name,
          lastname: lastname,
          phone: phone,
          password: password);

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true) {
          GetStorage().write(
              'user',
              responseApi
                  .data); // Ya estamos almacenando datos del usuario des sessión
          //llamamos a la funcion goToHomePage
          goToHomePage();
        } else {
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }
      });
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('client/products/list', (route) => false);
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

    if (imageFile == null) {
      Get.snackbar(
          'Formulario no válido', 'Debes seleccionar una imagen de perfil');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      },
      //border para el boton
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          // side: BorderSide(color: Colors.lightBlue, width: 2.0)
        ),
      ),
      child: Text(
        "GALERIA",
        style: TextStyle(color: Colors.black),
      ),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          // side: BorderSide(color: Colors.lightBlue, width: 2.0)
        ),
      ),
      child: Text(
        "CAMARA",
        style: TextStyle(color: Colors.black),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "Selecciona una opción",
        style: TextStyle(color: Colors.black),
      ),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
