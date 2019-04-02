import 'package:flutter_orm_m8/flutter_orm_m8.dart';

part "account.m8.dart";

@DataTable("my_account_table")
class UserAccount implements DbAccountEntity {
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

  @DataColumn("my_abbreviation_column", ColumnMetadata.NotNull)
  String abbreviation;

  @DataColumn("my_email_column", ColumnMetadata.NotNull)
  String email;

  @DataColumn("my_userName_column", ColumnMetadata.NotNull)
  String userName;
}
