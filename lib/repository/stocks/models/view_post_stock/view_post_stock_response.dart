import 'package:json_annotation/json_annotation.dart';

part 'view_post_stock_response.g.dart';

@JsonSerializable()
class ViewPostStockResponse {
  String? ticker;
  String? dtyyyymmdd;
  double? open;
  double? high;
  double? low;
  double? close;
  int? volume;
  double? dailyProfit;
  double? standardDeviation;
  double? sharpeRatio;

  ViewPostStockResponse({
    this.ticker,
    this.dtyyyymmdd,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.dailyProfit,
    this.standardDeviation,
    this.sharpeRatio,
  });

  factory ViewPostStockResponse.fromJson(Map<String, dynamic> json) {
    return _$ViewPostStockResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ViewPostStockResponseToJson(this);

  static List<ViewPostStockResponse> fromJsonArray(
    List<dynamic> jsonArray,
  ) {
    return jsonArray
        .map(
          (dynamic e) =>
              ViewPostStockResponse.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
