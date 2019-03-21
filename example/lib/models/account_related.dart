import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable("my_account_related_table")
class HealthEntryAccountRelated implements DbAccountRelatedEntity {
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

  @DataColumn("my_account_id_column", ColumnMetadata.NotNull)
  int _account_id;

  @override
  int get id => _id;

  int get FutureData => _futureData;

  String get description => _description;

  @override
  Map<String, dynamic> toMap() {
    return null;
  }

  @override
  int get accountId => _account_id;

  @override
  DbEntity getDbEntityFromMap(Map<String, dynamic> map) {
    // TODO: implement getDbEntityFromMap
    return null;
  }
}
