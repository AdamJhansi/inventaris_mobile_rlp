import 'package:flutter/material.dart';

Widget FormText({required final initialValue, required final onChanged, final keyboardType}) {
  return TextFormField(
    initialValue: initialValue,
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
      labelText: 'Label',
    ),
    keyboardType: keyboardType,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Data Tidak Boleh Kosong';
      }
      return null;
    },
    onChanged: onChanged,
  );
}
