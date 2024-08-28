import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_screen.dart';
import 'code_input_screen.dart';
import 'salary_screen.dart';
import 'package:checkingwork/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get AuthService object
    final authService = Provider.of<AuthService>(context, listen: false);

    // Checking user authorization
    if (!authService.isLoggedIn()) {
      // If the user is not authorized, redirect him to the login screen
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), //Showing a loading indicator during redirection
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Профиль', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CodeInputScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Ввод работ', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SalaryScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Зарплата', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
