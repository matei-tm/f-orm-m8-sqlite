import 'package:flutter_sqlite_m8_generator/generator/emitted_entity.dart';
import 'package:flutter_sqlite_m8_generator/generator/entity_writer.dart';
import 'package:flutter_sqlite_m8_generator/generator/writers/proxy_writer.dart';

class IndependentEntityWriter extends EntityWriter {
  IndependentEntityWriter(EmittedEntity emittedEntity) : super(emittedEntity);

  @override
  String toString() {
    StringBuffer sb = getCommonImports();

    ProxyWriter proxyWriter = ProxyWriter(emittedEntity);

    sb.write(proxyWriter.toString());

    sb.write(getMixinStart());

    sb.write(getCommonMethods());

    sb.write(getSoftdeleteMethod());
    sb.writeln("}");
    return sb.toString();
  }
}
