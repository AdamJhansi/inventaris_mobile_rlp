import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/form/form_label.dart';
import '../../../components/form/form_price.dart';
import '../../../db/db_helper.dart';
import '../../../models/item_model.dart';

class AddPants extends StatefulWidget {
  const AddPants({super.key});

  @override
  _AddPantsState createState() => _AddPantsState();
}

class _AddPantsState extends State<AddPants> {
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
      const String category = "celana";

      final items = Items(
        label: label,
        price: price,
        imagePath: imagePath,
        category: category,
      );
      await _repository.insert(items);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil disimpan!')),
      );

      _labelController.clear();
      _priceController.clear();
      setState(() {
        _imageFile = null;
      });
    } else if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih gambar terlebih dahulu!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Tambah Celana',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                FormLabel(labelController: _labelController),
                const SizedBox(height: 16),
                FormPrice(priceController: _priceController),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Pilih Gambar'),
                    ),
                    const SizedBox(width: 20),
                    if (_imageFile != null) const Text('Gambar dipilih', style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _saveToDatabase,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
