import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("my_account_related_table")
class GymLocation implements DbEntity {
  @DataColumn("my_id_column",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  // Multiple DataColumn annotations on the same field are not allowed
  @DataColumn("my_description1_column", metadataLevel: ColumnMetadata.unique)
  @DataColumn("my_description2_column", metadataLevel: ColumnMetadata.unique)
  String description;
}
