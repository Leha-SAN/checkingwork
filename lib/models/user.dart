// user.dart
class User {
  final int id;
  final int userId;
  final String name;
  final String authkey;
  final String password;

  User({
    required this.id,
    required this.userId,
    required this.name,
    required this.authkey,
    required this.password,
  });

  // Метод для создания объекта User из JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      authkey: json['authkey'],
      password: json['password'],
    );
  }

  // Метод для преобразования объекта User в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'authkey': authkey,
      'password': password,
    };
  }
}