import 'package:json_annotation/json_annotation.dart';

part 'stock_chart_response.g.dart';

@JsonSerializable()
class StockChartResponse {
  String? dtyyyymmdd;
  double? openPrice;
  double? high;
  double? low;
  double? closePrice;
  double? dailyProfit;

  StockChartResponse({
    this.dtyyyymmdd,
    this.openPrice,
    this.high,
    this.low,
    this.closePrice,
    this.dailyProfit,
  });

  factory StockChartResponse.fromJson(Map<String, dynamic> json) {
    return _$StockChartResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StockChartResponseToJson(this);

  static List<StockChartResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) =>
              StockChartResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
