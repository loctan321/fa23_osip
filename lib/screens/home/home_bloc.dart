import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/stocks/models/view_post_stocks_request.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/view_post_stock/view_post_stock_response.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/stocks_repository.dart';

import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  final StocksRepository _stocksRepository = StocksRepository();
  HomeBloc() : super(const HomeState());

  getData(String? nameSearch) async {
    try {
      emit(state.copyWith(isLoading: true));

      final result = await _stocksRepository.viewPostStocks(
          request: ViewPostStocksRequest(
        nameStock: nameSearch,
        dateRelease: state.dateSearch,
      ));

      emit(state.copyWith(
        stockDataList: result,
        isLoading: false,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }

  onAddList(String? ticker, bool isCheck) {
    if (ticker != null) {
      final stockDataList =
          List<ViewPostStockResponse>.from(state.stockDataList);

      final element = stockDataList.firstWhere((e) => e.ticker == ticker);

      final addList = List<String>.from(state.addList);

      if (isCheck) {
        element.isCheck = true;
        addList.add(ticker);
      } else {
        element.isCheck = false;
        addList.removeWhere((element) => element == ticker);
      }

      emit(state.copyWith(
        addList: addList,
        stockDataList: stockDataList,
      ));
    }
  }

  onUnCheckAllList() {
    final stockDataList = List<ViewPostStockResponse>.from(state.stockDataList);

    final data = stockDataList.map((e) => e.copyWith(isCheck: false)).toList();

    emit(state.copyWith(
      addList: [],
      stockDataList: data,
    ));
  }
}
