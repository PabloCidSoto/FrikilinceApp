import 'package:flutter/material.dart';
import 'package:proyectofinal/graphics/orders_graphic.dart';
import 'package:proyectofinal/screens/address_form_screen.dart';
import 'package:proyectofinal/screens/addresses_screen.dart';
import 'package:proyectofinal/screens/home_screen.dart';
import 'package:proyectofinal/screens/login_screen.dart';
import 'package:proyectofinal/screens/orders_screen.dart';
import 'package:proyectofinal/screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget currentPage = LoginScreen();
    return MaterialApp(
      routes: {
        '/login': (BuildContext context) => LoginScreen(),
        '/home': (BuildContext context) => HomeScreen(),
        '/profile': (BuildContext context) => ProfileScreen(),
        '/addresses': (BuildContext context) => AddressesScreen(),
        '/formAddress': (BuildContext context) => AddressFormScreen(),
        '/orders': (BuildContext context) => OrdersScreen(),
        '/graphic': (BuildContext context) => VerticalBarLabelChart()


      },
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
