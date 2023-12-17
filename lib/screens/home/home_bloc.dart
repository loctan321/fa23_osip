import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/stocks/models/view_post_stocks_request.dart';
import 'package:optimizing_stock_investment_portfolio/helper/date_time.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/view_post_stock/view_post_stock_response.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/stocks_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      var dataTemp = List<ViewPostStockResponse>.from(data.data ?? []);
      final addList = List<String>.from(state.addList);

      dataTemp = dataTemp
          .map(
              (e) => addList.contains(e.ticker) ? e.copyWith(isCheck: true) : e)
          .toList();

      final dataList = List<ViewPostStockResponse>.from(state.dataList)
        ..addAll(dataTemp);

      final maxLoadMore = ((data.totalPages ?? 0) / 10).floor();

      final canLoadMore = page <= maxLoadMore;

      emit(state.copyWith(
        dataList: dataList,
        stockDataList: dataTemp,
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
      emit(state.copyWith(dataUpdate: null));
      final dataList = List<ViewPostStockResponse>.from(state.dataList);

      final element = dataList.firstWhereOrNull((e) => e.ticker == ticker);

      final addList = List<String>.from(state.addList);

      if (element != null) {
        if (isCheck) {
          element.isCheck = true;
          addList.add(ticker);
        } else {
          element.isCheck = false;
          addList.removeWhere((element) => element == ticker);
        }

        emit(state.copyWith(
          addList: addList,
          dataUpdate: element,
        ));
      }
    }
  }

  onUnCheckAllList() {
    emit(state.copyWith(addList: []));
    onFetch(page: 1);
  }

  onUpdateAddList(List<String> list) {
    emit(state.copyWith(addList: list));
    onFetch(page: 1);
  }

  onAddWhishList(ViewPostStockResponse data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch and decode data
    final String? whishListString = prefs.getString('whishList_key');

    var dataList = <ViewPostStockResponse>[];

    if (whishListString != null) {
      dataList = ViewPostStockResponse.decode(whishListString);
    } else {
      dataList = [];
    }

    if (dataList.isEmpty) {
      dataList.add(data);
    } else {
      final temp =
          dataList.firstWhereOrNull((element) => element.ticker == data.ticker);
      if (temp == null) {
        dataList.add(data);
      }
    }

    // Encode and store data in SharedPreferences
    final String encodedData = ViewPostStockResponse.encode(dataList);

    await prefs.setString('whishList_key', encodedData);
  }
}
