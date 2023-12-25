import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forum_post_response.g.dart';

@JsonSerializable()
@CopyWith()
class ForumPostResponse {
  int? postId;
  int? userId;
  String? fullName;
  String? title;
  String? content;
  DateTime? postDate;
  bool? accept;
  bool? baned;
  DateTime? activationDate;
  int? likeCount;
  int? dislikeCount;
  int? commentCount;
  String? activationDateAgo;
  int react;

  ForumPostResponse({
    this.postId,
    this.userId,
    this.fullName,
    this.title,
    this.content,
    this.postDate,
    this.accept,
    this.baned,
    this.activationDate,
    this.likeCount,
    this.dislikeCount,
    this.commentCount,
    this.activationDateAgo,
    this.react = 0,
  });

  factory ForumPostResponse.fromJson(Map<String, dynamic> json) {
    return _$ForumPostResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ForumPostResponseToJson(this);

  static List<ForumPostResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) => ForumPostResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
