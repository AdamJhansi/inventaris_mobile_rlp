import 'package:flutter/material.dart';

Widget doubleCircle() {
  return Stack(
    children: [
      Positioned(
        top: 0,
        right: -120,
        child: CircleAvatar(
          radius: 120,
          backgroundColor: Colors.white.withOpacity(0.1),
        ),
      ),
      Positioned(
        top: 200,
        right: -80,
        child: CircleAvatar(
          radius: 150,
          backgroundColor: Colors.white.withOpacity(0.1),
        ),
      ),
    ],
  );
}
