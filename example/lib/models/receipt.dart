import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable("receipt", TableMetadata.TrackCreate | TableMetadata.TrackUpdate)
class Receipt implements DbEntity {
  @DataColumn(
      "id",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int id;

  @DataColumn("number_of_molecules", ColumnMetadata.NotNull)
  BigInt numberOfMolecules;

  @DataColumn("is_bio", ColumnMetadata.NotNull)
  bool isBio;

  @DataColumn("expiration_date", ColumnMetadata.NotNull)
  DateTime expirationDate;

  @DataColumn("price", ColumnMetadata.NotNull)
  double quantity;

  @DataColumn("decomposing_duration", ColumnMetadata.NotNull)
  Duration decomposingDuration;

  @DataColumn("number_of_items", ColumnMetadata.NotNull)
  int numberOfItems;

  @DataColumn("storage_temperature", ColumnMetadata.NotNull)
  num storageTemperature;

  @DataColumn("description", ColumnMetadata.Unique | ColumnMetadata.NotNull)
  String description;

  @DataColumn(
      "my_future_column7", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int futureData;
}
