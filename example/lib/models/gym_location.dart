import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable(
    "gym_location", TableMetadata.trackCreate | TableMetadata.trackUpdate)
class GymLocation implements DbEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("description", metadataLevel: ColumnMetadata.unique)
  String description;

  @DataColumn("rating")
  int rating;

  @DataColumn("my_future_column7",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;
}
