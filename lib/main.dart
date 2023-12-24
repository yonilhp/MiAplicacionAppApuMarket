import 'package:apu_market/src/pages/login/login_page.dart';
import 'package:apu_market/src/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apu Market',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: const ColorScheme(
          primary: Colors.amber,
          secondary: Colors.amberAccent,
          background: Colors.grey,
          surface: Colors.grey,
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
