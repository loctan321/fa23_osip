import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';
import 'models/stock_data.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(const HomeState());

  getData() async {
    try {
      emit(state.copyWith(isLoading: true));

      final stockDataList = <StockData>[
        StockData(
          stockId: 'AAA',
          dailyProfit: 0.1107,
          standardDeviation: 2.39230058393928283,
          close: 9.04,
          volume: 18870000,
          date: DateTime.now(),
        ),
        StockData(
          stockId: 'AAM',
          dailyProfit: 0.1207,
          standardDeviation: 1.99230058393928283,
          close: 8.04,
          volume: 20870000,
          date: DateTime.now(),
        ),
        StockData(
          stockId: 'AAT',
          dailyProfit: 0.1107,
          standardDeviation: 2.39230058393928283,
          close: 9.04,
          volume: 18870000,
          date: DateTime.now(),
        ),
        StockData(
          stockId: 'ABR',
          dailyProfit: 0.1207,
          standardDeviation: 2.39230058393928283,
          close: 9.04,
          volume: 18870000,
          date: DateTime.now(),
        ),
        StockData(
          stockId: 'ACB',
          dailyProfit: 0.1307,
          standardDeviation: 2.39230058393928283,
          close: 9.04,
          volume: 18870000,
          date: DateTime.now(),
        ),
      ];

      emit(state.copyWith(
        stockDataList: stockDataList,
        isLoading: false,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }

  onAddList(StockData data) {
    final addList = List<StockData>.from(state.addList);
    addList.add(data);
    emit(state.copyWith(
      addList: addList,
    ));
  }
}
