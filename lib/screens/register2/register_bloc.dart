import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:optimizing_stock_investment_portfolio/screens/register2/models/register_user.dart';
import 'package:optimizing_stock_investment_portfolio/screens/register2/register_event.dart';
import 'package:optimizing_stock_investment_portfolio/screens/register2/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final String sendOtpUrl = 'https://10.0.2.2:7053/api/Email/SendOtp?toEmail=';
  final String checkOtpUrl =
      'https://5321-2402-800-6370-5623-212e-b6d2-a907-d934.ngrok-free.app/api/Otp/CheckOtp?otp=';

  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEvent) {
      try {
        yield RegisterLoading();

        // Send OTP
        final response = await http.get(Uri.parse(sendOtpUrl + event.email));
        if (response.statusCode != 200) {
          throw Exception('OTP sending failed');
        }

        // Get OTP from response
        // (This implementation assumes the response contains the OTP)
        final otp = jsonDecode(response.body)['otp'];

        // Check OTP
        final checkOtpResponse = await http.get(Uri.parse(checkOtpUrl + otp));
        if (checkOtpResponse.statusCode != 200) {
          throw Exception('Invalid OTP');
        }

        // Register user
        final userResponse = await http.post(
          Uri.parse(
              'https://5321-2402-800-6370-5623-212e-b6d2-a907-d934.ngrok-free.app/Users/Register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
            event.toJson()..addAll({"roleid": 2}), // Add default role id
          ),
        );
        if (userResponse.statusCode != 200) {
          throw Exception('Registration failed');
        }

        // Parse user from response
        final user = User.fromJson(jsonDecode(userResponse.body));

        yield RegisterSuccess(user);
      } catch (e) {
        yield RegisterError(e.toString());
      }
    }
  }
}
