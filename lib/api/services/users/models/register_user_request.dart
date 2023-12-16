import 'package:json_annotation/json_annotation.dart';

part 'register_user_request.g.dart';

@JsonSerializable()
class RegisterUserRequest {
  String username;
  String password;
  String email;
  String fullname;
  int roleid;

  RegisterUserRequest({
    required this.username,
    required this.password,
    required this.email,
    required this.fullname,
    required this.roleid,
  });

  Map<String, dynamic> toJson() => _$RegisterUserRequestToJson(this);
}
