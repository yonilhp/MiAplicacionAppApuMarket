import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController con;

  LoginPage() : con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 50,
          child: _textDontHaveAccount(context),
        ),
        body: Stack(
          children: [
            _backgroundCover(context),
            _boxForm(context),
            Column(
              children: [
                _imagecover(),
                _textAppName(),
              ],
            )
          ],
        ));
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.42,
      color: Color.fromARGB(235, 72, 184, 192),
    );
  }

  Widget _textAppName() {
    return Text(
      'QORI MARKET',
      style: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.35, left: 50, right: 50),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.lightBlue, // Color del borde
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
            _textFieldEmail(),
            _textFieldPassword(),
            _buttonLogin()
          ],
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Correo Electronico',
          prefixIcon: Icon(Icons.email),
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          prefixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 55),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => con.login(),
        style: ElevatedButton.styleFrom(
          // border para el boton
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            // side: BorderSide(color: Colors.lightBlue, width: 2.0)
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(
          'LOGIN',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 45),
        child: Text(
          'INGRESE ESTA INFORMACION',
          style: TextStyle(color: Colors.black),
        ));
  }

  Widget _textDontHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿No tienes cuenta?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            )),
        SizedBox(
          width: 7,
        ),
        GestureDetector(
          onTap: () => con.goToRegisterPage(),
          child: Text(
            'Registrate Aquí',
            style: TextStyle(
                color: Color.fromARGB(235, 72, 184, 192),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget _imagecover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 15),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/img/delivery.png',
          width: 130,
          height: 130,
        ),
      ),
    );
  }
}
