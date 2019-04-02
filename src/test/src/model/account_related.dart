import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable("my_account_related_table")
class HealthEntryAccountRelated implements DbAccountRelatedEntity {
  @DataColumn(
      "my_id_column",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int id;

  @DataColumn("my_description_column", ColumnMetadata.Unique)
  String description;

  @DataColumn("my_future_column", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int futureData;

  @DataColumn("my_account_id_column", ColumnMetadata.NotNull)
  int accountId;
}
