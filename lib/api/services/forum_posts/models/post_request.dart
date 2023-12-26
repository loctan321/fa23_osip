import 'package:json_annotation/json_annotation.dart';

part 'post_request.g.dart';

@JsonSerializable()
class PostRequest {
  int? postId;
  int? userId;
  String? title;
  String? content;
  DateTime? postDate;
  bool? accept;
  bool? baned;

  PostRequest({
    this.postId,
    this.userId,
    this.title,
    this.content,
    this.postDate,
    this.accept,
    this.baned,
  });

  factory PostRequest.fromJson(Map<String, dynamic> json) {
    return _$PostRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostRequestToJson(this);
}
