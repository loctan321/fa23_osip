import 'package:json_annotation/json_annotation.dart';

part 'react_request.g.dart';

@JsonSerializable()
class ReactRequest {
  int? postId;
  DateTime? reactDate;

  ReactRequest({
    this.postId,
    this.reactDate,
  });

  factory ReactRequest.fromJson(Map<String, dynamic> json) {
    return _$ReactRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReactRequestToJson(this);
}
