import 'package:flutter/material.dart';

import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/button/solid_button.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/popup/popup.dart';

import 'password_input.dart';

class PopupInputPassword extends StatefulWidget {
  const PopupInputPassword._();

  static Future<Map<String, String>?> show(BuildContext context) {
    return showAppModalBottomSheetV3<Map<String, String>>(
      context: context,
      child: const PopupInputPassword._(),
    );
  }

  @override
  State<PopupInputPassword> createState() => _PopupInputPasswordState();
}

class _PopupInputPasswordState extends State<PopupInputPassword> {
  String currentPasswordText = '';
  String newPasswordText = '';

  @override
  Widget build(BuildContext context) {
    return TitleBottomSheetAutoHeightWrapper(
      title: 'Change Password',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PasswordInput(
              hintText: 'Current Password',
              onChanged: (password) {
                setState(() {
                  currentPasswordText = password;
                });
              },
              isClear: true,
            ),
            PasswordInput(
              hintText: 'New Password',
              onChanged: (password) {
                setState(() {
                  newPasswordText = password;
                });
              },
              isClear: true,
            ),
            spaceH36,
            SizedBox(
              width: double.infinity,
              child: AppSolidButton.medium(
                onPressed:
                    currentPasswordText.isNotEmpty && newPasswordText.isNotEmpty
                        ? () {
                            Navigator.of(context).pop<Map<String, String>>(
                                {currentPasswordText: newPasswordText});
                          }
                        : null,
                'Submit',
              ),
            ),
            spaceH20,
          ],
        ),
      ),
    );
  }
}
