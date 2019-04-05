import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/entity_writer.dart';
import 'package:flutter_sqlite_m8_generator/generator/utils/type_utils.dart';

class ProxyWriter extends EntityWriter {
  ProxyWriter(EmittedEntity emittedEntity) : super(emittedEntity);

  String _getToMapMethodBody() {
    return emittedEntity.attributes.values
        .map((f) => "    map['${f.attributeName}'] = ${f.modelName};")
        .join("\n");
  }

  String _getFromMapMethodBody() {
    return emittedEntity.attributes.values
        .map((f) => "    this.${f.modelName} = map['${f.attributeName}'];")
        .join("\n");
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

    return """  ${emittedEntity.modelName}Proxy(${paramList}) {
$assignments
  }""";
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer();

    sb.write("""
class ${emittedEntity.modelName}Proxy extends ${emittedEntity.modelName} {
${_getDefaultConstructorBody()}

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
${this._getToMapMethodBody()}
    return map;
  }

  ${emittedEntity.modelName}Proxy.fromMap(Map<String, dynamic> map) {
${this._getFromMapMethodBody()}
  }
}

""");

    return sb.toString();
  }
}
