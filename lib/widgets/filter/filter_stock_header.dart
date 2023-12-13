import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';
import 'package:optimizing_stock_investment_portfolio/helper/spaces.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/input/date_picker.dart';
import 'package:optimizing_stock_investment_portfolio/widgets/input/drop_down/drop_down_sort_column_select.dart';

class FilterStockHeader extends StatefulWidget {
  const FilterStockHeader({
    super.key,
    this.date,
    required this.sortColumn,
    required this.sortDirection,
    required this.onChangeDate,
    required this.onChangeSortColumn,
    required this.onChangeSortDirection,
  });

  final DateTime? date;
  final String sortColumn;
  final bool sortDirection;

  final void Function(DateTime?) onChangeDate;
  final void Function(String) onChangeSortColumn;
  final VoidCallback onChangeSortDirection;

  @override
  State<FilterStockHeader> createState() => _FilterStockHeaderState();
}

class _FilterStockHeaderState extends State<FilterStockHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: context.appColor.colorWhite,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        child: Row(
          children: [
            Expanded(
              child: DatePicker(
                labelText: 'Date release',
                initialDate: widget.date,
                onChanged: (date) {
                  widget.onChangeDate(date);
                },
              ),
            ),
            spaceW8,
            Expanded(
              child: DropDownSortColumnSelect(
                initValue: widget.sortColumn,
                onChanged: (value) {
                  if (value != null) {
                    widget.onChangeSortColumn(value);
                  }
                },
                isExpanded: true,
              ),
            ),
            spaceW8,
            InkWell(
              onTap: () {
                widget.onChangeSortDirection.call();
              },
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: widget.sortDirection
                      ? context.appColor.colorBlue
                      : context.appColor.colorGrey,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(
                  Icons.sort_by_alpha_rounded,
                  color: context.appColor.colorWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
