import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable("to_do", TableMetadata.TrackCreate | TableMetadata.TrackUpdate)
class ToDo implements DbAccountRelatedEntity {
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

  @DataColumn(
      "my_future_column4", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int futureData;

  @override
  @DataColumn("user_account_id", ColumnMetadata.Unique | ColumnMetadata.NotNull)
  int accountId;
}
