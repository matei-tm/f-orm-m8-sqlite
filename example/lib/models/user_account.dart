import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable("user_account")
class UserAccount implements DbAccountEntity {
  @DataColumn(
      "id",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int id;

  @DataColumn("description", ColumnMetadata.Unique)
  String description;

  @DataColumn("my_future_column", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int futureData;

  @DataColumn("abbreviation", ColumnMetadata.NotNull)
  String abbreviation;

  @DataColumn("email", ColumnMetadata.NotNull)
  String email;

  @DataColumn("user_name", ColumnMetadata.NotNull)
  String userName;
}
