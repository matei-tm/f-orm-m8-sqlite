import 'package:flutter_orm_m8/flutter_orm_m8.dart';

@DataTable("my_account_related_table")
class HealthEntryAccountRelated implements DbAccountRelatedEntity {
  @DataColumn("my_id_column",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("my_future_column",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;

  @DataColumn("account_id", compositeConstraints: [
    CompositeConstraint(
        name: "uq_account_entry",
        constraintType: CompositeConstraintType.unique),
    CompositeConstraint(
        name: "ix_account_entry",
        constraintType: CompositeConstraintType.indexed)
  ])
  int accountId;

  @DataColumn("description", compositeConstraints: [
    CompositeConstraint(
        name: "uq_account_entry",
        constraintType: CompositeConstraintType.unique)
  ])
  String description;
}
