import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("my_account_related_table")
class HealthEntryAccountRelated implements DbAccountRelatedEntity {
  @DataColumn("my_id_column",
      metadataLevel: ColumnMetadata.primaryKey | ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("my_description_column", metadataLevel: ColumnMetadata.unique)
  String description;

  @DataColumn("my_future_column",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;

  @DataColumn("my_account_id_column", metadataLevel: ColumnMetadata.notNull)
  int accountId;
}
