import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/code_input_screen.dart';
import 'providers/date_provider.dart';
import 'package:checkingwork/models/record_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DateProvider()),
        ChangeNotifierProvider(create: (_) => RecordProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Input App',
      home: CodeInputScreen(),
    );
  }
}