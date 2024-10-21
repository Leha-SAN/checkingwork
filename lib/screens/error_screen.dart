import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ошибка'),
      ),
      body: Center(
        child: Text('404 - Страница не найдена', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}