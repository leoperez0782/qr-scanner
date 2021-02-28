import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/src/models/scan_model.dart';
export 'package:qr_scanner/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider dbProvider = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    //PAth donde almacenamos la base de datos.
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    Directory documentsDirectory =
        await getExternalStorageDirectory(); //este solo funciona en android.
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //crear db
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(''' 
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
        ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final db = await database;
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;
    final res = await db.rawInsert('''
    INSERT INTO Scans (id, tipo, valor)
    VALUES ($id, '$tipo', '$valor')
    ''');
    return res;
  }

//Es igual que el de arriba
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    print('Valor respuesta $res');
    //id del ultimo registro insertado.
    return res;
  }
}
