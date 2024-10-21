class User {
  static const int authorizedUserId = 1; //authorized user ID
  static const String authorizedPassword = '1111'; //authorized user password

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

  // Method for checking authorization
  static bool authorize(int userId, String password) {
    return userId == authorizedUserId && password == authorizedPassword;
  }

  // Method to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      authkey: json['authkey'],
      password: json['password'],
    );
  }

  // Method to convert User object to JSON
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