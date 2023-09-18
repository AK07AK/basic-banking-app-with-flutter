import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String hintName;
  final Function onChanged;
  final bool keyboardTypeNumber;

  CustomTextBox(
      {required this.hintName,
        required this.onChanged,
        required this.keyboardTypeNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        keyboardType:
        keyboardTypeNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          hintText: hintName,
          border: InputBorder.none,
          hintStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}