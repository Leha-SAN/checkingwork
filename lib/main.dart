import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/code_input_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Проверка наличия данных пользователя
    bool userExists = true; // Замените на реальную проверку

    return MaterialApp(
      title: 'Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userExists ? CodeInputScreen() : LoginScreen(),
    );
  }
}