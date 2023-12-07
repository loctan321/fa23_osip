import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'view_post_stock_response.g.dart';

@JsonSerializable()
@CopyWith()
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
  bool isCheck;

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
    this.isCheck = false,
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
