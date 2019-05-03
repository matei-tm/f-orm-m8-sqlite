import 'package:f_orm_m8_sqlite/generator/emitted_entity.dart';
import 'package:f_orm_m8_sqlite/generator/entity_writer.dart';
import 'package:f_orm_m8_sqlite/generator/utils/type_utils.dart';
import 'package:f_orm_m8_sqlite/generator/utils/utils.dart';
import 'package:f_orm_m8_sqlite/generator/writers/attribute_writer.dart';

class ProxyWriter extends EntityWriter {
  ProxyWriter(EmittedEntity emittedEntity) : super(emittedEntity);

  String _getTableMetaFields() {
    StringBuffer sb = StringBuffer();

    if (emittedEntity.hasTrackCreate) {
      sb.writeln("${s002}DateTime dateCreate;");
    }

    if (emittedEntity.hasTrackUpdate) {
      sb.writeln("${s002}DateTime dateUpdate;");
    }

    if (emittedEntity.hasSoftDelete) {
      sb.writeln(
          "${s002}DateTime dateDelete;\n${s002}bool get isDeleted => dateDelete.year > 1970;");
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
        .map((f) => "${s00004}this.${f.modelName} = ${f.modelName};")
        .join("\n");

    if (assignments == null || assignments.isEmpty) {
      return """${s002}${emittedEntity.modelNameProxy}();""";
    }

    return """${s002}${emittedEntity.modelNameProxy}({${paramList}}) {
$assignments
  }""";
  }

  String _getToMapMethodBody() {
    String fieldsEmition = emittedEntity.attributes.values
        .map((f) =>
            "${s00004}map['${f.attributeName}'] = ${AttributeWriter(f).modelToEntityMapString};")
        .join("\n");

    StringBuffer sb = StringBuffer();
    sb.write(fieldsEmition);

    sb.writeln();

    if (emittedEntity.hasTrackCreate) {
      sb.writeln(
          "${s00004}map['date_create'] = dateCreate.millisecondsSinceEpoch;");
    }

    if (emittedEntity.hasTrackUpdate) {
      sb.writeln(
          "${s00004}map['date_update'] = dateUpdate.millisecondsSinceEpoch;");
    }

    if (emittedEntity.hasSoftDelete) {
      sb.writeln("${s00004}// map['date_delete'] is handled by delete method");
    }

    return sb.toString();
  }

  String _getFromMapMethodBody() {
    String fieldsEmition = emittedEntity.attributes.values
        .map((f) =>
            "${s00004}this.${f.modelName} = ${AttributeWriter(f).entityToModelMapString};")
        .join("\n");

    StringBuffer sb = StringBuffer();
    sb.write(fieldsEmition);

    sb.writeln();

    if (emittedEntity.hasTrackCreate) {
      sb.writeln(
          "${s00004}this.dateCreate = DateTime.fromMillisecondsSinceEpoch(map['date_create']);");
    }

    if (emittedEntity.hasTrackUpdate) {
      sb.writeln(
          "${s00004}this.dateUpdate = DateTime.fromMillisecondsSinceEpoch(map['date_update']);");
    }

    if (emittedEntity.hasSoftDelete) {
      sb.writeln(
          "${s00004}this.dateDelete = DateTime.fromMillisecondsSinceEpoch(map['date_delete']);");
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

${s002}Map<String, dynamic> toMap() {
${s00004}var map = Map<String, dynamic>();
${this._getToMapMethodBody()}
${s00004}return map;
  }

${s002}${emittedEntity.modelNameProxy}.fromMap(Map<String, dynamic> map) {
${this._getFromMapMethodBody()}${s002}}
}

""");

    return sb.toString();
  }
}
