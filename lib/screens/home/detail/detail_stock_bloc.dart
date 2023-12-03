import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_stock_state.dart';

class DetailStockBloc extends Cubit<DetailStockState> {
  DetailStockBloc() : super(const DetailStockState());

  getData() async {
    try {
      emit(state.copyWith(isLoading: true));

      emit(state.copyWith(
        isLoading: false,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }
}
