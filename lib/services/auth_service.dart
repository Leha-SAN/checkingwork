import 'package:flutter/material.dart';
import 'package:checkingwork/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:checkingwork/database/database_helper.dart';
import 'dart:convert';

class AuthService extends ChangeNotifier {
  User? _authenticatedUser;

  Future<bool> login(int userId, String password) async {
    final String apiUrl = 'https://time.milesta.ru/api/site/index';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$userId:$password'));

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        int id = int.tryParse(responseData['id'].toString()) ?? 0; // Casting to int with checking
        int userIdFromResponse = int.tryParse(responseData['username'].toString()) ?? userId; // Casting to int with checking

        _authenticatedUser = User(
          id: id,
          userId: userIdFromResponse,
          authkey: responseData['auth_key'] ?? '',
          password: password,
        );

        await saveUserToDatabase(_authenticatedUser!);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Ошибка при авторизации: $error');
      return false;
    }
  }

  void logout() {
    _authenticatedUser = null;
    notifyListeners();
  }

  bool isLoggedIn() {
    return _authenticatedUser != null;
  }

  Future<void> saveUserToDatabase(User user) async {
    // Implementing a method to save a user to a database
    final dbHelper = DatabaseHelper();
    await dbHelper.insertUser(user);
  }

  User? get currentUser => _authenticatedUser;
}