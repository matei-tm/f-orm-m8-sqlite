import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("my_index_probe_table")
class IndexProbe implements DbEntity {
  @DataColumn("my_id_column",
      metadataLevel: ColumnMetadata.primaryKey | ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("short_name", metadataLevel: ColumnMetadata.indexed)
  String shortName;

  @DataColumn("score", compositeConstraints: [
    CompositeConstraint(
        name: "ix_account_entry",
        constraintType: CompositeConstraintType.indexed)
  ])
  int score;

  @DataColumn("description", compositeConstraints: [
    CompositeConstraint(
        name: "ix_account_entry",
        constraintType: CompositeConstraintType.indexed)
  ])
  String description;
}
