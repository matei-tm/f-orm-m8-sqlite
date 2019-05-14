import 'package:f_orm_m8_sqlite/generator/emitted_entity.dart';

class DatabaseProviderWriter {
  final List<EmittedEntity> emittedEntities;
  final String databaseFileStamp;
  final String helpersExtension;

  DatabaseProviderWriter(
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
        emittedEntities.map((f) => "${f.modelName}DatabaseProvider").join(",");
    if (returnValue.isNotEmpty) {
      return " with $returnValue";
    }

    return "";
  }

  String getOnCreateMethodBody() {
    String returnValue = emittedEntities
        .map((f) => "    await create${f.modelName}Table(db);")
        .join("\n");
    if (returnValue.isNotEmpty) {
      return "$returnValue";
    }

    return "";
  }

  String getDeleteAllMethodBody() {
    String returnValue = emittedEntities
        .map((f) => "    await delete${f.modelNameProxyPlural}All();")
        .join("\n");
    if (returnValue.isNotEmpty) {
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

enum InitMode { developmentAlwaysReinitDb, testingMockDb, production }

class DatabaseAdapter {
  InitMode _initMode;
  static InitMode _startInitMode;
  static final DatabaseAdapter _instance = DatabaseAdapter._internal();
  static Database _db;

  /// Default initMode is production
  /// [developmentAlwaysReinitDb] then the database will be deleteted on each init
  /// [testingMockDb] then the database will be initialized as mock
  /// [production] then the database will be initialized as production
  factory DatabaseAdapter([InitMode initMode = InitMode.production]) {
    _startInitMode = initMode;
    return _instance;
  }

  DatabaseAdapter._internal() {
    if (_initMode == null) {
      _initMode = _startInitMode;
    }
  }

  InitMode get initMode => _initMode;

  Future<Database> getDb(dynamic _onCreate) async {
    if (_db != null) {
      return _db;
    }
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'm8_store_0.2.0.db');

    if (_startInitMode == InitMode.developmentAlwaysReinitDb) {
      await deleteDatabase(path);
    }

    _db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return _db;
  }
}

class DatabaseProvider ${getMixinList()}
         {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  static Database _db;

  static DatabaseAdapter _dbBuilder;

  factory DatabaseProvider(DatabaseAdapter dbBuilder) {
    _dbBuilder = dbBuilder;
    return _instance;
  }

  DatabaseProvider._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _dbBuilder.getDb(_onCreate);

    return _db;
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
