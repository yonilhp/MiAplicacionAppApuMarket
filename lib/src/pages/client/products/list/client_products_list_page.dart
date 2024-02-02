import 'package:apu_market/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:apu_market/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:apu_market/src/pages/register/register_page.dart';
import 'package:apu_market/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:apu_market/src/utils/custom_animated_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProductsListPage extends StatelessWidget {
  ClientProductsListController con = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(() => IndexedStack(
              index: con.indexTab.value,
              children: [
                RestaurantOrdersListPage(),
                DeliveryOrdersListPage(),
                RegisterPage()
              ],
            )));
  }

  Widget _bottomBar() {
    return Obx(() => CustomAnimatedBottomBar(
          //color de bordes de barra

          containerHeight: 70,
          backgroundColor: Colors.amber,
          //color de bordes de bottomBar
          // backgroundColor: Color.fromARGB(255, 255, 248, 220),
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          selectedIndex: con.indexTab.value,
          onItemSelected: (index) => con.changeTab(index),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: Colors.white,
              inactiveColor: Colors.black,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.list),
              title: Text('Mis pedidos'),
              activeColor: Colors.white,
              inactiveColor: Colors.black,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Perfil'),
              activeColor: Colors.white,
              inactiveColor: Colors.black,
            ),
          ],
        ));
  }
}
