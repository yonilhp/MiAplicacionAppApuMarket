import 'package:apu_market/src/pages/client/profile/update/client_profile_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ClientProfileUpdatePage extends StatelessWidget {
  ClientProfileUpdateController con = Get.put(ClientProfileUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _backgroundCover(context),
        _boxForm(context),
        _imageUser(context),
        _buttomBack()
      ],
    ));
  }

  Widget _buttomBack() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30, left: 10),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
    );
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
            _textFieldLastName(),
            _textFieldPhone(),
            _buttonUpdate(context)
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
          prefixIcon: Icon(Icons.person),
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.lastnameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Apellidos',
          prefixIcon: Icon(Icons.person_2_outlined),
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.phoneController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          hintText: 'Telefono',
          prefixIcon: Icon(Icons.phone),
        ),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => con.updateInfo(context),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            // side: BorderSide(color: Colors.lightBlue, width: 2.0)
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(
          'GUARDAR',
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

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top: 50),
          alignment: Alignment.topCenter,
          child: GestureDetector(
              onTap: () => con.showAlertDialog(context),
              child: GetBuilder<ClientProfileUpdateController>(
                builder: (value) => CircleAvatar(
                  backgroundImage: con.imageFile != null
                      ? FileImage(con.imageFile!)
                      : con.user.image != null
                          ? NetworkImage(con.user.image!)
                          : AssetImage('assets/img/user_profile.png')
                              as ImageProvider,
                  radius: 60,
                  backgroundColor: Colors.white,
                ),
              ))),
    );
  }
}
