import 'package:flutter_orm_m8/flutter_orm_m8.dart';

part "health_entry.m8.dart";


@DataTable("health_entries")
class HealthEntry extends DataId {
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

}

class DataId {
}
