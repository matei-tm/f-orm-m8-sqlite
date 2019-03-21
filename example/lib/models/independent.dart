import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable("my_health_entries_table")
class HealthEntry implements DbEntity {
  @DataColumn(
      "my_id_column",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int _id;

  @DataColumn("my_description_column", ColumnMetadata.Unique)
  String _description;

  @DataColumn("my_future_column", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int _futureData;

  @override
  int get id => _id;

  int get FutureData => _futureData;

  String get description => _description;

  @override
  Map<String, dynamic> toMap() {
    return null;
  }

  @override
  DbEntity getDbEntityFromMap(Map<String, dynamic> map) {
    // TODO: implement getDbEntityFromMap
    return null;
  }
}
