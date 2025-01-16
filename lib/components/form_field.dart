import 'package:flutter/material.dart';

Widget Form({required String label}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: TextFormField(
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
        labelText: label,
      ),
    ),
  );
}
