import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/note_model.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  AddEditNoteScreen({this.note});

  @override
  _AddEditNoteScreenState createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String content = '';
  late DatabaseHelper databaseHelper;
  final NotesRepository _notesHelper = NotesRepository();

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper.instance;
    if (widget.note != null) {
      title = widget.note!.title;
      content = widget.note!.content;
    }
  }

  void saveNote() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.note == null) {
        await _notesHelper.insertNote(Note(title: title, content: content));
      } else {
        await _notesHelper.updateNote(Note(id: widget.note!.id, title: title, content: content));
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
                onSaved: (value) => title = value!,
              ),
              TextFormField(
                initialValue: content,
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) => value!.isEmpty ? 'Enter content' : null,
                onSaved: (value) => content = value!,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: saveNote,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
