import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimizing_stock_investment_portfolio/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
with SingleTickerProviderStateMixin{

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen(),
      ),
      );
    }
    );
  }
  

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors:[ Colors.orange, Colors.orange],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            )
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(
            Icons.attach_money_outlined,
            size: 80,
            color: Colors.white,
            ), 
            SizedBox(height: 20),
             Text(
              'OSP',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 30,
              ),
              ),

          ],
        ),
      ),
    );
  }
}