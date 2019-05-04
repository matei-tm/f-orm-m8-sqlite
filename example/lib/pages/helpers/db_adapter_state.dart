import 'package:flutter/material.dart';
import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/main.dart';

class DbAdapterState<T extends StatefulWidget> extends State<T> {
  DatabaseHelper databaseAdapter;

  @override
  void initState() {
    super.initState();

    final MyHomePage widget = context.ancestorWidgetOfExactType(MyHomePage);
    databaseAdapter = widget.databaseHelper;
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
