import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/view_post_stock/view_post_stock_response.dart';

part 'whishlist_state.g.dart';

@CopyWith()
class WhishlistState {
  final bool isLoading;
  final List<ViewPostStockResponse>? dataList;

  const WhishlistState({
    this.isLoading = false,
    this.dataList,
  });
}
