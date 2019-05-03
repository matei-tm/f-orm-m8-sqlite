import 'package:f_orm_m8_sqlite/generator/emitted_entity.dart';
import 'package:f_orm_m8_sqlite/generator/entity_writer.dart';
import 'package:f_orm_m8_sqlite/generator/writers/proxy_writer.dart';

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
