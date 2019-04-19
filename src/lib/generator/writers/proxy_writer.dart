import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/entity_writer.dart';
import 'package:flutter_sqlite_m8_generator/generator/utils/type_utils.dart';
import 'package:flutter_sqlite_m8_generator/generator/utils/utils.dart';
import 'package:flutter_sqlite_m8_generator/generator/writers/attribute_writer.dart';

class ProxyWriter extends EntityWriter {
  ProxyWriter(EmittedEntity emittedEntity) : super(emittedEntity);

  String _getTableMetaFields() {
    StringBuffer sb = StringBuffer();

    if (emittedEntity.hasSoftDelete) {
      sb.writeln("  bool isDeleted;");
    }

    if (emittedEntity.hasTrackCreate) {
      sb.writeln("  DateTime dateCreate;");
    }

    if (emittedEntity.hasTrackUpdate) {
      sb.writeln("  DateTime dateUpdate;");
    }

    return sb.toString();
  }

  String _getDefaultConstructorBody() {
    var candidateAttributes = emittedEntity.attributes.values.where((t) =>
        !mustIgnore(t.metadataLevel) &&
        isNotNull(t.metadataLevel) &&
        !isAutoIncrement(t.metadataLevel));

    var paramList = candidateAttributes.map((f) => "${f.modelName}").join(", ");

    var assignments = candidateAttributes
        .map((f) => "    this.${f.modelName} = ${f.modelName};")
        .join("\n");

    if (assignments == null || assignments.isEmpty) {
      return """  ${emittedEntity.modelNameProxy}();""";
    }

    return """  ${emittedEntity.modelNameProxy}({${paramList}}) {
$assignments
  }""";
  }

  String _getToMapMethodBody() {
    String fieldsEmition = emittedEntity.attributes.values
        .map((f) =>
            "    map['${f.attributeName}'] = ${AttributeWriter(f).modelToEntityMapString};")
        .join("\n");

    StringBuffer sb = StringBuffer();
    sb.write(fieldsEmition);

    if (emittedEntity.hasSoftDelete) {
      sb.writeln("map['is_deleted'] = isDeleted;");
    }

    if (emittedEntity.hasTrackCreate) {
      sb.writeln("map['date_create'] = dateCreate.millisecondsSinceEpoch;");
    }

    if (emittedEntity.hasTrackUpdate) {
      sb.writeln("map['date_update'] = dateUpdate.millisecondsSinceEpoch;");
    }

    return sb.toString();
  }

  String _getFromMapMethodBody() {
    String fieldsEmition = emittedEntity.attributes.values
        .map((f) =>
            "    this.${f.modelName} = ${AttributeWriter(f).entityToModelMapString};")
        .join("\n");

    StringBuffer sb = StringBuffer();
    sb.write(fieldsEmition);

    if (emittedEntity.hasSoftDelete) {
      sb.writeln("this.isDeleted = map['is_deleted'];");
    }

    if (emittedEntity.hasTrackCreate) {
      sb.writeln(
          "this.dateCreate = DateTime.fromMillisecondsSinceEpoch(map['date_create']);");
    }

    if (emittedEntity.hasTrackUpdate) {
      sb.writeln(
          "this.dateUpdate = DateTime.fromMillisecondsSinceEpoch(map['date_update']);");
    }

    return sb.toString();
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer();

    sb.write("""
class ${emittedEntity.modelNameProxy} extends ${emittedEntity.modelName} {
${_getTableMetaFields()}

${_getDefaultConstructorBody()}

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
${this._getToMapMethodBody()}
    return map;
  }

  ${emittedEntity.modelNameProxy}.fromMap(Map<String, dynamic> map) {
${this._getFromMapMethodBody()}
  }
}

""");

    return sb.toString();
  }
}
