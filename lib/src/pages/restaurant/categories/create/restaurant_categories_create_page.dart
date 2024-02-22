import 'package:apu_market/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantCategoriesCreatePage extends StatelessWidget {
  final RestaurantCategoriesCreateController con =
      Get.put(RestaurantCategoriesCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundCover(context),
        _boxForm(context),
        _textNewCategory(context),
      ],
    ));
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Color.fromARGB(235, 72, 184, 192),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.30, left: 50, right: 50),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.grey, // Color del borde
        //   width: 2.0, // Ancho del borde
        // ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              //color de borde

              color: Colors.black54,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _textFieldDescription(),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Nombre',
          prefixIcon: Icon(Icons.category),
        ),
      ),
    );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: TextField(
        controller: con.descriptionController,
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Descripción',
          prefixIcon: Container(
              margin: EdgeInsets.only(bottom: 70),
              child: Icon(Icons.description)),
        ),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => con.createCategory(),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            // side: BorderSide(color: Colors.lightBlue, width: 2.0)
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(
          'CREAR CATEGORIA',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 30),
        child: Text(
          'INGRESE ESTA INFORMACION',
          style: TextStyle(color: Colors.black),
        ));
  }

  Widget _textNewCategory(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Icon(
                Icons.category,
                color: Colors.white,
                size: 100,
              ),
              Text(
                "NUEVA CATEGORIA",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ],
          )),
    );
  }
}
