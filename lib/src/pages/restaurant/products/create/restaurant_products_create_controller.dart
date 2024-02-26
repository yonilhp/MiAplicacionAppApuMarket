import 'dart:io';
import 'package:apu_market/src/models/response_api.dart';
import 'package:apu_market/src/provider/categories_provider.dart';
import 'package:apu_market/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RestaurantProductsCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  String? idCategory;
  List<Category> categories = <Category>[].obs;

  RestaurantProductsCreateController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    print(result);
    categories.clear();
    categories.addAll(result);
  }

  void createCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isNotEmpty && description.isNotEmpty) {
      Category category = Category(name: name, description: description);
      ResponseApi responseApi = await categoriesProvider.create(category);
      Get.snackbar('Proceso terminado',
          'La categoría se ha creado correctamente, ${responseApi.message ?? ''}');
      if (responseApi.success == true) {
        clearForm();
      }
    } else {
      Get.snackbar('Formulario no válido',
          'Completa el nombre y la descripción para crear la categoría');
    }
  }

  Future selectImage(ImageSource imageSource, int numberFile) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      if (numberFile == 1) {
        imageFile1 = File(image.path);
      } else if (numberFile == 2) {
        imageFile2 = File(image.path);
      } else if (numberFile == 3) imageFile3 = File(image.path);
    }
    update();
  }

  void showAlertDialog(BuildContext context, int numberFile) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery, numberFile);
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
        selectImage(ImageSource.camera, numberFile);
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

  void clearForm() {
    nameController.text = '';
    descriptionController.text = '';
  }
}
