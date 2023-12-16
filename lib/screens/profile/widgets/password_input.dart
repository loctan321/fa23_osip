import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimizing_stock_investment_portfolio/helper/context.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    this.hintText = 'Password',
    this.valueMatching,
    required this.onChanged,
    this.isClear,
  });

  final String hintText;
  final String? valueMatching;
  final void Function(String) onChanged;
  final bool? isClear;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final _inputController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();

    if (widget.isClear == true) {
      _inputController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _inputController,
      onChanged: (value) {
        widget.onChanged(value);
      },
      keyboardType: TextInputType.multiline,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: const Icon(Icons.lock_outline),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 0,
          maxHeight: 16.h,
        ),
        hintText: widget.hintText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        suffixIcon: GestureDetector(
          child: Icon(
            _passwordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: context.appColor.colorBlack,
          ),
          onTap: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 0,
          maxHeight: 16.h,
        ),
      ),
    );
  }
}
