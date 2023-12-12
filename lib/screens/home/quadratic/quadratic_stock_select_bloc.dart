import 'package:flutter/foundation.dart';
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

  getStockSuggestList(int quantity) async {
    try {
      emit(state.copyWith(isLoading: true));

      final result = await _stocksRepository.getStockSuggestList(
        quantity: quantity,
      );

      final listStockNew = result.map((e) => e.ticker ?? '').toList();

      final listStockSelect = List<String>.from(state.listStockSelect);

      final filterList = listStockNew
          .where((itemA) => !listStockSelect.any((itemB) => itemB == itemA))
          .toList();

      emit(state.copyWith(
        listStockSelect: [...listStockSelect, ...filterList],
        isLoading: false,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }

  onSubmit() async {
    try {
      emit(state.copyWith(
        isLoading: true,
        dataList: null,
      ));

      final result = await _stocksRepository.getQuadraticStockSelect(
        list: state.listStockSelect,
      );

      emit(state.copyWith(
        dataList: result,
        isLoading: false,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }
}
