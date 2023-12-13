enum SortColumnType {
  stockName('StockName'),
  dailyProfit('DailyProfit');

  const SortColumnType(this.value);

  static SortColumnType from(String? value) {
    return SortColumnType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => SortColumnType.stockName,
    );
  }

  final String value;
}
