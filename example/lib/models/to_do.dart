import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable("to_do", TableMetadata.trackCreate | TableMetadata.trackUpdate | TableMetadata.softDeletable)
class ToDo implements DbAccountRelatedEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("description", metadataLevel: ColumnMetadata.unique)
  String description;

  @DataColumn("diagnosys_date")
  DateTime diagnosysDate;

  @DataColumn("my_future_column7",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;

  @override
  @DataColumn("user_account_id",
      metadataLevel: ColumnMetadata.unique | ColumnMetadata.notNull)
  int accountId;
}
