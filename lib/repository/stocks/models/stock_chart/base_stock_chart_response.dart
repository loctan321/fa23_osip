import 'package:json_annotation/json_annotation.dart';

import 'stock_chart_response.dart';

part 'base_stock_chart_response.g.dart';

@JsonSerializable()
class BaseStockChartResponse {
  double? profitAverage;
  double? standardDeviation;
  List<StockChartResponse>? listChart;

  BaseStockChartResponse({
    this.profitAverage,
    this.standardDeviation,
    this.listChart,
  });

  factory BaseStockChartResponse.fromJson(Map<String, dynamic> json) {
    return _$BaseStockChartResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BaseStockChartResponseToJson(this);
}
