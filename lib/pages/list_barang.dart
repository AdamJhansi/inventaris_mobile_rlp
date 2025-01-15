import "package:flutter/material.dart";

import "../components/card_header.dart";
import "../components/card_subheader.dart";
import "../components/text_styles.dart";

class ListBarangPage extends StatelessWidget {
  const ListBarangPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // TODO : BUAT APP BAR YANG BAGUS
        title: Text(
          'Daftar Barang',
          style: AppTextStyles.header(color: Colors.blueGrey),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardHeader(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardHeader(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardSubHeader(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardHeader(),
            ),
          ],
        ),
      ),
    );
  }
}
