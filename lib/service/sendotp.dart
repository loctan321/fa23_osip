import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SendOtpService {
  Future<bool> sendOtp(String email) async {
     //https://10.0.2.2:7053/api/Stocks/
    final url = 'https://10.0.2.2:7053/api/Email/SendOtp';
    final data = {'toEmail': email};

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['isSuccess'] == true) {
        return true;
      } else {
        print('OTP sending failed: ${responseData['errorMessage']}');
        return false;
      }
    } else {
      print('OTP sending failed: ${response.statusCode}');
      return false;
    }
  }
}
