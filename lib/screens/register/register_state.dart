import 'package:copy_with_extension/copy_with_extension.dart';

part 'register_state.g.dart';

@CopyWith()
class RegisterState {
  final bool isSendOTP;
  final bool isSubmit;
  final bool isSubmitSuccess;
  final String messageSubmit;

  const RegisterState({
    this.isSendOTP = false,
    this.isSubmit = false,
    this.isSubmitSuccess = false,
    this.messageSubmit = '',
  });
}
