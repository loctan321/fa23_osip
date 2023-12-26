import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.maxLines,
  });

  final String hintText;
  final void Function(String) onChanged;
  final int? maxLines;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _inputController,
      onChanged: (value) {
        widget.onChanged(value);
      },
      maxLines: widget.maxLines ?? 1,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: widget.hintText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
