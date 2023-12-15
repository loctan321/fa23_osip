import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:optimizing_stock_investment_portfolio/repository/users/models/user_response/user_response.dart';

part 'profile_state.g.dart';

@CopyWith()
class ProfileState {
  final UserResponse? userData;
  final bool isLoading;
  final String? avatar;
  final bool isChangePassword;
  final String messageChangePassword;

  const ProfileState({
    this.userData,
    this.isLoading = false,
    this.avatar,
    this.isChangePassword = false,
    this.messageChangePassword = '',
  });
}
