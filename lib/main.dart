import "package:flutter/material.dart";
import "package:inventaris_mobile/pages/master.dart";

void main() => runApp(InventarisMobile());

class InventarisMobile extends StatelessWidget {
  const InventarisMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InventarisMobileRpl',
      theme: ThemeData.light(),
      home: MasterPage(),
    );
  }
}
