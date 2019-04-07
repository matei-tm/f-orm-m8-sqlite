import 'package:example/fragments/health_entry_row.dart';
import 'package:example/main.adapter.g.m8.dart';
import 'package:example/models/independent.g.m8.dart';
import 'package:flutter/material.dart';

class HealthConditionsFragment extends StatefulWidget {
  HealthConditionsFragment();

  _HealthConditionsFragmentState createState() =>
      _HealthConditionsFragmentState();
}

class _HealthConditionsFragmentState extends State<HealthConditionsFragment> {
  List<HealthEntryProxy> healthEntries;

  @override
  void initState() {
    if (healthEntries == null) {
      print("Init State load is called");
      healthEntries = [];
      _loadAsyncCurrentData().then((result) {
        setState(() {
          print("Loading db is $result");
        });
      });
    }

    super.initState();
  }

  Future<bool> _loadAsyncCurrentData() async {
    var db = DatabaseHelper();

    var dbHealthEntries = await db.getHealthEntrysAll();
    healthEntries = List<HealthEntryProxy>();

    dbHealthEntries.forEach(
      (f) {
        healthEntries.add(HealthEntryProxy.fromMap(f));
      },
    );

    return true;
  }

  final TextEditingController healthEntryController = TextEditingController();

  Widget _container() {
    return Scaffold(
      appBar: AppBar(
        title: Text("HealthConditions"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: healthEntryController,
                    decoration: InputDecoration(
                      hintText: "Type Health Condition. Press enter to finish",
                      labelText: "New Health Condition Entry",
                    ),
                    onSubmitted: (text) async {
                      _saveHealthEntry(text);
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: healthEntries.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return HealthEntryRow(
                          healthEntry: healthEntries[index],
                          onPressed: (h) {
                            _deleteHealthEntry(h);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _container();
  }

  Future<void> _saveHealthEntry(String text) async {
    var db = DatabaseHelper();
    var tempHealthEntry = HealthEntryProxy();
    tempHealthEntry.description = text;
    var newId = await db.saveHealthEntry(tempHealthEntry);
    tempHealthEntry.id = newId;

    healthEntries.add(tempHealthEntry);
    healthEntryController.clear();
    setState(() {});
  }

  Future<void> _deleteHealthEntry(HealthEntryProxy h) async {
    var db = DatabaseHelper();

    await db.softdeleteHealthEntry(h.id);
    healthEntries.remove(h);
    setState(() {});
  }
}
