import 'package:f_orm_m8/f_orm_m8.dart';
import 'package:f_orm_m8_sqlite/generator/core.dart';
import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';

class SqlDefinitionWriter extends ValidationCollectable with Spacers {
  final EmittedEntity emittedEntity;

  String get theTableHandler => this.emittedEntity.theTableHandler;
  String get theTableHandlerValue => this.emittedEntity.entityName;

  SqlDefinitionWriter(this.emittedEntity) {
    _uniqueCompositesMap = Map<String, String>();
    _primaryKeyCompositesMap = Map<String, String>();
    _indexCompositesMap = Map<String, String>();

    uniqueAppendedCombinationList = List<String>();
    if (emittedEntity.hasSoftDelete) {
      uniqueAppendedCombinationList.add("date_delete");
    }
  }

  List<String> uniqueAppendedCombinationList;

  Map<String, String> _uniqueCompositesMap;
  Map<String, String> _primaryKeyCompositesMap;
  Map<String, String> _indexCompositesMap;

  String getTableDefinition() {
    List<String> columnList = List<String>();

    emittedEntity.attributes
        .forEach((k, v) => columnList.add("${v.getAttributeFullDefinition()}"));

    if (emittedEntity.hasTrackCreate) {
      columnList.add("date_create INTEGER");
    }

    if (emittedEntity.hasTrackUpdate) {
      columnList.add("date_update INTEGER");
    }

    if (emittedEntity.hasSoftDelete) {
      columnList.add("date_delete INTEGER DEFAULT 0");
    }

    collectCompositeConstraints();

    validatePrimaryKeys();

    if (hasValidatorIssues) {
      return '';
    }

    String tableDefinition =
        """'''CREATE TABLE \$${theTableHandler} (\n$s00004${columnList.join(",\n$s00004")}${getPrimaryKeyCompositeString()}${getUniqueConstraintsStringBlock()}\n${s00004})'''""";

    return tableDefinition;
  }

  void validatePrimaryKeys() {
    var primaryKeys = emittedEntity.attributes.values
        .where((ea) => isPrimaryKey(ea.metadataLevel));

    int countOfPrimaryKeys =
        (_primaryKeyCompositesMap?.length ?? 0) + (primaryKeys?.length ?? 0);

    if (countOfPrimaryKeys > 1) {
      validationIssues.add(ValidationIssue(
          isError: true,
          message:
              "The type ${emittedEntity.modelName} has more than one Primary Key groups"));
    }
  }

  String getTableFullDefinitionBlock() {
    return "await db.execute(${getTableDefinition()});";
  }

  String getCompositeString(
      Map<String, String> constraintMap, String compositeClause) {
    String collectedString = "";
    constraintMap.forEach((k, v) {
      collectedString += "$compositeClause($v)";
    });

    return collectedString == "" ? collectedString : "$s00004$collectedString";
  }

  String getPrimaryKeyCompositeString() {
    return getCompositeString(
        _primaryKeyCompositesMap, ",\n${s00004}PRIMARY KEY");
  }

  String getIndexStringBlock() {
    String collectedString = "";

    emittedEntity.attributes.values
        .where((ea) => isIndexed(ea.metadataLevel))
        .forEach((attributeWithIndex) {
      collectedString +=
          "\n${s00004}await db.execute('''CREATE INDEX ix_\$\{${theTableHandler}\}_${attributeWithIndex.attributeName} ON \$${theTableHandler} (${attributeWithIndex.attributeName})''');";
    });

    _indexCompositesMap.forEach((k, v) {
      collectedString +=
          "\n${s00004}await db.execute('''CREATE INDEX ix_\$\{${theTableHandler}\}_${k} ON \$${theTableHandler} ($v)''');";
    });

    return collectedString == "" ? collectedString : "$collectedString";
  }

  String getUniqueConstraintsStringBlock() {
    String collectedString = "";
    String uniqueCombinationExtraString =
        (uniqueAppendedCombinationList?.length ?? 0) > 0
            ? ", ${uniqueAppendedCombinationList.join(", ")}"
            : "";

    emittedEntity.attributes.values
        .where((ea) => isUnique(ea.metadataLevel))
        .forEach((attributeWithUnique) {
      collectedString +=
          ",\n${s00004}UNIQUE (${attributeWithUnique.attributeName}$uniqueCombinationExtraString) ON CONFLICT REPLACE";
    });

    _uniqueCompositesMap.forEach((k, v) {
      collectedString +=
          ",\n${s00004}UNIQUE ($v$uniqueCombinationExtraString) ON CONFLICT REPLACE";
    });

    return collectedString == "" ? collectedString : "$collectedString";
  }

  void collectCompositeConstraints() {
    emittedEntity.attributes.forEach((k, v) {
      buildCompositesByType(
          v, _uniqueCompositesMap, CompositeConstraintType.unique);
      buildCompositesByType(
          v, _primaryKeyCompositesMap, CompositeConstraintType.primaryKey);
      buildCompositesByType(
          v, _indexCompositesMap, CompositeConstraintType.indexed);
    });
  }

  void buildCompositesByType(
      EntityAttribute v,
      Map<String, String> constraintMap,
      CompositeConstraintType compositeConstraintType) {
    v?.compositeConstraints
        ?.where((d) => d.constraintType == compositeConstraintType)
        ?.forEach((compositeConstraint) {
      String compositeConstraintname = compositeConstraint.name.split("'")[1];
      if (!constraintMap.containsKey(compositeConstraintname)) {
        constraintMap.putIfAbsent(
            compositeConstraintname, () => v.attributeName);
      } else {
        constraintMap[compositeConstraintname] += ", ${v.attributeName}";
      }
    });
  }
}
