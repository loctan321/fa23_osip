import 'package:flutter/material.dart';

import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/button/solid_button.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/popup/popup.dart';

import 'text_input.dart';

class CreatePostPopup extends StatefulWidget {
  const CreatePostPopup._();

  static Future<Map<String, String>?> show(BuildContext context) {
    return showAppModalBottomSheetV3<Map<String, String>>(
      context: context,
      child: const CreatePostPopup._(),
    );
  }

  @override
  State<CreatePostPopup> createState() => _CreatePostPopupState();
}

class _CreatePostPopupState extends State<CreatePostPopup> {
  String titleText = '';
  String contentText = '';

  @override
  Widget build(BuildContext context) {
    return TitleBottomSheetAutoHeightWrapper(
      title: 'Create Post',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextInput(
              hintText: 'Title',
              onChanged: (value) {
                setState(() {
                  titleText = value;
                });
              },
            ),
            spaceH12,
            TextInput(
              hintText: 'Content',
              onChanged: (value) {
                setState(() {
                  contentText = value;
                });
              },
              maxLines: 5,
            ),
            spaceH36,
            SizedBox(
              width: double.infinity,
              child: AppSolidButton.medium(
                onPressed: titleText.isNotEmpty && contentText.isNotEmpty
                    ? () {
                        Navigator.of(context)
                            .pop<Map<String, String>>({titleText: contentText});
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
