import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/code_input_screen.dart';
import 'providers/date_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DateProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Input App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CodeInputScreen(),
    );
  }
}