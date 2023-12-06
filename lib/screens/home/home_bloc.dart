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

  onAddList(ViewPostStockResponse data) {
    final addList = List<ViewPostStockResponse>.from(state.addList);
    addList.add(data);
    emit(state.copyWith(
      addList: addList,
    ));
  }
}
