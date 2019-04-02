import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/entity_writer.dart';

class ProxyWriter extends EntityWriter {
  ProxyWriter(EmittedEntity emittedEntity) : super(emittedEntity);

  String _getToMapList() {
    return emittedEntity.attributes.values
        .map((f) => "    map['${f.attributeName}'] = ${f.modelName};")
        .join("\n");
  }

  String _getFromMapList() {
    return emittedEntity.attributes.values
        .map((f) => "    this.${f.modelName} = map['${f.attributeName}'];")
        .join("\n");
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer();

    sb.write("""
class ${emittedEntity.modelName}Proxy extends ${emittedEntity.modelName} {
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    ${this._getToMapList()}    
    return map;
  }

  ${emittedEntity.modelName}Proxy.fromMap(Map<String, dynamic> map) {
    ${this._getFromMapList()}
  }
}

""");

    return sb.toString();
  }
}
