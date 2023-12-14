import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/quadratic_stock_select/quadratic_stock_select_response.dart';

part 'quadratic_stock_select_state.g.dart';

@CopyWith()
class QuadraticStockSelectState {
  final bool isLoading;
  final bool isGetSuggestSuccess;
  final List<String> listStockSelect;
  final List<QuadraticStockSelectResponse>? dataList;

  const QuadraticStockSelectState({
    this.isLoading = false,
    this.isGetSuggestSuccess = false,
    this.listStockSelect = const [],
    this.dataList,
  });
}
