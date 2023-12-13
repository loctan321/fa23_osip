import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:optimizing_stock_investment_portfolio/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
///ProfileScreen
class ProfileScreen extends StatelessWidget {
  // final User user;

  // const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: ListView(
        children: [
          // Profile Picture & Username
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  // backgroundImage: NetworkImage(user.imageUrl ?? ''),
                ),
                const SizedBox(width: 16.0),
                // Text(
                //   user.username,
                //   style: Theme.of(context).textTheme.headline6,
                // ),
              ],
            ),
          ),

          // Full Name & Email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Text(
                //   // user.fullName,
                //   // style: Theme.of(context).textTheme.subtitle1,
                // ),
                const SizedBox(height: 8.0),
                // Text(
                //   // user.email,
                //   style: Theme.of(context).textTheme.bodyText2,
                // ),
              ],
            ),
          ),

          // Account Details
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Registration Date'),
                    // subtitle: Text(user.registrationDate.toString()),
                  ),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Role'),
                    // subtitle: Text(user.role?.name ?? 'N/A'),
                  ),
                ],
              ),
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/edit_profile'),
                  child: Text('Edit Profile'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/change_password'),
                  child: Text('Change Password'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}