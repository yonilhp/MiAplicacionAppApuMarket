import 'package:apu_market/main.dart';
import 'package:apu_market/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          //begin: Alignment.topCenter,
          begin: AlignmentDirectional.bottomCenter,
          end: Alignment.center,
          colors: deliveryGradients,
        )),
        //color: Colors.yellow[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'RESTAURANT',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    //color: Color(0xff00BFFF),
                    color: Color.fromARGB(235, 72, 184, 192),
                    fontSize: 40,
                  ),
            ),
            CircleAvatar(
              backgroundColor: Colors
                  .white, // Puedes cambiar el color de fondo según tus preferencias
              radius:
                  100, // Ajusta el radio del CircleAvatar según tus necesidades
              child: ClipOval(
                child: Image.asset(
                  'assets/img/Logo.jpg', // Ruta de tu imagen cuadrada
                  width: 2 *
                      100, // El doble del radio del CircleAvatar para asegurarte de que se ajuste
                  height: 2 *
                      100, // El doble del radio del CircleAvatar para asegurarte de que se ajuste
                  fit: BoxFit
                      .cover, // Ajusta el modo de ajuste según tus necesidades
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
