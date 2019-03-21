import 'package:flutter_orm_m8/flutter_orm_m8.dart';

part "example.g.dart";

@DataTable("health_entries")
class HealthEntry extends DbAccountRelatedEntity {
  @DataColumn(
      "id",
      ColumnMetadata.PrimaryKey &
          ColumnMetadata.Unique &
          ColumnMetadata.AutoIncrement)
  int id;

  @DataColumn("account_id")
  int accountId;

  @DataColumn("record_date")
  int recordDate;

  @DataColumn("is_deleted")
  int isDeleted;

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    return null;
  }

  @override
  DbEntity getDbEntityFromMap(Map<String, dynamic> map) {
    // TODO: implement getDbEntityFromMap
    return null;
  }
}
