import 'package:flutter/material.dart';

class DetailStockParams {
  DetailStockParams({
    required this.ticker,
    required this.date,
    required this.onReload,
  });

  final String ticker;
  final String date;
  final VoidCallback onReload;
}
