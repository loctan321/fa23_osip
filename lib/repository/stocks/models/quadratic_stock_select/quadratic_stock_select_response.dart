import 'package:json_annotation/json_annotation.dart';

part 'quadratic_stock_select_response.g.dart';

@JsonSerializable()
class QuadraticStockSelectResponse {
  String? nameStock;
  double? xValue;

  QuadraticStockSelectResponse({this.nameStock, this.xValue});

  factory QuadraticStockSelectResponse.fromJson(Map<String, dynamic> json) {
    return _$QuadraticStockSelectResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuadraticStockSelectResponseToJson(this);

  static List<QuadraticStockSelectResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) => QuadraticStockSelectResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
