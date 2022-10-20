import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../model/object.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 'tableItem';
  final String columnId = 'id';
  final String columnMotor = 'motor';
  final String columnKerusakan = 'kerusakan';
  final String columnSparepart = 'sparepart';
  final String columnHarga = 'harga';
  final String columnBiaya = 'biaya';
  final String columnTotal = 'total';
  final String columnTanggal = 'tanggal';

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kontak.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
        "$columnMotor TEXT,"
        "$columnKerusakan TEXT,"
        "$columnSparepart TEXT,"
        "$columnHarga TEXT,"
        "$columnBiaya TEXT,"
        "$columnTotal TEXT,"
        "$columnTanggal TEXT)";
    await db.execute(sql);
  }

  Future<int?> saveBengkel(Bengkel bengkel) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, bengkel.toMap());
  }

  Future<List?> getAllBengkel() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnMotor,
      columnKerusakan,
      columnSparepart,
      columnHarga,
      columnBiaya,
      columnTotal,
      columnTanggal
    ]);

    return result.toList();
  }

  Future<int?> updateBengkel(Bengkel bengkel) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, bengkel.toMap(),
        where: '$columnId = ?', whereArgs: [bengkel.id]);
  }

  Future<int?> deleteBengkel(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
