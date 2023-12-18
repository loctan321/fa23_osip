import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/rest_client.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/users/models/login_request.dart';
import 'package:optimizing_stock_investment_portfolio/repository/users/users_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_state.dart';
import 'models/login_status.dart';

class LoginBloc extends Cubit<LoginState> {
  final UsersRepository _usersRepository = UsersRepository();
  LoginBloc() : super(const LoginState());

  onLogin({
    required String username,
    required String password,
  }) async {
    emit(state.copyWith(loginStatus: LoginStatus.initial, isLoading: true));
    try {
      if (username.isEmpty || password.isEmpty) {
        return;
      }

      final result = await _usersRepository.login(
          request: LoginRequest(
        username: username,
        password: password,
      ));

      if (result != null) {
        emit(state.copyWith(loginStatus: LoginStatus.loginSuccess));
        await SharedPreferences.getInstance().then((prefs) {
          prefs.setString('token', result.token ?? '');
          prefs.setInt('user_id', result.id ?? 0);
          prefs.setString('user_name', result.fullname ?? '');
        });
        RestClient().setToken('Bearer ${result.token}');
      } else {
        emit(state.copyWith(loginStatus: LoginStatus.loginFailure));
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
