import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizing_stock_investment_portfolio/api/services/users/models/change_password_request.dart';
import 'package:optimizing_stock_investment_portfolio/repository/users/users_repository.dart';

import 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  final UsersRepository _usersRepository = UsersRepository();
  ProfileBloc() : super(const ProfileState());

  getData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final userData = await _usersRepository.getUser();

      final avatar =
          userData.fullName?.split(' ').last.substring(0, 1).toUpperCase();

      emit(state.copyWith(
        isLoading: false,
        userData: userData,
        avatar: avatar,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }

  onChangePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(state.copyWith(isChangePassword: false));
    try {
      final result = await _usersRepository.changePassword(
        request: ChangePasswordRequest(
          username: state.userData?.username ?? '',
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );

      if (result == 'Password changed successfully') {
        emit(state.copyWith(
          isChangePassword: true,
          messageChangePassword: 'Password changed successfully',
        ));
      } else {
        emit(state.copyWith(
          isChangePassword: true,
          messageChangePassword: 'Password change fail',
        ));
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    } finally {
      emit(state.copyWith(isChangePassword: false));
    }
  }
}
