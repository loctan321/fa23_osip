import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  int? id;
  String? fullname;
  String? username;
  String? email;
  int? roleid;
  String? token;
  dynamic baned;
  String? validaty;
  String? guidId;
  String? expiredTime;

  LoginResponse({
    this.id,
    this.fullname,
    this.username,
    this.email,
    this.roleid,
    this.token,
    this.baned,
    this.validaty,
    this.guidId,
    this.expiredTime,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
