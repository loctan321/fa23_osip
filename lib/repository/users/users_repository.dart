import 'package:flutter/foundation.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/users/models/change_password_request.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/users/models/login_request.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/users/models/register_user_request.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/users/users_service.dart';

import 'models/login_response/login_response.dart';
import 'models/user_response/user_response.dart';

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

  Future<String?> sendOTP({
    required String email,
  }) async {
    try {
      final response = await _service.sendOTP(
        email: email,
      );
      final result = response;
      print(result);
      return result;
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return null;
    }
  }

  Future<String?> register({
    required RegisterUserRequest request,
    required String otp,
  }) async {
    try {
      final response = await _service.register(
        request: request,
        otp: otp,
      );

      if (response.statusCode == 200) {
        return response.data['message'];
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

  Future<String?> checkOTP({
    required String otp,
  }) async {
    try {
      final response = await _service.checkOTP(
        otp: otp,
      );

      if (response.statusCode == 200) {
        return response.data['message'];
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

  Future<String?> changePassword({
    required ChangePasswordRequest request,
  }) async {
    try {
      final response = await _service.changePassword(
        request: request,
      );

      if (response.statusCode == 200) {
        return response.data['message'];
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

  Future<UserResponse> getUser() async {
    try {
      final response = await _service.getUser();

      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        return UserResponse();
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return UserResponse();
    }
  }
}
