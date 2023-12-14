import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/stock_chart/stock_chart_response.dart';

part 'detail_stock_state.g.dart';

@CopyWith()
class DetailStockState {
  final bool isLoading;
  final List<StockChartResponse> dataList;
  final int optionChange;

  const DetailStockState({
    this.isLoading = false,
    this.dataList = const [],
    this.optionChange = 1,
  });
}
