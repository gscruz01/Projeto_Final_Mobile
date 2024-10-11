import 'package:flutter/material.dart';
import 'package:ola_mundo/features/login/presentation/dummies/login_page.dart';
import 'features/pag_inicial/presentation/dummies/home_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
