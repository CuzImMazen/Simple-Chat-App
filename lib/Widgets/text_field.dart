import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.hintText,
    required this.onChanged,
    required this.hide,
  });
  final String hintText;
  final bool hide;
  Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hide,
      validator: (value) {
        if (value!.isEmpty) {
          return 'this field is required';
        }
      },
      onChanged: onChanged,
      cursorColor: Colors.white,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
        decorationThickness: 0,
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
          decorationThickness: 0,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
