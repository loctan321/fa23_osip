import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:optimizing_stock_investment_portfolio/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';




class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
 


class _ProfileScreenState extends State<ProfileScreen> {
  
  String _userName = '';
  String _userEmail = '';
 
  @override
  void initState() {
    
    super.initState();
    _fetchUserProfile();
    
  }
//https://10.0.2.2:7053/Users/GetById
Future<void> _fetchUserProfile() async {
    final token = await SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('token');
    });

    try {
      final response = await Dio().get('https://10.0.2.2:7053/Users/GetById',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        final responseData = response.data;
        setState(() {

          _userName = responseData['username'];
          _userEmail = responseData['email'];
         
        });
      } else {
        print('Profile fetch failed: ${response.statusCode}');
      }
    } catch (error) {
      print('Profile fetch error: $error');
    }
  }
  @override
  Widget build(BuildContext context) {

   return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Name: $_userName',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Email: $_userEmail',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            
            
          ],
       
          
        ),
      ),
      
    );
    }
  }
