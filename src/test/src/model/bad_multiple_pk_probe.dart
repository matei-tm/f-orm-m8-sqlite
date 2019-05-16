import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable(
    "my_health_entries_table",
    TableMetadata.softDeletable |
        TableMetadata.trackCreate |
        TableMetadata.trackUpdate)
class HealthEntry implements DbOpenEntity {
  @DataColumn("pk_part1_column", compositeConstraints: [
    CompositeConstraint(
        name: "pk", constraintType: CompositeConstraintType.primaryKey)
  ])
  String pkPart1;

  @DataColumn("pk_part2_column", compositeConstraints: [
    CompositeConstraint(
        name: "pk", constraintType: CompositeConstraintType.primaryKey)
  ])
  String pkPart2;

  @DataColumn("pk_part3_column", compositeConstraints: [
    CompositeConstraint(
        name: "pk3", constraintType: CompositeConstraintType.primaryKey)
  ])
  String pkPart3;

  @DataColumn("my_description_column", metadataLevel: ColumnMetadata.unique)
  String description;

  @override
  getPrimaryKey() {
    return "$pkPart1#$pkPart2";
  }
}
