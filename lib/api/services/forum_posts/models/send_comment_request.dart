import 'package:json_annotation/json_annotation.dart';

part 'send_comment_request.g.dart';

@JsonSerializable()
class SendCommentRequest {
  int? postId;
  int? userId;
  String? content;
  DateTime? commentDate;

  SendCommentRequest({
    this.postId,
    this.userId,
    this.content,
    this.commentDate,
  });

  factory SendCommentRequest.fromJson(Map<String, dynamic> json) {
    return _$SendCommentRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SendCommentRequestToJson(this);
}
