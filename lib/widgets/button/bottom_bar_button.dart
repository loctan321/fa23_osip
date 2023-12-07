import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/shadows.dart';
import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({
    super.key,
    required this.button1,
    this.button2,
    this.widgetOnButton,
  });

  final Widget button1;
  final Widget? button2;
  final Widget? widgetOnButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        boxShadow: shadowE1,
        color: context.appColor.colorWhite,
      ),
      child: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widgetOnButton != null) ...[
              widgetOnButton!,
            ],
            Row(
              children: [
                Expanded(
                  child: button1,
                ),
                if (button2 != null) ...[
                  spaceW16,
                  Expanded(
                    child: button2!,
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
