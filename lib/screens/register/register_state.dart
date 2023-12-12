import 'package:optimizing_stock_investment_portfolio/screens/register/models/register_user.dart';

class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user;

  const RegisterSuccess(this.user);
}

class RegisterError extends RegisterState {
  final String message;

  const RegisterError(this.message);
}