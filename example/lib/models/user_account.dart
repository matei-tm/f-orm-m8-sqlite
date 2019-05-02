import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("user_account")
class UserAccount implements DbAccountEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("description")
  String description;

  @DataColumn("my_future_column7",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;

  @DataColumn("abbreviation",
      metadataLevel: ColumnMetadata.notNull | ColumnMetadata.unique)
  String abbreviation;

  @DataColumn("email", metadataLevel: ColumnMetadata.notNull)
  String email;

  @DataColumn("user_name",
      metadataLevel: ColumnMetadata.notNull | ColumnMetadata.unique)
  String userName;

  @DataColumn("is_current")
  bool isCurrent;
}
