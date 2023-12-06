import 'package:json_annotation/json_annotation.dart';

part 'view_post_stocks_request.g.dart';

@JsonSerializable()
class ViewPostStocksRequest {
  String? nameStock;
  String? dateRelease;

  ViewPostStocksRequest({
    this.nameStock,
    this.dateRelease,
  });

  Map<String, dynamic> toJson() => _$ViewPostStocksRequestToJson(this);
}
