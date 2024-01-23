import 'package:apu_market/src/models/user.dart';
import 'package:apu_market/src/pages/home/home_page.dart';
import 'package:apu_market/src/pages/login/login_page.dart';
import 'package:apu_market/src/pages/register/register_page.dart';
import 'package:apu_market/src/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class DeliveryColors {
  static final yellow = Color(0xffFDC054);
  static final green = Color(0xff32B768);
  static final orange = Color(0xffFFA500);
  static final white = Color(0xffFFFFFF);
  static final blue = Color(0xff0000FF);
  //celeste
  static final lightBlue = Color(0xff00FFFF);
  // celeste medio azulino
  static final mediumBlue = Color(0xff00BFFF);
  //verde claro opaco
  static final lightGreen = Color(0xff90EE90);
  // anaranjado opaco
  static final lightOrange = Color(0xffFFDAB9);
}

final deliveryGradients = [
  DeliveryColors.lightBlue,
  DeliveryColors.lightOrange
];

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Usuario id: ${userSession.id}');

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apu Market',
      home: const SplashScreen(),
      initialRoute: userSession.id != null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: const ColorScheme(
          primary: Colors.lightBlue,
          secondary: Colors.amberAccent,
          background: Colors.white,
          //surface: Color.fromARGB(255, 250, 237, 196),
          surface: Color.fromARGB(255, 255, 248, 220),
          onSurface: Colors.grey,
          onSecondary: Colors.grey,
          onPrimary: Colors.grey,
          onError: Colors.grey,
          onBackground: Colors.grey,
          error: Colors.grey,
          brightness: Brightness.light,
        ),
      ),
      navigatorKey: Get.key,
    );
  }
}
