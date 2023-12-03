import 'package:flutter/material.dart';

class DetailStockParams {
  DetailStockParams({
    required this.id,
    required this.onReload,
  });

  final String id;
  final VoidCallback onReload;
}
