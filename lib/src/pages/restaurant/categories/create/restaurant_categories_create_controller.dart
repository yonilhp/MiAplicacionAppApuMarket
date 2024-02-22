import 'package:apu_market/src/models/response_api.dart';
import 'package:apu_market/src/provider/categories_provider.dart';
import 'package:apu_market/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantCategoriesCreateController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CategoriesProvider categoriesProvider = CategoriesProvider();

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

  void clearForm() {
    nameController.text = '';
    descriptionController.text = '';
  }
}
