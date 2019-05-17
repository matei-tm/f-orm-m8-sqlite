import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("my_index_probe_table")
class IndexProbe implements DbEntity {
  @DataColumn("my_id_column",
      metadataLevel: ColumnMetadata.primaryKey | ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("short_name3", metadataLevel: ColumnMetadata.indexed)
  String shortName3;

  @DataColumn("short_name4", metadataLevel: ColumnMetadata.indexed)
  String shortName4;

  @DataColumn("score1", compositeConstraints: [
    CompositeConstraint(
        name: "group1", constraintType: CompositeConstraintType.indexed)
  ])
  int score1;

  @DataColumn("description1", compositeConstraints: [
    CompositeConstraint(
        name: "group1", constraintType: CompositeConstraintType.indexed)
  ])
  String description1;

  @DataColumn("score2", compositeConstraints: [
    CompositeConstraint(
        name: "group2", constraintType: CompositeConstraintType.indexed)
  ])
  int score2;

  @DataColumn("description2", compositeConstraints: [
    CompositeConstraint(
        name: "group2", constraintType: CompositeConstraintType.indexed)
  ])
  String description2;
}
