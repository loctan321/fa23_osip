import 'package:dio/dio.dart';
import 'package:optimizing_stock_investment_portfolio/api/exception/api_endpoints.dart';
import 'package:optimizing_stock_investment_portfolio/base/base_service.dart';

import 'models/view_post_stocks_request.dart';

class StocksService extends BaseService {
  Future<Response> viewPostStocks(
      {required ViewPostStocksRequest request}) async {
    final response = await post(
      StocksApi.viewPostStocks,
      data: request.toJson(),
    );
    return response;
  }

  Future<Response> getStockChart({
    required String ticker,
    required String date,
  }) async {
    final response = await post(
      StocksApi.getStockChart
          .replaceAll(RegExp('{ticker}'), ticker)
          .replaceAll(RegExp('{date}'), date),
    );
    return response;
  }

  Future<Response> getQuadraticStockSelect({
    required List<String> list,
    required bool mathWithDailyOrMonth,
  }) async {
    final response = await post(
      StocksApi.getQuadraticStockSelect.replaceAll(
          RegExp('{mathWithDailyOrMonth}'), mathWithDailyOrMonth.toString()),
      // data: [];
    );
    return response;
  }
}
