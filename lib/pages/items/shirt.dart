import 'package:flutter/material.dart';

import '../../components/card_subheader.dart';

class ShirtPage extends StatelessWidget {
  const ShirtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("T-Shirt"),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardSubHeader(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardSubHeader(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardSubHeader(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardSubHeader(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardSubHeader(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardSubHeader(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardSubHeader(),
            ),
          ],
        ),
      ),
    );
  }
}
