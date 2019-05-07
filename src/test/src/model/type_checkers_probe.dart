import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("receipt", TableMetadata.trackCreate | TableMetadata.trackUpdate)
class Receipt implements DbEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("number_of_molecules", metadataLevel: ColumnMetadata.notNull)
  BigInt numberOfMolecules;

  @DataColumn("is_bio", metadataLevel: ColumnMetadata.notNull)
  bool isBio;

  @DataColumn("expiration_date", metadataLevel: ColumnMetadata.notNull)
  DateTime expirationDate;

  @DataColumn("quantity", metadataLevel: ColumnMetadata.notNull)
  double quantity;

  @DataColumn("decomposing_duration", metadataLevel: ColumnMetadata.notNull)
  Duration decomposingDuration;

  @DataColumn("number_of_items", metadataLevel: ColumnMetadata.notNull)
  int numberOfItems;

  @DataColumn("storage_temperature", metadataLevel: ColumnMetadata.notNull)
  num storageTemperature;

  @DataColumn("description",
      metadataLevel: ColumnMetadata.unique | ColumnMetadata.notNull)
  String description;

  @DataColumn("future_data",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;
}
