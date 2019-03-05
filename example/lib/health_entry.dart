import 'package:flutter_orm_m8/flutter_orm_m8.dart';

part "health_entry.g.dart";

@DataTable("health_entries")
class HealthEntry {
  @DataColumn(
      "id",
      ColumnMetadata.PrimaryKey &
          ColumnMetadata.Unique &
          ColumnMetadata.AutoIncrement)
  int _id;

  @DataColumn("account_id")
  int _accountId;

  @DataColumn("record_date")
  int _recordDate;

  @DataColumn("is_deleted")
  int _isDeleted;

  HealthEntry(
    this._recordDate,
    this._accountId,
    /*this._entryName*/
  );
  
  HealthEntry.map(dynamic obj) {
    this._id = obj['id'];
    this._accountId = obj['account_id'];
    this._recordDate = obj['record_date'];
    this._isDeleted = obj['is_deleted'];

    /*this._entryName = obj['entry_name'];*/
  }
}
