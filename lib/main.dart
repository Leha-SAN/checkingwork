import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/code_input_screen.dart';
import 'providers/date_provider.dart';
import 'providers/record_provider.dart'; // Импортируйте провайдер записей
import 'package:checkingwork/screens/home_screen.dart';
import 'package:checkingwork/screens/profile_screen.dart';
import 'package:checkingwork/screens/salary_screen.dart';
import 'package:checkingwork/screens/error_screen.dart';
import 'package:checkingwork/services/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider<DateProvider>(create: (_) => DateProvider()),
        ChangeNotifierProvider<RecordProvider>(create: (_) => RecordProvider()), // Добавьте этот провайдер
      ],
      child: MaterialApp(
        title: 'Checking Work',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(),
          '/code_input': (context) => CodeInputScreen(),
          '/salary': (context) => SalaryScreen(),
          '/login': (context) => LoginScreen(),
          '/error': (context) => ErrorScreen(),
        },
      ),
    );
  }
}