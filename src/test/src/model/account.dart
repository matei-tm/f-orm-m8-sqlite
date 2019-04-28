import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable("my_account_table")
class UserAccount implements DbAccountEntity {
  @DataColumn("my_id_column",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("my_description_column", metadataLevel: ColumnMetadata.unique)
  String description;

  @DataColumn("my_future_column",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;

  @DataColumn("my_abbreviation_column", metadataLevel: ColumnMetadata.notNull)
  String abbreviation;

  @DataColumn("my_email_column", metadataLevel: ColumnMetadata.notNull)
  String email;

  @DataColumn("my_userName_column", metadataLevel: ColumnMetadata.notNull)
  String userName;

  @override
  @DataColumn("my_is_current", metadataLevel: ColumnMetadata.notNull)
  bool isCurrent;
}
