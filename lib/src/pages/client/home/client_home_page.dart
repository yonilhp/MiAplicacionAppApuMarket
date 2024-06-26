import 'package:apu_market/src/pages/client/home/client_home_controller.dart';
import 'package:apu_market/src/pages/client/products/list/client_products_list_page.dart';
import 'package:apu_market/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:apu_market/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:apu_market/src/pages/roles/roles_page.dart';
import 'package:apu_market/src/utils/custom_animated_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientHomePage extends StatelessWidget {
  ClientHomeController con = Get.put(ClientHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: con.myUser.roles!.length > 1
            ? AppBar(
                title: Text(
                  'Productos',
                  //centrar texto
                  style: TextStyle(color: Colors.white),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Get.offAll(() => RolesPage());
                  },
                ))
            : null,
        bottomNavigationBar: _bottomBar(),
        body: Obx(() => IndexedStack(
              index: con.indexTab.value,
              children: [
                ClientProductsListPage(),
                DeliveryOrdersListPage(),
                ClientProfileInfoPage()
              ],
            )));
  }

  Widget _bottomBar() {
    return Obx(() => CustomAnimatedBottomBar(
          containerHeight: 70,
          //backgroundColor: Color.fromARGB(235, 127, 151, 196),
          backgroundColor: Color.fromARGB(235, 72, 184, 192),
          showElevation: true,
          itemCornerRadius: 20,
          curve: Curves.easeIn,
          selectedIndex: con.indexTab.value,
          onItemSelected: (index) => con.changeTab(index),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Productos'),
              activeColor: Colors.white,
              inactiveColor: Colors.black,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.list),
              title: Text('Mis Pedidos'),
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
