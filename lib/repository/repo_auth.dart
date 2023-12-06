import 'package:optimizing_stock_investment_portfolio/base/api_base.dart';

class AuthRepo {
  final String _apikey = "/Users/Login";
  final ApiBase _apiBase = ApiBase();

  Future<dynamic> login(String? username, String? password) async {
    final response = await _apiBase
        .postLogin(_apikey, {"username": username, "password": password});

    return response;
  }
}
