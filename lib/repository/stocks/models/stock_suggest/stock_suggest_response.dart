import 'package:json_annotation/json_annotation.dart';

part 'stock_suggest_response.g.dart';

@JsonSerializable()
class StockSuggestResponse {
  String? ticker;
  double? standardDeviation;
  double? sharpeRatio;
  double? profitAverage;

  StockSuggestResponse({
    this.ticker,
    this.standardDeviation,
    this.sharpeRatio,
    this.profitAverage,
  });

  factory StockSuggestResponse.fromJson(Map<String, dynamic> json) {
    return _$StockSuggestResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StockSuggestResponseToJson(this);

  static List<StockSuggestResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) =>
              StockSuggestResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
