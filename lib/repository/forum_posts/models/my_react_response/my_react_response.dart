import 'package:json_annotation/json_annotation.dart';

part 'my_react_response.g.dart';

@JsonSerializable()
class MyReactResponse {
  int? postId;
  String? status;

  MyReactResponse({this.postId, this.status});

  factory MyReactResponse.fromJson(Map<String, dynamic> json) {
    return _$MyReactResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MyReactResponseToJson(this);

  static List<MyReactResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) => MyReactResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
