import 'package:apu_market/src/pages/restaurant/orders/list/restaurant_orders_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantOrdersListPage extends StatelessWidget {
  RestaurantLOrdersListaController con =
      Get.put(RestaurantLOrdersListaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('RestaurantOrdersListPage'),
    ));
  }
}
