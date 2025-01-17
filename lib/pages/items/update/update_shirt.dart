import 'package:flutter/material.dart';

import '../../../components/form/form_regular.dart';
import '../../../db/db_helper.dart';
import '../../../models/item_model.dart';

class EditShirtPage extends StatefulWidget {
  final Items item;

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
    _label = widget.item.label;
    _price = widget.item.price;
    _imagePath = widget.item.imagePath;
  }

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
      Navigator.pop(context, true);
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
        padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormText(
                  initialValue: _label,
                  onChanged: (value) {
                    setState(() {
                      _label = value;
                    });
                  },
                  labelText: "label"),
              SizedBox(
                height: 20,
              ),
              FormText(
                  initialValue: _price.toString(),
                  keyboardType: TextInputType.number,
                  labelText: "Harga",
                  onChanged: (value) {
                    setState(() {
                      _price = int.tryParse(value) ?? 0;
                    });
                  }),
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
