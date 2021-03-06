import 'package:sqlite_m8_demo/fragments/health/health_entry_row.dart';
import 'package:sqlite_m8_demo/models/health_entry.g.m8.dart';
import 'package:sqlite_m8_demo/pages/helpers/snack_presenter.dart';
import 'package:sqlite_m8_demo/pages/helpers/guarded_account_state.dart';
import 'package:flutter/material.dart';

class HealthRecordsFragment extends StatefulWidget {
  final Key _parentScaffoldKey;

  HealthRecordsFragment(this._parentScaffoldKey);

  _HealthRecordsFragmentState createState() =>
      _HealthRecordsFragmentState(_parentScaffoldKey);
}

class _HealthRecordsFragmentState
    extends GuardedAccountState<HealthRecordsFragment> {
  List<HealthEntryProxy> healthEntries;

  final TextEditingController _healthEntryController = TextEditingController();

  bool _validate = false;

  var _parentScaffoldKey;

  _HealthRecordsFragmentState(this._parentScaffoldKey) {
    callExtraLoad = (i) {
      return _loadAsyncCurrentData(i);
    };
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _loadAsyncCurrentData(int accountId) async {
    healthEntries =
        await databaseProvider.getHealthEntryProxiesByAccountId(accountId);
    healthEntries = healthEntries ?? [];
    return true;
  }

  Widget _container() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: TextField(
                      key: Key('healthEntry'),
                      controller: _healthEntryController,
                      decoration: InputDecoration(
                        hintText: "Type a short description",
                        labelText: "New Health Record Entry",
                        errorText: _validate ? 'Value Can\'t Be Empty' : null,
                      ),
                      onSubmitted: (text) async {
                        _saveHealthEntry(text);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: RaisedButton(
                      key: Key('addHealthEntryButton'),
                      onPressed: () {
                        _saveHealthEntry(_healthEntryController.value.text);
                      },
                      child: Icon(Icons.add,
                          color: Theme.of(context).accentIconTheme.color),
                      shape: CircleBorder(),
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    if (guardedCurrentAccount == null || healthEntries == null) {
      return Container();
    }

    return _container();
  }

  Future<void> _saveHealthEntry(String text) async {
    try {
      if (_healthEntryController.text.isEmpty) {
        setState(() {
          _validate = true;
        });
        return;
      }

      var tempHealthEntry = HealthEntryProxy(
          description: text, accountId: guardedCurrentAccount.id);
      tempHealthEntry.diagnosysDate = DateTime.now();
      var newId = await databaseProvider.saveHealthEntry(tempHealthEntry);
      tempHealthEntry.id = newId;

      healthEntries.add(tempHealthEntry);
      _healthEntryController.clear();

      setState(() {
        _validate = false;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _deleteHealthEntry(HealthEntryProxy h) async {
    try {
      await databaseProvider.deleteHealthEntry(h.id);
      healthEntries.remove(h);

      setState(() {});
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    SnackPresenter.showError(message, _parentScaffoldKey);
  }
}
