import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventaris_mobile/components/text_styles.dart';
import 'package:inventaris_mobile/db/db_helper.dart';
import 'package:inventaris_mobile/models/item_model.dart';
import 'package:inventaris_mobile/pages/items/update/update_jacket.dart';
import 'package:inventaris_mobile/pages/master.dart';

import 'add/add_jacket.dart';

class JacketPage extends StatefulWidget {
  const JacketPage({super.key});

  @override
  State<JacketPage> createState() => _JacketPageState();
}

class _JacketPageState extends State<JacketPage> {
  final ItemsRepository _itemsRepository = ItemsRepository();
  List<Items> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    final items = await _itemsRepository.getByCategories(["jaket"]);
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
          child: Text("Jacket"),
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
                                builder: (context) => EditJacketPage(item: item),
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
                builder: (context) => const AddJacket(),
              ),
            );
            if (updated == true) {
              await _refreshItems();
            }
          },
          child: Text(
            "+  Tambah Jaket",
            style: AppTextStyles.regular(color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
