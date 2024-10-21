import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter for navigation
import 'package:provider/provider.dart';
import 'package:checkingwork/services/auth_service.dart';
import 'forgot_password_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(labelText: 'User ID'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final userId = int.tryParse(_userIdController.text) ?? 0;
                final password = _passwordController.text;

                final authService = Provider.of<AuthService>(context, listen: false);

                // Add output to check code execution
                print('Attempting to login with User ID: $userId and Password: $password');

                // Waiting for Future to complete
                final loggedIn = await authService.login(userId, password);

                if (loggedIn) {
                  // Using GoRouter for navigation
                  context.go('/');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Неверные учетные данные')),
                  );
                }
              },
              child: Text('Войти'),
            ),
            TextButton(
              onPressed: () {
                // Navigating to the password recovery screen
                context.go('/forgot_password');
              },
              child: Text('Забыли пароль?'),
            ),
            TextButton(
              onPressed: () {
                //Navigating to the registration screen
                context.go('/registration');
              },
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}