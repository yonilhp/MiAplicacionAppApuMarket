import 'package:apu_market/src/models/category.dart';
import 'package:apu_market/src/models/product.dart';
import 'package:apu_market/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:apu_market/src/pages/restaurant/products/delete/restaurant_products_delete_page.dart';
import 'package:apu_market/src/pages/restaurant/products/home/restaurant_products_home_page.dart';
import 'package:apu_market/src/provider/categories_provider.dart';
import 'package:apu_market/src/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RestaurantProductsHomeController extends GetxController {
  //Aqui estamos creando una instancia de CategoriesProvider y ProductsProvider
  CategoriesProvider categoriesProvider = CategoriesProvider();
  //Aqui estamos creando una instancia de ProductsProvider
  ProductsProvider productsProvider = ProductsProvider();
  //Aqui estamos creando una lista de categorias
  List<Category> categories = <Category>[].obs;

  RestaurantProductsHomeController() {
    getCategory();
  }
  //un método para navegar a la página de creación de productos.
  void navigateToCreateProductPage() {
    Get.to(RestaurantProductsCreatePage());
  }

  void getCategory() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }
  // aqui estamos creando un funcion para eliminar un producto por su id producto

  // void deleteProduct() {
  //   //Aqui estamos llamando al metodo deleteProduct de la instancia productsProvider
  //   Get.to(RestaurantProductsDeletePage());
  // }

// Aqui estamos creando una funcion que va recibir un id de categoria y va retornar una lista de productos
  Future<List<Product>> getProducts(String idCategory) async {
    return await productsProvider.findByCategory(idCategory);
  }

  void showAlertDialog(BuildContext context, String productId) {
    Widget confirmButton = ElevatedButton(
      onPressed: () async {
        try {
          // Llama al método del provider para eliminar el producto por su ID
          await productsProvider.deleteProduct(productId);
          // Maneja la eliminación exitosa
          print('Producto eliminado exitosamente');
          categories.clear();
          // Actualiza la lista de productos
          Navigator.of(context).pop();
          categories.addAll(await categoriesProvider.getAll());
          //await categoriesProvider.getAll();

          // Cerrar el diálogo
        } catch (error) {
          // Maneja el error si ocurre al eliminar el producto
          print('Error al eliminar el producto: $error');
          // Cerrar el diálogo
          Navigator.of(context).pop();
        }
      },
      child: Text(
        'Eliminar',
        style: TextStyle(color: Colors.white),
      ),
    );
    Widget cancelButton = TextButton(
      onPressed: () {
        // Cerrar el diálogo
        Navigator.of(context).pop();
      },
      child: Text(
        'Cancelar',
        style: TextStyle(color: Colors.black),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        " ¿Estás seguro de eliminar el producto?",
        style: TextStyle(color: Colors.black),
      ),
      actions: [confirmButton, cancelButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
