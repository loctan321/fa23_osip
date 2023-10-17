import 'package:flutter/material.dart';
import 'package:optimizing_stock_investment_portfolio/screens/widgets/input_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Register Page'),
                const SizedBox(height: 30),
                InputWidget(
                  hintText: 'Username',
                  obscureText: false,
                  controller: _usernameController,
                  obscureTex: false,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  hintText: 'Password',
                  obscureText: true,
                  controller: _passwordController,
                  obscureTex: true,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  hintText: 'Repeat Password',
                  obscureText: true,
                  controller: _repeatPasswordController,
                  obscureTex: true,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  hintText: 'Full Name',
                  obscureText: false,
                  controller: _fullNameController,
                  obscureTex: false,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  hintText: 'Date of Birth',
                  obscureText: false,
                  controller: _dateOfBirthController,
                  obscureTex: false,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Add your logic for handling registration here
                  },
                  child: const Text('Register'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
