import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/date_time.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/popup/popup.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.initialDate,
    this.min,
  });
  final String labelText;
  final DateTime? initialDate;
  final void Function(DateTime date) onChanged;
  final DateTime? min;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialogDatePicker(
        title: labelText,
        selected: initialDate,
        context: context,
        callback: onChanged,
        min: min,
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 4),
        height: 40,
        decoration: BoxDecoration(
          color: context.appColor.colorGrey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4.r),
          // border: Border.all(width: 0.2),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              initialDate != null
                  ? Text(
                      initialDate!.format(pattern: yyyy_mm_dd),
                      style: context.textTheme.labelMedium,
                    )
                  : Text(
                      labelText,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.appColor.colorBlack.withOpacity(0.5),
                      ),
                    ),
              Icon(
                Icons.calendar_today,
                size: 18,
                color: context.appColor.colorBlack.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
