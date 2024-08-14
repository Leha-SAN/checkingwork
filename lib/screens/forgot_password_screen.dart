import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Восстановление пароля'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Логика восстановления пароля
                Navigator.pop(context); // Возвращаемся на экран авторизации
              },
              child: Text('Сбросить пароль'),
            ),
          ],
        ),
      ),
    );
  }
}