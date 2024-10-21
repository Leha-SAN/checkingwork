import 'package:checkingwork/screens/registration_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:checkingwork/screens/home_screen.dart';
import 'package:checkingwork/screens/login_screen.dart';
import 'package:checkingwork/screens/profile_screen.dart';
import 'package:checkingwork/screens/code_input_screen.dart';
import 'package:checkingwork/screens/salary_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/registration',
      builder: (context, state) => RegistrationScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: '/code_input',
      builder: (context, state) => CodeInputScreen(),
    ),
    GoRoute(
      path: '/salary',
      builder: (context, state) => SalaryScreen(),
    ),
  ],
);