// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static const dbName = "myDabatase.db";
//   static const dbVersion = 1;
//   static const tableName = "myTable";
//   static const columnId = "id";
//   static const columnName = "name";

//   // constructor
//   static final DatabaseHelper instance = DatabaseHelper();

//   //database initialise

//   static Database? _database;

//   Future<Database?> get database async {
//     _database ??= await initDatabase();
//     return _database;
//   }

// //initialize database
//   initDatabase() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, dbName);
//     return await openDatabase(path, version: dbVersion, onCreate: onCreate);
//   }

//   Future onCreate(Database db, int version) async {
//     await db.execute(
//         '"CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL)'");
//   }

// //insert method
//   insert(Map<String, dynamic> row) async {
//     Database? db = await instance.database;
//     return await db!.insert(tableName, row);
//   }

// //read/ query method
//   Future<List<Map<String, dynamic>>> queryAll() async {
//     Database? db = await instance.database;
//     return await db!.query(tableName);
//   }

// //update method
//   Future<int> update(Map<String, dynamic> row) async {
//     Database? db = await instance.database;
//     return await db!.update(tableName, row,
//         where: '$columnId=?', whereArgs: [row[columnId]]);
//   }

// //delete method
//   Future<int> delete(int id) async {
//     Database? db = await instance.database;
//     return await db!.delete(tableName, where: '$columnId=?', whereArgs: [id]);
//   }
// }

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/notes.dart';

class NotesDatabase {
  static NotesDatabase instance = NotesDatabase._init();
  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes (
  ${NoteFields.id} $idType,
  ${NoteFields.isImportant} $boolType,
  ${NoteFields.number} $integerType,
  ${NoteFields.title} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType
  )
''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${NoteFields.time} ASC';
    //  final result =
    //      await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
