import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  int? userId;
  String? username;
  String? password;
  String? fullName;
  dynamic dateOfBirth;
  DateTime? registrationDate;
  int? roleId;
  String? email;
  dynamic baned;
  List<dynamic>? comments;
  List<dynamic>? forumPosts;
  List<dynamic>? reacts;
  List<dynamic>? reports;
  dynamic role;
  List<dynamic>? tasks;
  List<dynamic>? watchlists;

  UserResponse({
    this.userId,
    this.username,
    this.password,
    this.fullName,
    this.dateOfBirth,
    this.registrationDate,
    this.roleId,
    this.email,
    this.baned,
    this.comments,
    this.forumPosts,
    this.reacts,
    this.reports,
    this.role,
    this.tasks,
    this.watchlists,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return _$UserResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
