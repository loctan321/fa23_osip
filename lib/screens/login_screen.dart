// ignore: avoid_web_libraries_in_flutter
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:optimizing_stock_investment_portfolio/screens/profile_screen.dart';
import 'package:optimizing_stock_investment_portfolio/screens/widgets/input_widget.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final Logger _logger = Logger();

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final url = Uri.parse('https://localhost:7053/swagger/index.html');
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Login successful, handle response here
      _logger.i('Login successful');
      Navigator.push(context as BuildContext,
          MaterialPageRoute(builder: (context) => const ProfileScreen()));
    } else {
      // Login failed, handle error here
      _logger.e('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Login Page'),
          const SizedBox(
            height: 30,
          ),
          InputWidget(
            hintText: 'Username',
            obscureTex: false,
            controller: _usernameController,
          ),
          const SizedBox(
            height: 30,
          ),
          InputWidget(
            hintText: 'Password',
            obscureTex: true,
            controller: _passwordController,
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 50)),
            child: const Text('Login'),
          )
        ]),
      ),
    );
  }
}
