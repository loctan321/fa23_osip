import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';

import 'models/option_chart_type.dart';

class DropDownOptionChartSelect extends StatelessWidget {
  const DropDownOptionChartSelect({
    super.key,
    this.initValue,
    required this.onChanged,
    this.border,
    this.isExpanded = false,
  });

  final int? initValue;
  final void Function(int? value) onChanged;
  final InputBorder? border;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 4),
      height: 40,
      decoration: BoxDecoration(
        color: context.appColor.colorGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: DropdownButton<OptionChartType>(
        isExpanded: isExpanded,
        hint: Text(
          'Trạng thái',
          style: context.textTheme.labelMedium?.copyWith(
            color: context.appColor.colorBlack.withOpacity(0.5),
          ),
        ),
        style: context.textTheme.labelMedium,
        value: initValue != null ? OptionChartType.from(initValue) : null,
        onChanged: (value) {
          onChanged(value?.value);
        },
        items: OptionChartType.values
            .map(
              (e) => DropdownMenuItem<OptionChartType>(
                value: e,
                child: Text(
                  e.name,
                  style: context.textTheme.bodySmall,
                ),
              ),
            )
            .toList(),
        icon: Icon(
          Icons.arrow_drop_down,
          size: 18,
          color: initValue != null
              ? null
              : context.appColor.colorBlack.withOpacity(0.5),
        ),
        underline: const SizedBox(),
      ),
    );
  }
}
