import 'package:optimizing_stock_investment_portfolio/repository/stocks/models/quadratic_stock_select/quadratic_stock_select_response.dart';

class DetailQuadraticParams {
  DetailQuadraticParams({
    required this.dataList,
  });

  final List<QuadraticStockSelectResponse>? dataList;
}
