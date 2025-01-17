import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventaris_mobile/components/text_styles.dart';
import 'package:inventaris_mobile/db/db_helper.dart';
import 'package:inventaris_mobile/models/item_model.dart';
import 'package:inventaris_mobile/pages/items/update/update_shirt.dart';
import 'package:inventaris_mobile/pages/master.dart';

import 'add/add_shirt.dart';

class ShirtPage extends StatefulWidget {
  const ShirtPage({super.key});

  @override
  State<ShirtPage> createState() => _ShirtPageState();
}

class _ShirtPageState extends State<ShirtPage> {
  final ItemsRepository _itemsRepository = ItemsRepository();
  List<Items> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    final items = await _itemsRepository.getByCategories(["baju"]);
    setState(() {
      _items = items;
      _isLoading = false;
    });
  }

  Future<void> _refreshItems() async {
    await _fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text("T-Shirt"),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(child: Text('Tidak Ada Barang :)'))
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
                builder: (context) => const AddShirt(),
              ),
            );
            if (updated == true) {
              await _refreshItems();
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
