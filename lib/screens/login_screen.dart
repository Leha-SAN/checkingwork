import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:checkingwork/services/auth_service.dart';
import 'code_input_screen.dart';
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
              onPressed: () {
                final userId = int.tryParse(_userIdController.text) ?? 0;
                final password = _passwordController.text;

                final authService = Provider.of<AuthService>(context, listen: false);
                final loggedIn = authService.login(userId, password);

                if (loggedIn) {
                  Navigator.pushReplacementNamed(context, '/');
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                );
              },
              child: Text('Забыли пароль?'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}