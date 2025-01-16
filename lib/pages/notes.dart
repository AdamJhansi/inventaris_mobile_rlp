import 'package:flutter/material.dart';
import 'package:inventaris_mobile/components/text_styles.dart';

import '../db/db_helper.dart';
import '../models/note_model.dart';
import 'notes_add.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  late DatabaseHelper dbHelper;
  List<Note> notes = [];
  final NotesRepository _notesHelper = NotesRepository();

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    fetchNotes();
  }

  void fetchNotes() async {
    final data = await _notesHelper.fetchNotes();
    setState(() {
      notes = data;
    });
  }

  void deleteNote(int id) async {
    await _notesHelper.deleteNote(id);
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final Color? bottonNavBgColor = Colors.blueGrey[300];

    return Scaffold(
      appBar: AppBar(
        title: Text('Catatan'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(notes[index].title),
              subtitle: Text(notes[index].content),
              onTap: () async {
                final updated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditNoteScreen(note: notes[index]),
                  ),
                );
                if (updated == true) fetchNotes();
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteNote(notes[index].id!),
              ));
        },
      ),
      floatingActionButton: Container(
        width: 160,
        height: 50,
        margin: EdgeInsets.only(bottom: 100, right: 60),
        child: FloatingActionButton(
          backgroundColor: bottonNavBgColor?.withOpacity(0.8),
          onPressed: () async {
            final updated = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditNoteScreen(),
              ),
            );
            if (updated == true) fetchNotes();
          },
          child: Text(
            "+  Tambah Catatan",
            style: AppTextStyles.regular(color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
