import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../db/db_helper.dart';
import '../../models/item_model.dart';

class AddShirt extends StatefulWidget {
  @override
  _AddShirtState createState() => _AddShirtState();
}

class _AddShirtState extends State<AddShirt> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _imageFile;
  final ItemsRepository _repository = ItemsRepository();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<void> _saveToDatabase() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      final String label = _labelController.text;
      final int price = int.parse(_priceController.text);
      final String imagePath = _imageFile!.path;
      const String category = "baju";

      final items = Items(
        label: label,
        price: price,
        imagePath: imagePath,
        category: category,
      );
      await _repository.insert(items);

      // Tampilkan notifikasi berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil disimpan!')),
      );

      // Reset form
      _labelController.clear();
      _priceController.clear();
      setState(() {
        _imageFile = null;
      });
    } else if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Silakan pilih gambar terlebih dahulu!')),
      );
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
        title: Text('Tambah Baju'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Tambah Baju',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _labelController,
                  decoration: InputDecoration(
                    fillColor: Color(0xffF1F0F5),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Label',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Label tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    fillColor: Color(0xffF1F0F5),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Harga',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga tidak boleh kosong';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harga harus berupa angka';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Pilih Gambar'),
                    ),
                    SizedBox(width: 20),
                    if (_imageFile != null) Text('Gambar dipilih', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _saveToDatabase,
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
