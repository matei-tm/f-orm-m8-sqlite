import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable(
    "health_entries", TableMetadata.TrackCreate | TableMetadata.TrackUpdate)
class HealthEntry implements DbAccountRelatedEntity {
  @DataColumn(
      "id",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int id;

  @DataColumn("description", ColumnMetadata.Unique)
  String description;

  @DataColumn("diagnosys_date")
  DateTime diagnosysDate;

  @override
  @DataColumn("user_account_id", ColumnMetadata.Unique | ColumnMetadata.NotNull)
  int accountId;

  @DataColumn(
      "my_future_column3", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int futureData;
}
