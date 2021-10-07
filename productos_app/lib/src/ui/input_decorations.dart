import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) =>
      InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.deepPurple)
              : null);
}
