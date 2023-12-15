import 'package:dio/dio.dart';
import 'package:optimizing_stock_investment_portfolio/api/exception/api_endpoints.dart';
import 'package:optimizing_stock_investment_portfolio/base/base_service.dart';

import 'models/change_password_request.dart';
import 'models/login_request.dart';
import 'models/register_user_request.dart';

class UsersService extends BaseService {
  Future<Response> login({required LoginRequest request}) async {
    final response = await post(
      UsersApi.login,
      data: request.toJson(),
    );
    return response;
  }

  Future<Response> sendOTP({required String email}) async {
    final response = await post(
      UsersApi.sendOTP.replaceAll(RegExp('{email}'), email),
    );
    return response;
  }

  Future<Response> checkOTP({required String otp}) async {
    final response = await post(
      UsersApi.checkOTP.replaceAll(RegExp('{otp}'), otp),
    );
    return response;
  }

  Future<Response> register({
    required RegisterUserRequest request,
    required String otp,
  }) async {
    final response = await post(
      UsersApi.register.replaceAll(RegExp('{otp}'), otp),
      data: request.toJson(),
    );
    return response;
  }

  Future<Response> getUser() async {
    final response = await get(
      UsersApi.getUser,
    );
    return response;
  }

  Future<Response> changePassword(
      {required ChangePasswordRequest request}) async {
    final response = await post(
      UsersApi.changePassword,
      data: request.toJson(),
    );
    return response;
  }
}
