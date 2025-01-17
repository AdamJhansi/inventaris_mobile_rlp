import 'package:flutter/material.dart';

Widget FormLabel({required final labelController}) {
  return TextFormField(
    controller: labelController,
    decoration: InputDecoration(
      fillColor: Color(0xffF1F0F5),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(),
      ),
      labelText: "Label",
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Label tidak boleh kosong';
      }
      return null;
    },
  );
}
