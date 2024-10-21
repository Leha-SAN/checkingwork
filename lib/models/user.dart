class User {
  final int id;
  final int userId;
  final String authkey;
  final String password;

  User({
    required this.id,
    required this.userId,
    required this.authkey,
    required this.password,
  });

  // Convert User object to Map for saving to database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'authkey': authkey,
      'password': password,
    };
  }

  // Create a User object from a Map
  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      userId: map['userId'],
      authkey: map['authkey'],
      password: map['password'],
    );
  }
}