import 'package:flutter/material.dart';
import 'package:checkingwork/screens/profile_screen.dart';
import 'package:checkingwork/screens/code_input_screen.dart';
import 'package:checkingwork/screens/salary_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CodeInputScreen()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SalaryScreen()),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Профиль',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          label: 'Ввод работ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Зарплата',
        ),
      ],
    );
  }
}