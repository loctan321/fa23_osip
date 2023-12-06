import 'package:flutter/foundation.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/users/models/login_request.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/users/users_service.dart';

import 'models/login_response/login_response.dart';

class UsersRepository {
  final _service = UsersService();

  Future<LoginResponse?> login({
    required LoginRequest request,
  }) async {
    try {
      final response = await _service.login(
        request: request,
      );
      if (response.statusCode == 200) {
        final result = LoginResponse.fromJson(response.data);
        return result;
      } else {
        return null;
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return null;
    }
  }
}
