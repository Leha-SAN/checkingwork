import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'providers/date_provider.dart';
import 'providers/record_provider.dart'; // Import RecordProvider
import 'package:checkingwork/services/auth_service.dart';
import 'package:checkingwork/router.dart'; // Import the router

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),  // Provide AuthService
        ChangeNotifierProvider(create: (_) => DateProvider()), // Provide DateProvider
        ChangeNotifierProvider(create: (_) => RecordProvider()), // Provide RecordProvider
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}