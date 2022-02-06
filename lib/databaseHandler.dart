import 'package:my_safety/view/Appointments.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:my_safety/models/Models.dart';

class DatabaseHandler {
  String databasesPath;
  Database database;

  Future<Database> onDbInit() async {
    databasesPath = await getDatabasesPath();
    databasesPath = join(databasesPath, 'Safety.db');
    //await deleteDatabase(databasesPath);
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
          'CREATE TABLE IF NOT EXISTS Places (id INTEGER PRIMARY KEY, statergy TEXT, landmark TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Notes (id INTEGER PRIMARY KEY, statergy TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Contacts (id INTEGER PRIMARY KEY, name TEXT, number INTEGER)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS ContactsP (id INTEGER PRIMARY KEY, name TEXT, number INTEGER)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Environment (id INTEGER PRIMARY KEY,  statergy TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Medications (id INTEGER PRIMARY KEY, tabName TEXT, dateTime TEXT)');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Appointments (id INTEGER PRIMARY KEY, docName TEXT, dateTime TEXT)');
    });
    Contacts data = Contacts(
        id: 0,
        name: 'National Suicide Prevention Lifeline',
        number: 18002738255);
    insertContact(database, 'ContactsP', data);
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

  insertPlaces(Database database, String table, PlacesModel data) async {
    if (database.isOpen) {
      return await database.insert(table, data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  insertMedication(Database database, MedicationsModel data) async {
    if (database.isOpen) {
      return await database.insert('Medications', data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  updateMedication(Database database, MedicationsModel data) async {
    if (database.isOpen) {
      await database.update('Medications', data.toMap(),
          where: "id = ?", whereArgs: [data.id]);
    }
  }

  insertAppointment(Database database, AppointmentsModel data) async {
    if (database.isOpen) {
      return await database.insert('Appointments', data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  updateAppointment(Database database, AppointmentsModel data) async {
    if (database.isOpen) {
      await database.update('Appointments', data.toMap(),
          where: "id = ?", whereArgs: [data.id]);
    }
  }

  updateUniversal(Database database, String table, UnversalModel data) async {
    if (database.isOpen) {
      await database
          .update(table, data.toMap(), where: "id = ?", whereArgs: [data.id]);
    }
  }

  updatePlaces(Database database, String table, PlacesModel data) async {
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
    final String query =
        "SELECT id FROM " + table + " ORDER BY id DESC LIMIT 1";
    var count = Sqflite.firstIntValue(await database.rawQuery(query));
    if (count != null) {
      return count;
    }
    return 0;
  }

  Future<List<UnversalModel>> getListData(
      Database database, String table) async {
    final List<Map<String, dynamic>> data = await database.query(table);

    return List.generate(data.length, (index) {
      return UnversalModel(
          id: data[index]['id'], statergy: data[index]['statergy']);
    });
  }

  Future<List<PlacesModel>> getListDataPlaces(
      Database database, String table) async {
    final List<Map<String, dynamic>> data = await database.query(table);

    return List.generate(data.length, (index) {
      return PlacesModel(
          id: data[index]['id'],
          statergy: data[index]['statergy'],
          landmark: data[index]['landmark']);
    });
  }

  Future<List<AppointmentsModel>> getListAppointments(Database database) async {
    final List<Map<String, dynamic>> data =
        await database.query('Appointments');

    return List.generate(data.length, (index) {
      return AppointmentsModel(
          id: data[index]['id'],
          docName: data[index]['docName'],
          dateTime: data[index]['dateTime']);
    });
  }

  Future<List<MedicationsModel>> getListMedications(Database database) async {
    final List<Map<String, dynamic>> data = await database.query('Medications');

    return List.generate(data.length, (index) {
      return MedicationsModel(
          id: data[index]['id'],
          tabName: data[index]['tabName'],
          dateTime: data[index]['dateTime']);
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
