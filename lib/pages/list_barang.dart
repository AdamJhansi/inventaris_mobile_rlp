import "package:flutter/material.dart";
import "package:inventaris_mobile/pages/items/jacket.dart";
import "package:inventaris_mobile/pages/items/pants.dart";
import "package:inventaris_mobile/pages/items/shirt.dart";

import "../components/cards/card_header.dart";
import "../db/db_helper.dart";

class ListBarangPage extends StatefulWidget {
  const ListBarangPage({super.key});

  @override
  State<ListBarangPage> createState() => _ListBarangPageState();
}

class _ListBarangPageState extends State<ListBarangPage> {
  int _totalBaju = 0;
  int _totalCelana = 0;
  int _totalJaket = 0;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final repository = ItemsRepository();
    final totalBaju = await repository.getCount('baju');
    final totalCelana = await repository.getCount('celana');
    final totaljaket = await repository.getCount('jaket');
    setState(() {
      _totalBaju = totalBaju;
      _totalCelana = totalCelana;
      _totalJaket = totaljaket;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // TODO : BUAT APP BAR YANG BAGUS
        title: const Text(
          'Daftar Barang',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardHeader(
                imagePath: 'assets/baju.jpg',
                title: 'B a j u',
                description: 'Total Baju : $_totalBaju',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShirtPage()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardHeader(
                imagePath: 'assets/celana.png',
                title: 'C e l a n a',
                description: 'Total Celana : $_totalCelana',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PantsPage()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardHeader(
                imagePath: 'assets/jaket.jpg',
                title: 'J a k e t',
                description: 'Total Jaket : $_totalJaket',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const JacketPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
