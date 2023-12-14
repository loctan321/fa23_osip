enum OptionChartType {
  jan(1),
  mar(3),
  jun(6),
  sep(9),
  dec(12);

  const OptionChartType(this.value);

  final int value;

  static OptionChartType from(int? value) {
    return OptionChartType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => OptionChartType.jan,
    );
  }

  String get name {
    switch (this) {
      case OptionChartType.jan:
        return 'January';
      case OptionChartType.mar:
        return 'March';
      case OptionChartType.jun:
        return 'June';
      case OptionChartType.sep:
        return 'September';
      case OptionChartType.dec:
        return 'December';
    }
  }
}
