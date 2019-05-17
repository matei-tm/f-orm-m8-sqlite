import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("my_account_related_table")
class AModelWithoutFields implements DbEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey | ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("custom_type", metadataLevel: ColumnMetadata.unique)
  MyCustomType myCustomType;
}

class MyCustomType {}
