import 'package:flutter_orm_m8/flutter_orm_m8.dart';

part "not_allowed.m8.dart";

@DataTable("wrong_table_annotation")
String test;

@DataTable("table_without_fields")
class AClassModel {}
