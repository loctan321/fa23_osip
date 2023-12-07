import 'package:flutter/material.dart';

class QuadraticStockSelectParams {
  QuadraticStockSelectParams({
    required this.onSelectChanged,
    required this.onUnCheck,
    required this.onUnCheckAllList,
    required this.listStockSelect,
  });

  final void Function(List<String>) onSelectChanged;
  final void Function(String) onUnCheck;
  final VoidCallback onUnCheckAllList;
  final List<String> listStockSelect;
}
