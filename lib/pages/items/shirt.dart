import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventaris_mobile/pages/items/update_shirt.dart';

import '../../components/text_styles.dart';
import '../../db/db_helper.dart';
import '../../models/item_model.dart';
import '../master.dart';
import 'add_shirt.dart';

class ShirtPage extends StatefulWidget {
  const ShirtPage({super.key});

  @override
  State<ShirtPage> createState() => _ShirtPageState();
}

class _ShirtPageState extends State<ShirtPage> {
  final ItemsRepository _itemsRepository = ItemsRepository(); // Instance of repository
  List<Items> _items = []; // List to hold items from the database
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchItems(); // Fetch items on page load
  }

  // Fetch items from the database
  Future<void> _fetchItems() async {
    final items = await _itemsRepository.getAll();
    setState(() {
      _items = items;
      _isLoading = false;
    });
  }

  // Refresh data after adding a new item
  Future<void> _refreshItems() async {
    await _fetchItems();
  }

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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? Center(child: Text('No items found'))
              : RefreshIndicator(
                  onRefresh: _refreshItems,
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          onTap: () async {
                            // Navigasi ke halaman Edit
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditShirtPage(item: item),
                              ),
                            );
                            if (result == true) {
                              _refreshItems();
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.file(
                                      File(item.imagePath),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(height: 5),
                                          Text(
                                            item.label,
                                            style: AppTextStyles.title(color: Colors.blueGrey),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "Harga: Rp ${item.price}",
                                            style: AppTextStyles.subtitle(color: Colors.blueGrey),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: Container(
        width: 160,
        height: 50,
        margin: const EdgeInsets.only(bottom: 30, right: 30),
        child: FloatingActionButton(
          backgroundColor: bottonNavBgColor?.withOpacity(0.8),
          onPressed: () async {
            final updated = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddShirt(),
              ),
            );
            if (updated == true) {
              await _refreshItems(); // Refresh items if new item added
            }
          },
          child: Text(
            "+  Tambah Baju",
            style: AppTextStyles.regular(color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
