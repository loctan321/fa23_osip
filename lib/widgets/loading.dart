import 'package:flutter/material.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Trống',
        style: context.textTheme.titleMedium,
      ),
    );
  }
}
