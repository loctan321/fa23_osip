import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/view_post_stock/view_post_stock_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'whishlist_state.dart';

class WhishlistBloc extends Cubit<WhishlistState> {
  WhishlistBloc() : super(const WhishlistState());

  getData() async {
    emit(state.copyWith(isLoading: true));
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch and decode data
    final String? whishListString = prefs.getString('whishList_key');

    var dataList = <ViewPostStockResponse>[];

    if (whishListString != null) {
      dataList = ViewPostStockResponse.decode(whishListString);
    } else {
      dataList = [];
    }

    emit(state.copyWith(
      isLoading: false,
      dataList: dataList,
    ));
  }

  onDelete(index) async {
    final dataList = List<ViewPostStockResponse>.from(state.dataList ?? []);

    if (dataList.isNotEmpty) {
      dataList.removeAt(index);
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Encode and store data in SharedPreferences
    final String encodedData = ViewPostStockResponse.encode(dataList);

    await prefs.setString('whishList_key', encodedData);

    emit(state.copyWith(
      dataList: dataList,
    ));
  }
}
