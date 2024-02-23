import 'dart:io';

import 'package:apu_market/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantProductsCreatePage extends StatelessWidget {
  final RestaurantProductsCreateController con =
      Get.put(RestaurantProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundCover(context),
        _boxForm(context),
        _textNewProduct(context),
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
      height: MediaQuery.of(context).size.height * 0.70,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.18, left: 50, right: 50),
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
            _textFieldPrice(),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) => _cardImage(con.imageFile1, 1, context),
                  ),
                  //sizebox
                  SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) => _cardImage(con.imageFile2, 2, context),
                  ),
                  SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) => _cardImage(con.imageFile3, 3, context),
                  ),
                ],
              ),
            ),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _cardImage(File? imageFile, int numberFile, BuildContext context) {
    return GetBuilder<RestaurantProductsCreateController>(
      builder: (value) => GestureDetector(
          onTap: () => con.showAlertDialog(context, numberFile),
          child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.17,
              child: imageFile != null
                  ? Image.file(
                      imageFile,
                      fit: BoxFit.cover,
                    )
                  : Image(
                      image: AssetImage('assets/img/add_imageNew.png'),
                    ))),
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

  Widget _textFieldPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Precio',
          prefixIcon: Icon(Icons.attach_money),
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
          'CREAR PRODUCTO',
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

  Widget _textNewProduct(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: Text(
          "NUEVO PRODUCTO",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
