import 'package:f_orm_m8/f_orm_m8.dart';
import 'package:f_orm_m8_sqlite/generator/core.dart';
import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';

class SqlDefinitionWriter with Spacers {
  final EmittedEntity emittedEntity;

  String get theTableHandler => this.emittedEntity.theTableHandler;
  String get theTableHandlerValue => this.emittedEntity.entityName;

  SqlDefinitionWriter(this.emittedEntity) {
    _uniqueCompositesMap = Map<String, String>();
    _primaryKeyCompositesMap = Map<String, String>();
    _indexCompositesMap = Map<String, String>();
  }

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

    String tableDefinition =
        """'''CREATE TABLE \$${theTableHandler} (\n$s00004${columnList.join(",\n$s00004")}${getPrimaryKeyCompositeString()}${getUniqueCompositeString()}\n${s00004})'''""";

    return tableDefinition;
  }

  String getCompositeString(
      Map<String, String> constraintMap, String compositeClause) {
    String collectedString = "";
    constraintMap.forEach((k, v) {
      collectedString += "$compositeClause($v)";
    });

    return collectedString == "" ? collectedString : "$s00004$collectedString";
  }

  String getUniqueCompositeString() {
    return getCompositeString(_uniqueCompositesMap, ",\n${s00004}UNIQUE");
  }

  String getPrimaryKeyCompositeString() {
    return getCompositeString(
        _primaryKeyCompositesMap, ",\n${s00004}PRIMARY KEY");
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
      if (!constraintMap.containsKey(compositeConstraint.name)) {
        constraintMap.putIfAbsent(
            compositeConstraint.name, () => v.attributeName);
      } else {
        constraintMap[compositeConstraint.name] += ", ${v.attributeName}";
      }
    });
  }
}
