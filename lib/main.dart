import 'package:apu_market/src/models/user.dart';
import 'package:apu_market/src/pages/client/home/client_home_page.dart';
import 'package:apu_market/src/pages/client/products/list/client_products_list_page.dart';
import 'package:apu_market/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:apu_market/src/pages/client/profile/update/client_profile_update_page.dart';
import 'package:apu_market/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:apu_market/src/pages/home/home_page.dart';
import 'package:apu_market/src/pages/login/login_page.dart';
import 'package:apu_market/src/pages/register/register_page.dart';
import 'package:apu_market/src/pages/restaurant/home/restaurant_home_page.dart';
import 'package:apu_market/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:apu_market/src/pages/roles/roles_page.dart';
import 'package:apu_market/src/pages/splash/splash_screen.dart';
// import 'package:apu_market/src/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// aqui se importa el paquete get_storage que se encarga de almacenar datos en el almacenamiento local
User userSession = User.fromJson(GetStorage().read('user') ?? {});

// aqui se inicializa el almacenamiento local
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
  static final lightBlue = Color.fromARGB(235, 72, 184, 192);
  // celeste medio azulino
  static final mediumBlue = Color(0xff00BFFF);
  //verde claro opaco
  static final lightGreen = Color(0xff90EE90);
  // anaranjado opaco
  static final lightOrange = Color(0xffFFDAB9);
}

final deliveryGradients = [DeliveryColors.lightBlue, DeliveryColors.yellow];

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('TOKEN DE SESSION DE USUARIO: ${userSession.sessionToken}');
  }

  @override
  Widget build(BuildContext context) {
    print('Usuario id: ${userSession.id}');

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apu Market',
      //home: const SplashScreen(),
      initialRoute: userSession.id != null
          ? userSession.roles!.length > 1
              ? '/roles'
              : '/client/home'
          : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPage()),
        GetPage(
            name: '/restaurant/orders/list',
            page: () => RestaurantOrdersListPage()),
        GetPage(name: '/restaurant/home', page: () => RestaurantHomePage()),
        GetPage(
            name: '/delivery/orders/list',
            page: () => DeliveryOrdersListPage()),
        GetPage(name: '/client/home', page: () => ClientHomePage()),
        GetPage(
            name: '/client/products/list',
            page: () => ClientProductsListPage()),
        GetPage(
            name: '/client/profile/info', page: () => ClientProfileInfoPage()),
        GetPage(
            name: '/client/profile/update',
            page: () => ClientProfileUpdatePage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: const ColorScheme(
          primary: Colors.lightBlue,
          secondary: Colors.amberAccent,
          background: Colors.white,
          //surface: Color.fromARGB(255, 250, 237, 196),
          surface: Color.fromARGB(235, 72, 184, 192),
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
