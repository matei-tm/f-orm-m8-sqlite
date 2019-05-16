import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable(
    "to_do",
    TableMetadata.trackCreate |
        TableMetadata.trackUpdate |
        TableMetadata.softDeletable)
class ToDo implements DbAccountRelatedEntity {
  @DataColumn("id",
      metadataLevel: ColumnMetadata.primaryKey |
          ColumnMetadata.unique |
          ColumnMetadata.autoIncrement)
  int id;

  @DataColumn("description",
      metadataLevel: ColumnMetadata.unique | ColumnMetadata.indexed,
      compositeConstraints: [
        CompositeConstraint(
            name: "group1", constraintType: CompositeConstraintType.indexed)
      ])
  String description;

  @DataColumn("diagnosys_date", compositeConstraints: [
    CompositeConstraint(
        name: "group1", constraintType: CompositeConstraintType.indexed)
  ])
  DateTime diagnosysDate;

  @DataColumn("my_future_column7",
      metadataLevel: ColumnMetadata.ignore | ColumnMetadata.unique)
  int futureData;

  @override
  @DataColumn("user_account_id",
      metadataLevel: ColumnMetadata.unique | ColumnMetadata.notNull)
  int accountId;
}
