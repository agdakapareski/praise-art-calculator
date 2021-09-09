import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String suffixText;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.suffixText,
    required this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3.5),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
          ),
          suffixText: suffixText,
          isDense: true,
        ),
      ),
    );
  }
}
