class RegisterEvent {
  final String username;
  final String password;
  final String email;
  final String fullname;

  const RegisterEvent({
    required this.username,
    required this.password,
    required this.email,
    required this.fullname,
  });

  toJson() {}
}
