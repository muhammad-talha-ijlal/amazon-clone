import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:amazonclone/model/Address.dart';

class DatabaseService {
  static Database? _database;
  static const String tableName = 'address';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'addresses.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        flat TEXT,
        area TEXT,
        city TEXT,
        zipCode TEXT
      )
    ''');
  }

  Future<int> insertEntry(Address entry) async {
    Database db = await database;
    return await db.insert(tableName, entry.toMap());
  }

  Future<List<Address>> getEntries() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (index) => Address.fromMap(maps[index]));
  }
}
