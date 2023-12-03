import 'package:flutter/material.dart';
import 'package:optimizing_stock_investment_portfolio/theme/app_color.dart';

extension UIContext on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  AppColor get appColor => AppColor(this);
  void hideKeyboard() => FocusScope.of(this).unfocus();
}
