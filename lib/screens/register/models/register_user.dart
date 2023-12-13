class User {
  final String username;
  final String password;
  final String email;
  final String fullname;
  final int roleId;

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.fullname,
    required this.roleId,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "email": email,
    "fullname": fullname,
    "roleid": roleId,
  };

  static fromJson(jsonDecode) {}
}