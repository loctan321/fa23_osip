import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  String username;
  String currentPassword;
  String newPassword;

  ChangePasswordRequest({
    required this.username,
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
