import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/date_time.dart';
import 'package:optimizing_stock_investment_portfolio/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_bloc.dart';
import 'profile_state.dart';
import 'widgets/popup_input_password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ProfileBloc()..getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) =>
            previous.isChangePassword != current.isChangePassword &&
            current.isChangePassword,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.messageChangePassword)),
          );
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('My Profile'),
              ),
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 50.r,
                              width: 50.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.appColor.colorBlue,
                              ),
                            ),
                            Text(
                              state.avatar ?? '',
                              style: context.textTheme.titleLarge?.copyWith(
                                color: context.appColor.colorWhite,
                                fontSize: 36,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          'Hello ${state.userData?.fullName}',
                          style: context.textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),

                  Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.calendar_today),
                            title: const Text('Registration Date'),
                            subtitle: Text(state.userData != null &&
                                    state.userData?.registrationDate != null
                                ? state.userData!.registrationDate!
                                    .format(pattern: yyyy_mm_dd)
                                : ''),
                          ),
                          ListTile(
                            leading: const Icon(Icons.email_outlined),
                            title: const Text('Email'),
                            subtitle: Text(state.userData?.email ?? ''),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/edit_profile'),
                          child: const Text('Edit Name'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final password = await PopupInputPassword.show(
                              context,
                            );
                            if (password != null) {
                              bloc.onChangePassword(
                                currentPassword: password.entries.first.key,
                                newPassword: password.entries.first.value,
                              );
                            }
                          },
                          child: const Text('Change Password'),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: 1.sw / 4,
                      right: 1.sw / 4,
                      left: 1.sw / 4,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        // Clear all stored data
                        await prefs.clear();

                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      },
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
