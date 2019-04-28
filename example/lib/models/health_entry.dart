import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable(
    "health_entry", TableMetadata.trackCreate | TableMetadata.trackUpdate)
class HealthEntry implements DbAccountRelatedEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("description", metadataLevel: ColumnMetadata.notNull)
  String description;

  @DataColumn("diagnosys_date")
  DateTime diagnosysDate;

  @override
  @DataColumn("account_id", metadataLevel: ColumnMetadata.notNull)
  int accountId;

  @DataColumn("my_future_column7",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;
}
