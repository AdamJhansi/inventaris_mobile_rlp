import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item_model.dart';
import '../models/note_model.dart';

class DatabaseHelper {
  static const _databaseName = "inventory_mobile_rpl.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT, 
        content TEXT 
       );
    ''');
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL,
        label TEXT NOT NULL,
        price INTEGER NOT NULL,
        imagePath TEXT NOT NULL
      );
    ''');
  }
}

// CRUD NOTE
class NotesRepository {
  Future<int> insertNote(Note note) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<Note>> fetchNotes() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<int> updateNote(Note note) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}

// CRUD ITEMS
class ItemsRepository {
  final _tableName = 'items';

  Future<int> insert(Items items) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert(_tableName, items.toMap());
  }

  Future<List<Items>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(_tableName);
    return result.map((map) => Items.fromMap(map)).toList();
  }

  Future<int> update(Items items) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      _tableName,
      items.toMap(),
      where: 'id = ?',
      whereArgs: [items.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getCount(String category) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM $_tableName WHERE category = ?', [category]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<Items>> getByCategories(List<String> categories) async {
    final db = await DatabaseHelper.instance.database;
    final placeholders = List.filled(categories.length, '?').join(', ');
    final result = await db.query(
      _tableName,
      where: 'category IN ($placeholders)',
      whereArgs: categories,
    );
    return result.map((map) => Items.fromMap(map)).toList();
  }

// void fetchItemsByCategories() async {
//   final itemsRepository = ItemsRepository();
//   final categories = ['baju', 'celana', 'jaket'];
//   final items = await itemsRepository.getByCategories(categories);
//   for (var item in items) {
//     print('Item: ${item.label}, Category: ${item.category}');
//   }
// }
}
