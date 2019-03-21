import 'package:flutter_orm_m8/flutter_orm_m8.dart';

part "account.m8.dart";

@DataTable("my_account_table")
class UserAccount implements DbAccountEntity {
  @DataColumn(
      "my_id_column",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int _id;

  @DataColumn("my_description_column", ColumnMetadata.Unique)
  String _description;

  @DataColumn("my_future_column", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int _futureData;

  @DataColumn("my_abbreviation_column", ColumnMetadata.NotNull)
  String _abbreviation;

  @DataColumn("my_email_column", ColumnMetadata.NotNull)
  String _email;

  @DataColumn("my_userName_column", ColumnMetadata.NotNull)
  String _userName;

  @override
  int get id => _id;

  int get FutureData => _futureData;

  String get description => _description;

  @override
  Map<String, dynamic> toMap() {
    return null;
  }

  @override
  String get abbreviation => _abbreviation;

  @override
  String get email => _email;

  @override
  String get userName => _userName;

  @override
  DbEntity getDbEntityFromMap(Map<String, dynamic> map) {
    return null;
  }
}
