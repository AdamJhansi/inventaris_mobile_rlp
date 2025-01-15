import 'package:flutter/material.dart';

class AppTextStyles {
  // Header Style
  static TextStyle header({required Color color}) {
    return TextStyle(
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.normal,
      fontFamily: 'Open Sans',
      fontSize: 40,
      color: color,
    );
  }

  // Regular Text Style
  static TextStyle regular({required Color color}) {
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  // Subtitle Style
  static TextStyle title({required Color color}) {
    return TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  // Subtitle Style
  static TextStyle subtitle({required Color color}) {
    return TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }
}

/// Contoh Penggunaan
/// style: AppTextStyles.header(color: Colors.blue)
