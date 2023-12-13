import 'package:json_annotation/json_annotation.dart';

import 'view_post_stock_response.dart';

part 'filter_view_post_stock_response.g.dart';

@JsonSerializable()
class FilterViewPostStockResponse {
  int? totalPages;
  List<ViewPostStockResponse>? data;

  FilterViewPostStockResponse({
    this.totalPages,
    this.data,
  });

  factory FilterViewPostStockResponse.fromJson(Map<String, dynamic> json) {
    return _$FilterViewPostStockResponseFromJson(json);
  }
}
