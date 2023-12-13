import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';

import 'models/sort_column_type.dart';

class DropDownSortColumnSelect extends StatelessWidget {
  const DropDownSortColumnSelect({
    super.key,
    this.initValue,
    required this.onChanged,
    this.border,
    this.isExpanded = false,
  });

  final String? initValue;
  final void Function(String? value) onChanged;
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
      child: DropdownButton<SortColumnType>(
        isExpanded: isExpanded,
        hint: Text(
          'Sort Column',
          style: context.textTheme.labelMedium?.copyWith(
            color: context.appColor.colorBlack.withOpacity(0.5),
          ),
        ),
        style: context.textTheme.labelMedium,
        value: initValue != null ? SortColumnType.from(initValue) : null,
        onChanged: (value) {
          onChanged(value?.value);
        },
        items: SortColumnType.values
            .map(
              (e) => DropdownMenuItem<SortColumnType>(
                value: e,
                child: Text(
                  e.value,
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
