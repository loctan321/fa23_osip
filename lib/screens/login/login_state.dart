import 'package:copy_with_extension/copy_with_extension.dart';

import 'models/login_status.dart';

part 'login_state.g.dart';

@CopyWith()
class LoginState {
  final LoginStatus? loginStatus;
  final bool isLoading;
  final String? message;

  const LoginState({
    this.loginStatus = LoginStatus.initial,
    this.isLoading = false,
    this.message,
  });
}
