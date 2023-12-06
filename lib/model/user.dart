class User {
  int id;
  String fullname;
  String username;
  String email;
  int roleid;
  String token;
  dynamic baned;
  String validaty;
  String guidId;
  DateTime expiredTime;

  User({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    required this.roleid,
    required this.token,
    required this.baned,
    required this.validaty,
    required this.guidId,
    required this.expiredTime,
  });
}
