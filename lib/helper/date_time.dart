import 'package:intl/intl.dart';

const dd_mm_yyyy = 'dd/MM/yyyy';
const yyyy_mm_dd = 'yyyy-MM-dd';

extension FormatDate on DateTime {
  DateTime get toDay {
    return DateTime(year, month, day);
  }

  String format({String? locale, required String pattern}) {
    return DateFormat(pattern, locale).format(this);
  }
}
