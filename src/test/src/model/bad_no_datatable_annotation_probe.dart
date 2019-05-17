import 'package:f_orm_m8/f_orm_m8.dart';

// we do not allow the users to extends the Framework
class DataTableExtension extends DataTable {
  const DataTableExtension();
}

// exact @DataTable("my_bad_table") requirement is replaced with a user extension
@DataTableExtension()
class BadNonDbEntityProbe implements DbEntity {
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
