import 'package:apu_market/src/pages/restaurant/products/delete/restaurant_products_delete_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantProductsDeletePage extends StatelessWidget {
  RestaurantProductsDeleteController con =
      Get.put(RestaurantProductsDeleteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar Producto'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Mostrar el diálogo de confirmación al hacer clic en el botón
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Eliminar el producto?'),
                  content: Text(
                      '¿Estás seguro de que quieres eliminar este producto?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Cerrar el diálogo
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Llamar al método para eliminar el producto
                        con.deleteProduct('idProducto');
                        // Cerrar el diálogo
                        Navigator.of(context).pop();
                      },
                      child: Text('Eliminar'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Eliminar Producto'),
        ),
      ),
    );
  }
}
