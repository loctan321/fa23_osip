import 'package:flutter/foundation.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/stocks/models/view_post_stocks_request.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/stocks/stocks_service.dart';

import 'models/quadratic_stock_select/quadratic_stock_select_response.dart';
import 'models/stock_chart/stock_chart_response.dart';
import 'models/stock_suggest/stock_suggest_response.dart';
import 'models/view_post_stock/view_post_stock_response.dart';

class StocksRepository {
  final _service = StocksService();

  Future<List<ViewPostStockResponse>> viewPostStocks({
    required ViewPostStocksRequest request,
  }) async {
    try {
      final response = await _service.viewPostStocks(
        request: request,
      );
      if (response.statusCode == 200) {
        final result =
            ViewPostStockResponse.fromJsonArray(response.data['data']);
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
