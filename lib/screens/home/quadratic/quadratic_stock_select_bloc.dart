import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/stocks_repository.dart';

import 'quadratic_stock_select_state.dart';

class QuadraticStockSelectBloc extends Cubit<QuadraticStockSelectState> {
  final StocksRepository _stocksRepository = StocksRepository();
  QuadraticStockSelectBloc() : super(const QuadraticStockSelectState());

  getData(List<String> listStockSelect) {
    emit(state.copyWith(listStockSelect: listStockSelect));
  }

  onUnCheck(String data) {
    final listStockSelect = List<String>.from(state.listStockSelect);
    listStockSelect.removeWhere((element) => element == data);
    emit(state.copyWith(listStockSelect: listStockSelect));
  }

  onUnCheckAllList() {
    emit(state.copyWith(listStockSelect: []));
  }
}
