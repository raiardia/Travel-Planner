import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import 'add_tour_page.dart';
import 'mytrip_page.dart';
import 'profil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traveler App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const HomePage(),
        '/addTour': (context) => const AddTourPage(),
        '/mytrip': (context) => const MytripPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
