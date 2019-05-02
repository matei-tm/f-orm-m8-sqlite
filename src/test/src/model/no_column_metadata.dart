import 'package:f_orm_m8/f_orm_m8.dart';

@DataTable("my_account_related_table")
class AModelWithoutExplicitColumnMetadata implements DbEntity {
  @DataColumn("my_id_column")
  int id;

  @DataColumn("my_description_column")
  String description;

  @DataColumn("my_future_column")
  int futureData;
}
