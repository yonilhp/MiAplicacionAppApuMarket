import 'package:apu_market/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProductsDetailPage extends StatelessWidget {
  ClientProductsDetailController con =
      Get.put(ClientProductsDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('ClientProductsDetailPage'),
    ));
  }
}
