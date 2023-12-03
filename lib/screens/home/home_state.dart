import 'package:copy_with_extension/copy_with_extension.dart';

import 'models/stock_data.dart';

part 'home_state.g.dart';

@CopyWith()
class HomeState {
  final bool isLoading;
  final List<StockData> stockDataList;
  final List<StockData> addList;

  const HomeState({
    this.isLoading = false,
    this.stockDataList = const [],
    this.addList = const [],
  });
}
