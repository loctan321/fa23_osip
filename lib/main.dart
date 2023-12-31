import 'package:flutter/material.dart';
import 'package:optimizing_stock_investment_portfolio/screens/forum_screen.dart';
import 'package:optimizing_stock_investment_portfolio/screens/login_screen.dart';
import 'package:optimizing_stock_investment_portfolio/screens/profile_screen.dart';
import 'package:optimizing_stock_investment_portfolio/screens/register.dart';
import 'package:optimizing_stock_investment_portfolio/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: RegisterScreen());
  }
}
