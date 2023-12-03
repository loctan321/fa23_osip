import 'package:copy_with_extension/copy_with_extension.dart';

part 'detail_stock_state.g.dart';

@CopyWith()
class DetailStockState {
  final bool isLoading;

  const DetailStockState({
    this.isLoading = false,
  });
}
