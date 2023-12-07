import 'package:copy_with_extension/copy_with_extension.dart';

part 'quadratic_stock_select_state.g.dart';

@CopyWith()
class QuadraticStockSelectState {
  final bool isLoading;
  final List<String> listStockSelect;

  const QuadraticStockSelectState({
    this.isLoading = false,
    this.listStockSelect = const [],
  });
}
