import 'package:flutter/material.dart';
import 'package:checkingwork/models/user.dart'; // Importing the User model

class AuthService extends ChangeNotifier { //Inheritance from ChangeNotifier
  User? _authenticatedUser;

  // Method for user authorization
  bool login(int userId, String password) {
    if (User.authorize(userId, password)) {
      _authenticatedUser = User(
        id: 1, // This value can be replaced with more complex ID retrieval logic
        userId: userId,
        name: 'Default User', // Here you can substitute the name of the authorized user
        authkey: 'someAuthKey',
        password: password,
      );
      notifyListeners(); // We notify listeners about the change
      return true;
    } else {
      return false;
    }
  }

  // Method for user exit
  void logout() {
    _authenticatedUser = null;
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  // Checking if the user is authorized
  bool isLoggedIn() {
    return _authenticatedUser != null;
  }

  // Getting information about the current user
  User? get currentUser => _authenticatedUser;
}