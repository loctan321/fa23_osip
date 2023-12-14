import 'package:dio/dio.dart';
import 'package:optimizing_stock_investment_portfolio/api/exception/api_endpoints.dart';
import 'package:optimizing_stock_investment_portfolio/base/base_service.dart';

import 'models/view_post_stocks_request.dart';

class StocksService extends BaseService {
  Future<Response> viewPostStocks({
    required ViewPostStocksRequest request,
    required String page,
    required String sortColumn,
    required String sortDirection,
  }) async {
    final response = await post(
      StocksApi.viewPostStocks
          .replaceAll(RegExp('{page}'), page)
          .replaceAll(RegExp('{sortColumn}'), sortColumn)
          .replaceAll(RegExp('{sortDirection}'), sortDirection),
      data: request.toJson(),
    );
    return response;
  }

  Future<Response> getStockChart({
    required String ticker,
    required String date,
    required String option,
  }) async {
    final response = await post(
      StocksApi.getStockChart
          .replaceAll(RegExp('{ticker}'), ticker)
          .replaceAll(RegExp('{date}'), date)
          .replaceAll(RegExp('{option}'), option),
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
      dataList: list,
    );
    return response;
  }

  Future<Response> getStockSuggestList({
    required String quantity,
  }) async {
    final response = await post(
      StocksApi.getStockSuggestList.replaceAll(RegExp('{quantity}'), quantity),
    );
    return response;
  }
}
