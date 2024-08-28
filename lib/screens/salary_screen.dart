import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:checkingwork/widgets/custom_bottom_nav_bar.dart';
import 'my_salary_screen.dart';
import 'my_bonus_screen.dart';
import 'my_timesheet_screen.dart';
import 'package:checkingwork/services/auth_service.dart';

class SalaryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    // Checking user autorization
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
        title: Text('Зарплата'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,  // Buttons will stretch to the full width of the container
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MySalaryScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),  // Button height
                    child: Text('Моя зарплата', style: TextStyle(fontSize: 18)),
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
                      MaterialPageRoute(builder: (context) => MyBonusScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Моя премия', style: TextStyle(fontSize: 18)),
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
                      MaterialPageRoute(builder: (context) => MyTimesheetScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Мой табель', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 2),
    );
  }
}