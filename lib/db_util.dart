import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Open the database and store the reference.
final database = openDB();

Future<Database> openDB() async {
  return openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'zenith_db.sqlite3'),
  );
}

// Insert database function
Future<void> insert(var record, String table) async {
  // Get a reference to the database.
  final db = await database;

  // `conflictAlgorithm` if same tuple is inserted twice.
  await db.insert(
    table,
    record.toMap(),
    conflictAlgorithm: ConflictAlgorithm.abort,
  );
}

// Retrieve from table function
Future<List<dynamic>> retrieve(String table, Function convert) async {
  // Get a reference to the database.
  final db = await database;

  // Query the table.
  final List<Map<String, dynamic>> maps = await db.query(table);

  return List.generate(maps.length, (i) {
    convert(maps, i);
  });
}

Future<void> update(var record, String table, var identifier) async {
  // Get a reference to the database.
  final db = await database;

  // Update function.
  await db.update(
    table,
    record.toMap(),
    // Ensure that the object has a matching id.
    where: 'id = ?',
    // Pass the id as a whereArg to prevent SQL injection.
    whereArgs: [identifier],
  );
}

class User {
  final String username;
  final String password;

  const User({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'pw': password,
    };
  }

  static User convert(List<Map<String, dynamic>> maps, int i) {
    return User(
      username: maps[i]['username'] as String,
      password: maps[i]['pw'] as String,
    );
  }
}

class Workspace {
  final int id;
  final String title;
  final String description;

  const Workspace({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  static Workspace convert(List<Map<String, dynamic>> maps, int i) {
    return Workspace(
      id: maps[i]['id'] as int,
      title: maps[i]['title'] as String,
      description: maps[i]['description'] as String,
    );
  }
}
