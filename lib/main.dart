import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/resources/routes.dart';
import 'package:optimizing_stock_investment_portfolio/screens/home/detail/detail_stock_screen.dart';
import 'package:optimizing_stock_investment_portfolio/screens/home/detail/models/detail_stock_params.dart';
import 'package:optimizing_stock_investment_portfolio/screens/splash_screen.dart';
import 'dart:io';

import 'package:optimizing_stock_investment_portfolio/services/navigation_service.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.root,
            onGenerateRoute: (settings) => _getRoutes(settings),
            navigatorKey: NavigationService.navigatorKey,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: child!,
                ),
              );
            },
          );
        });
  }

  Route<dynamic> _getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.root),
          builder: (_) => const SplashScreen(),
        );

      // detail stock
      case Routes.detailStock:
        assert(
          settings.arguments != null && settings.arguments is DetailStockParams,
        );
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.detailStock),
          builder: (_) => DetailStockScreen(
            params: settings.arguments! as DetailStockParams,
          ),
        );

      default:
        throw Exception("Route is not defined");
    }
  }
}
