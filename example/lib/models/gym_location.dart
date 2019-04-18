import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable(
    "gym_location", TableMetadata.TrackCreate | TableMetadata.TrackUpdate)
class GymLocation implements DbEntity {
  @DataColumn(
      "id",
      ColumnMetadata.PrimaryKey |
          ColumnMetadata.Unique |
          ColumnMetadata.AutoIncrement)
  int id;

  @DataColumn("description", ColumnMetadata.Unique)
  String description;

  @DataColumn("rating")
  int rating;

  @DataColumn(
      "my_future_column7", ColumnMetadata.Ignore | ColumnMetadata.Unique)
  int futureData;
}
