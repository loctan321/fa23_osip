import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/view_post_stock/view_post_stock_response.dart';

part 'home_state.g.dart';

@CopyWith()
class HomeState {
  final bool isLoading;
  final String nameSearch;
  final String dateSearch;
  final List<ViewPostStockResponse> stockDataList;
  final List<ViewPostStockResponse> addList;

  const HomeState({
    this.isLoading = false,
    this.nameSearch = '',
    this.dateSearch = '',
    this.stockDataList = const [],
    this.addList = const [],
  });
}
