import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  void Function(String)? onChanged;
  final String labelText;
  TextInputType textInputType;
  CustomTextField({
    required this.labelText,
    required this.onChanged,
    this.textInputType = TextInputType.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(labelText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      keyboardType: textInputType,
      onChanged: onChanged,
    );
  }
}
