import 'package:apu_market/src/models/rol.dart';
import 'package:apu_market/src/pages/roles/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RolesPage extends StatelessWidget {
  //intanciar el controllador GetController
  RolesController con = Get.put(RolesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Seleccionar el rol',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.17),
          child: ListView(
            children: con.user.roles != null
                ? con.user.roles!.map((Rol rol) {
                    return _cardRol(rol);
                  }).toList()
                : [],
          ),
        ));
  }

  Widget _cardRol(Rol rol) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(bottom: 15),
          height: 100,
          //Aqui obetenemos el link del imagen
          child: FadeInImage(
            image: NetworkImage(rol.image!),
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage("assets/img/no-image.png"),
          )),
      //separa imagenes
      Text(
        rol.name ?? '',
        style: TextStyle(fontSize: 20, color: Colors.black),
      )
    ]);
  }
}
