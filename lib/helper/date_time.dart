import 'package:intl/intl.dart';

const dd_mm_yyyy = 'dd/MM/yyyy';

extension FormatDate on DateTime {
  String format({String? locale, required String pattern}) {
    return DateFormat(pattern, locale).format(this);
  }
}
