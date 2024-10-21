import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';  // GoRouter для навигации
import 'profile_screen.dart';
import 'code_input_screen.dart';
import 'salary_screen.dart';
import 'package:checkingwork/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получаем AuthService объект
    final authService = Provider.of<AuthService>(context, listen: false);

    return FutureBuilder(
      future: Future.delayed(Duration.zero, () => authService.isLoggedIn()), //Authorization check
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()), // Show loading indicator
          );
        }

        if (snapshot.hasData && !snapshot.data!) {
          // If the user is not authorized, we redirect him to the authorization screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/login');  // using GoRouter for navigation
          });
          return Scaffold(
            body: Center(child: CircularProgressIndicator()), // Show indicator during redirection
          );
        }

        // If authorized, show the main screen
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
                        context.go('/profile');  // Using GoRouter for navigation
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
                        context.go('/code_input');  // Using GoRouter for navigation
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
                        context.go('/salary');  // Using GoRouter for navigation
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
      },
    );
  }
}