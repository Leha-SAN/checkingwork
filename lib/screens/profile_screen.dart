import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:checkingwork/widgets/custom_bottom_nav_bar.dart';
import 'package:checkingwork/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    // Проверка авторизации пользователя
    if (!authService.isLoggedIn()) {
      // Если пользователь не авторизован, перенаправить его на экран входа
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // Показать индикатор загрузки во время перенаправления
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Здесь будет информация профиля.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authService.logout(); // Calling the logout method
                Navigator.pushReplacementNamed(context, '/login'); // Redirect to login screen
              },
              child: Text('Выйти'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}