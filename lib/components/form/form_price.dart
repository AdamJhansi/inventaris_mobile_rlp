import 'package:flutter/material.dart';

Widget FormPrice({required final priceController}) {
  return TextFormField(
    controller: priceController,
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
      labelText: 'Harga',
    ),
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Harga tidak boleh kosong';
      }
      if (int.tryParse(value) == null) {
        return 'Harga harus berupa angka';
      }
      return null;
    },
  );
}
