import 'package:flutter_orm_m8/flutter_orm_m8.dart';
import 'package:flutter_sqlite_m8_generator/generator/core.dart';
import 'package:flutter_sqlite_m8_generator/generator/utils/utils.dart';

class SqlDefinitionWriter {
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

  get tableSpacer => "    ";

  String getTableDefinition() {
    List<String> columnList = List<String>();

    emittedEntity.attributes
        .forEach((k, v) => columnList.add("${v.getAttributeFullDefinition()}"));

    if (emittedEntity.hasSoftDelete) {
      columnList.add("is_deleted INTEGER DEFAULT 0");
    }

    if (emittedEntity.hasTrackCreate) {
      columnList.add("date_create INTEGER");
    }

    if (emittedEntity.hasTrackUpdate) {
      columnList.add("date_update INTEGER");
    }

    collectCompositeConstraints();

    String tableDefinition =
        """'''CREATE TABLE \$${theTableHandler} (\n$tableSpacer${columnList.join(",\n$tableSpacer")}${getPrimaryKeyCompositeString()}${getUniqueCompositeString()}\n)'''""";

    return tableDefinition;
  }

  String getCompositeString(
      Map<String, String> constraintMap, String compositeClause) {
    String collectedString = "";
    constraintMap.forEach((k, v) {
      collectedString += "$compositeClause($v)";
    });

    return collectedString == ""
        ? "$tableSpacer$collectedString"
        : collectedString;
  }

  String getUniqueCompositeString() {
    return getCompositeString(_uniqueCompositesMap, ",\n${tableSpacer}UNIQUE");
  }

  String getPrimaryKeyCompositeString() {
    return getCompositeString(
        _primaryKeyCompositesMap, ",\n${tableSpacer}PRIMARY KEY");
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
