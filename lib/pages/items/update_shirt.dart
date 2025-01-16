import 'package:flutter/material.dart';

import '../../db/db_helper.dart';
import '../../models/item_model.dart';

class EditShirtPage extends StatefulWidget {
  final Items item; // Mendapatkan item yang akan diedit

  const EditShirtPage({super.key, required this.item});

  @override
  _EditShirtPageState createState() => _EditShirtPageState();
}

class _EditShirtPageState extends State<EditShirtPage> {
  final _formKey = GlobalKey<FormState>();
  final ItemsRepository _itemsRepository = ItemsRepository();

  late String _label;
  late int _price;
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    // Menginisialisasi dengan data yang ada
    _label = widget.item.label;
    _price = widget.item.price;
    _imagePath = widget.item.imagePath;
  }

  // Fungsi untuk menyimpan perubahan ke database
  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final updatedItem = Items(
        id: widget.item.id,
        category: widget.item.category,
        label: _label,
        price: _price,
        imagePath: _imagePath,
      );
      await _itemsRepository.update(updatedItem);
      Navigator.pop(context, true); // Kembali dan beri tahu perubahan berhasil
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Edit Item'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _label,
                decoration: InputDecoration(labelText: 'Label'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a label';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _label = value;
                  });
                },
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _price = int.tryParse(value) ?? 0;
                  });
                },
              ),
              TextFormField(
                initialValue: _imagePath,
                decoration: InputDecoration(labelText: 'Image Path'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image path';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _imagePath = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
