import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:safety/models/Models.dart';

class DatabaseHandler {
  String databasesPath;
  Database database;

  Future<Database> onDbInit() async {
    databasesPath = await getDatabasesPath();
    databasesPath = join(databasesPath, 'Safety.db');
    // await deleteDatabase(databasesPath);
    database = await openDatabase(databasesPath, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Warning (id INTEGER PRIMARY KEY, statergy TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Coping (id INTEGER PRIMARY KEY, statergy TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Reasons (id INTEGER PRIMARY KEY, statergy TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Places (id INTEGER PRIMARY KEY, statergy TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Notes (id INTEGER PRIMARY KEY, statergy TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Contacts (id INTEGER PRIMARY KEY, name TEXT, number INTEGER)');
    });
    return database;
  }

  getItemCount(Database database, String table) async {
    final String query = "SELECT COUNT(*) FROM " + table;
    var count = Sqflite.firstIntValue(await database.rawQuery(query));
    return count;
  }

  insertUnversal(Database database, String table, UnversalModel data) async {
    if (database.isOpen) {
      return await database.insert(table, data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  updateUniversal(Database database, String table, UnversalModel data) async {
    if (database.isOpen) {
      await database
          .update(table, data.toMap(), where: "id = ?", whereArgs: [data.id]);
    }
  }

  deleteUniversal(Database database, String table, int id) async {
    if (database.isOpen) {
      return await database.delete(table, where: "id = ?", whereArgs: [id]);
    }
  }

  insertContact(Database database, String table, Contacts data) async {
    if (database.isOpen) {
      await database.insert(table, data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  updateContact(Database database, String table, Contacts data) async {
    if (database.isOpen) {
      await database
          .update(table, data.toMap(), where: "id = ?", whereArgs: [data.id]);
    }
  }

  Future<int> getLastID(Database database, String table) async {
    final String query = "SELECT * FROM " + table + " ORDER BY id DESC LIMIT 1";
    final List<Map<String, dynamic>> data = await database.rawQuery(query);

    return data[0]['id'];
  }

  Future<List<UnversalModel>> getListData(
      Database database, String table) async {
    final List<Map<String, dynamic>> data = await database.query(table);

    return List.generate(data.length, (index) {
      return UnversalModel(
          id: data[index]['id'], statergy: data[index]['statergy']);
    });
  }

  Future<List<Contacts>> getListDataContacts(
      Database database, String table) async {
    final List<Map<String, dynamic>> data = await database.query(table);

    return List.generate(data.length, (index) {
      return Contacts(
          id: data[index]['id'],
          name: data[index]['name'],
          number: data[index]['number']);
    });
  }
}
