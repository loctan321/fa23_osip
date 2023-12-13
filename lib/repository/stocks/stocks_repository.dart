import 'package:flutter/foundation.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/stocks/models/view_post_stocks_request.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/stocks/stocks_service.dart';

import 'models/quadratic_stock_select/quadratic_stock_select_response.dart';
import 'models/stock_chart/stock_chart_response.dart';
import 'models/stock_suggest/stock_suggest_response.dart';
import 'models/view_post_stock/filter_view_post_stock_response.dart';

class StocksRepository {
  final _service = StocksService();

  Future<FilterViewPostStockResponse> viewPostStocks({
    required ViewPostStocksRequest request,
    required int page,
    required String sortColumn,
    required bool sortDirection,
  }) async {
    try {
      final response = await _service.viewPostStocks(
        request: request,
        page: page.toString(),
        sortColumn: sortColumn,
        sortDirection: sortDirection.toString(),
      );
      if (response.statusCode == 200) {
        final result = FilterViewPostStockResponse.fromJson(response.data);
        return result;
      } else {
        return FilterViewPostStockResponse();
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return FilterViewPostStockResponse();
    }
  }

  Future<List<StockChartResponse>> getStockChart({
    required String ticker,
    required String date,
  }) async {
    try {
      final response = await _service.getStockChart(
        ticker: ticker,
        date: date,
      );
      if (response.statusCode == 200) {
        final result = StockChartResponse.fromJsonArray(response.data);
        return result;
      } else {
        return [];
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return [];
    }
  }

  Future<List<StockSuggestResponse>> getStockSuggestList({
    required int quantity,
  }) async {
    try {
      final response = await _service.getStockSuggestList(
        quantity: quantity.toString(),
      );
      if (response.statusCode == 200) {
        final result = StockSuggestResponse.fromJsonArray(response.data);
        return result;
      } else {
        return [];
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return [];
    }
  }

  Future<List<QuadraticStockSelectResponse>> getQuadraticStockSelect({
    required List<String> list,
  }) async {
    try {
      final response = await _service.getQuadraticStockSelect(
        list: list,
        mathWithDailyOrMonth: false,
      );
      if (response.statusCode == 200) {
        final result = QuadraticStockSelectResponse.fromJsonArray(
            response.data['stockResults']);
        return result;
      } else {
        return [];
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return [];
    }
  }
}
