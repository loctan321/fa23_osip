import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/stocks_repository.dart';

import 'detail_stock_state.dart';

class DetailStockBloc extends Cubit<DetailStockState> {
  final StocksRepository _stocksRepository = StocksRepository();
  DetailStockBloc() : super(const DetailStockState());

  getData({required String ticker, required String date, int? option}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _stocksRepository.getStockChart(
        ticker: ticker,
        date: date,
        option: option ?? 1,
      );
      emit(state.copyWith(
        profitAverage: result.profitAverage,
        standardDeviation: result.standardDeviation,
        dataList: result.listChart,
        isLoading: false,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }
}
