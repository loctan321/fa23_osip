import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/stocks/models/view_post_stocks_request.dart';
import 'package:optimizing_stock_investment_portfolio/helper/date_time.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/view_post_stock/view_post_stock_response.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/stocks_repository.dart';

import 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  final StocksRepository _stocksRepository = StocksRepository();
  HomeBloc() : super(const HomeState());

  getData() async {
    emit(state.copyWith(isLoading: true));
    onFetch(page: 1);
    emit(state.copyWith(isLoading: false));
  }

  onFetch({
    required int page,
  }) async {
    try {
      if (page == 1) {
        emit(
          state.copyWith(
            canLoadMore: false,
          ),
        );
      }
      final data = await _stocksRepository.viewPostStocks(
        request: ViewPostStocksRequest(
          nameStock: state.nameSearch,
          dateRelease: state.dateSearch != null
              ? state.dateSearch!.format(pattern: yyyy_mm_dd)
              : '',
        ),
        page: page,
        sortColumn: state.sortColumn,
        sortDirection: state.sortDirection,
      );

      var newDataList = List<ViewPostStockResponse>.from(data.data ?? []);

      final maxLoadMore = ((data.totalPages ?? 0) / 10).floor();

      final canLoadMore = page <= maxLoadMore;

      emit(state.copyWith(
        stockDataList: newDataList,
        currentPage: page,
        canLoadMore: canLoadMore,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }

  onChangeNameSearch(String value) {
    emit(state.copyWith(
      nameSearch: value,
    ));
  }

  onChangeDateSearch(DateTime? time) {
    emit(state.copyWith(
      dateSearch: time,
    ));
  }

  onChangeSortColumn(String? type) {
    emit(state.copyWith(
      sortColumn: type,
    ));
  }

  onChangeSortDirection() {
    emit(state.copyWith(
      sortDirection: !state.sortDirection,
    ));
  }

  onAddList(String? ticker, bool isCheck) {
    if (ticker != null) {
      final stockDataList =
          List<ViewPostStockResponse>.from(state.stockDataList ?? []);

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
    final stockDataList =
        List<ViewPostStockResponse>.from(state.stockDataList ?? []);

    final data = stockDataList.map((e) => e.copyWith(isCheck: false)).toList();

    emit(state.copyWith(
      addList: [],
      stockDataList: data,
    ));
  }
}
