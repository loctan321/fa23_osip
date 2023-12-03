import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.readOnly = false,
    this.focusNode,
    this.onChanged,
    this.hintText = '',
  });

  final TextEditingController? controller;
  final void Function(String text)? onChanged;
  final FocusNode? focusNode;
  final bool readOnly;
  final String? hintText;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late Timer _debounce;

  void _onChangeText(String text) {
    if (_debounce.isActive) {
      _debounce.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // do something with query
      if (widget.onChanged != null) {
        widget.onChanged!(text);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _debounce = Timer(Duration.zero, () {});
  }

  @override
  void dispose() {
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ColoredBox(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 45.h,
                child: Center(
                  child: TextFormField(
                    autofocus: false,
                    focusNode: widget.focusNode,
                    onChanged: _onChangeText,
                    readOnly: widget.readOnly,
                    controller: widget.controller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: context.appColor.colorWhite,
                      focusColor: context.appColor.colorWhite,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: context.appColor.colorWhite,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      hintText: widget.hintText,
                      hintStyle: context.textTheme.bodyMedium?.copyWith(
                        color: context.appColor.colorBlack.withOpacity(0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: context.appColor.colorWhite,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
