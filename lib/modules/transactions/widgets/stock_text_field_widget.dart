import 'package:flutter/material.dart';

/// Modern Stock Text Field Widget
Widget stockTextFieldWidget(
    TextEditingController ctrl,
    String label, {
      TextInputType keyboard = TextInputType.text,
      int maxLines = 1,
      String? hintText,
      bool isEnabled = true,
    }) {
  return TextFormField(
    controller: ctrl,
    keyboardType: keyboard,
    maxLines: maxLines,
    enabled: isEnabled,
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
    ),
  );
}