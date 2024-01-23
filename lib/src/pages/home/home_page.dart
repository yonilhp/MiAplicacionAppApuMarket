import 'package:apu_market/src/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController con;
  HomePage() : con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
      onPressed: () {
        con.signOut();
      },
      child: Text(
        'Cerrar Sesión',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    )));
  }
}
