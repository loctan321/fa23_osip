import 'package:dio/dio.dart';
import 'package:optimizing_stock_investment_portfolio/api/exception/api_endpoints.dart';
import 'package:optimizing_stock_investment_portfolio/base/base_service.dart';

import 'models/login_request.dart';

class UsersService extends BaseService {
  Future<Response> login({required LoginRequest request}) async {
    final response = await post(
      UsersApi.login,
      data: request.toJson(),
    );
    return response;
  }
}
