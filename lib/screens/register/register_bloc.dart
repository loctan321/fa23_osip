import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/users/models/register_user_request.dart';
import 'package:optimizing_stock_investment_portfolio/repository/users/users_repository.dart';

import 'register_state.dart';

class RegisterBloc extends Cubit<RegisterState> {
  final UsersRepository _usersRepository = UsersRepository();
  RegisterBloc() : super(const RegisterState());

  onSendOTP(String email) async {
    emit(state.copyWith(isSendOTP: false));
    try {
      await _usersRepository.sendOTP(
        email: email,
      );

      emit(state.copyWith(isSendOTP: true));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    } finally {
      emit(state.copyWith(isSendOTP: false));
    }
  }

  onSubmit({
    required String username,
    required String password,
    required String email,
    required String fullname,
    required String otp,
  }) async {
    emit(state.copyWith(isSubmit: false));
    try {
      final checkOTP = await _usersRepository.checkOTP(otp: otp);

      if (checkOTP == 'OTP is correct.') {
        final result = await _usersRepository.register(
          request: RegisterUserRequest(
            username: username,
            password: password,
            email: email,
            fullname: fullname,
            roleid: 2,
          ),
          otp: otp,
        );

        if (result != null) {
          if (result == 'Registration successful') {
            emit(state.copyWith(
              isSubmit: true,
              isSubmitSuccess: true,
              messageSubmit: result,
            ));
          } else {
            emit(state.copyWith(
              isSubmit: true,
              isSubmitSuccess: false,
              messageSubmit: result,
            ));
          }
        } else {
          emit(state.copyWith(
            isSubmit: true,
            isSubmitSuccess: false,
            messageSubmit: 'OTP is not correct',
          ));
        }
      } else {
        emit(state.copyWith(
          isSubmit: true,
          isSubmitSuccess: false,
          messageSubmit: 'OTP is not correct',
        ));
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    } finally {
      emit(state.copyWith(isSubmit: false));
    }
  }
}
