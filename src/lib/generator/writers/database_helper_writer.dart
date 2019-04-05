import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';

class DatabaseHelperWriter {
  final List<EmittedEntity> emittedEntities;
  final String databaseFileStamp;
  final String helpersExtension;

  DatabaseHelperWriter(
      this.emittedEntities, this.databaseFileStamp, this.helpersExtension);

  String getImportList() {
    List<String> distinctImportEntriesList = emittedEntities
        .map((f) =>
            "import '${f.packageIdentifier.replaceFirst(".dart", helpersExtension)}';")
        .toSet()
        .toList();
    return distinctImportEntriesList.join("\n");
  }

  String getMixinList() {
    String returnValue =
        emittedEntities.map((f) => "${f.modelName}DatabaseHelper").join(",");
    if (returnValue.length > 0) {
      return " with $returnValue";
    }

    return "";
  }

  String getOnCreateMethodBody() {
    String returnValue = emittedEntities
        .map((f) => "    await create${f.modelName}Table(db);")
        .join("\n");
    if (returnValue.length > 0) {
      return "$returnValue";
    }

    return "";
  }

  String getDeleteAllMethodBody() {
    String returnValue = emittedEntities
        .map((f) => "    await delete${f.modelPlural}All();")
        .join("\n");
    if (returnValue.length > 0) {
      return "$returnValue";
    }

    return "";
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer();

    sb.write("""

import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

${getImportList()}


class DatabaseHelper ${getMixinList()}
         {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'm8_store_${databaseFileStamp}.db');

    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
${getOnCreateMethodBody()}
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future deleteAll() async {
${getDeleteAllMethodBody()}
  }
}
""");
    return sb.toString();
  }
}
