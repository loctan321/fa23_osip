import 'package:flutter/material.dart';
import 'package:optimizing_stock_investment_portfolio/screens/widgets/input_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
        const Text('Login Page'),
        const SizedBox(height: 30,),
        InputWidget(
        hintText: 'Email',
        obscureTex: false,
        controller: _emailController,
      ),
       const SizedBox(height: 30,),
        InputWidget(
          hintText: 'Password',
          obscureTex: true,
          controller: _passwordController,
          

        ),
        const SizedBox(height: 30,),
        ElevatedButton(
          onPressed: (){},
           child: const Text('Login'),
           style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 50)
           ),)

      ]),
     ),
    );
  }
}