import 'package:apu_market/src/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantProductsDeleteController extends GetxController {
// Aqui estamos creando una instancia de ProductsProvider
  ProductsProvider productsProvider = ProductsProvider();
//Aqui estamos creando un metodo para eliminar un producto por su id
  void deleteProduct(String productId) async {
    try {
      // Llama al método del provider para eliminar el producto por su ID
      await productsProvider.delete(productId);
      // Maneja la eliminación exitosa
      print('Producto eliminado exitosamente');
    } catch (error) {
      // Maneja el error si ocurre al eliminar el producto
      print('Error al eliminar el producto: $error');
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        // Llamar al método para eliminar el producto
        //     con.deleteProduct('idProducto');
        // Cerrar el diálogo
        Navigator.of(context).pop();
      },
      child: Text('Eliminar'),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        "Selecciona una opción",
        style: TextStyle(color: Colors.black),
      ),
      actions: [galleryButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
