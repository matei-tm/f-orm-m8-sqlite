import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';
import 'package:sqlite_m8_demo/pages/helpers/db_adapter_state.dart';
import 'package:sqlite_m8_demo/routes/enhanced_route.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  final UserAccountProxy _stateAccount;

  AccountPage(this._stateAccount);

  _AccountPageState createState() => _AccountPageState(_stateAccount);
}

class _AccountPageState extends DbAdapterState<AccountPage> {
  final _formKey = GlobalKey<FormState>();

  final _accountNameKey = Key('accountNameTextFormField');
  final _emailKey = Key('emailTextFormField');
  final _abbreviationKey = Key('abbreviationTextFormField');
  final _addNewAccountKey = Key('addNewAccountButton');
  final _deleteAccountKey = Key('deleteAccountButton');
  final _saveAccountKey = Key('saveAccountButton');

  UserAccountProxy _stateAccount;
  String title;

  _AccountPageState(UserAccountProxy stateAccount) {
    if (stateAccount == null) {
      title = "New";
      this._stateAccount =
          UserAccountProxy(abbreviation: null, email: null, userName: null);
    } else {
      title = "Edit";
      this._stateAccount = stateAccount;
    }
  }

  Future<void> submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      int id;
      _stateAccount.isCurrent = true;

      if (_stateAccount.id == null) {
        id = await databaseProvider.saveUserAccount(_stateAccount);
      } else {
        id = await databaseProvider.updateUserAccount(_stateAccount);
      }

      await databaseProvider.setCurrentUserAccount(id);

      Navigator.of(context).pushReplacementNamed("/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${this.title} User account"),
        actions: <Widget>[
          IconButton(
            key: _saveAccountKey,
            icon: Icon(Icons.check),
            onPressed: submit,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              autovalidate: false,
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    key: _accountNameKey,
                    decoration: InputDecoration(
                      hintText: "Account name",
                      labelText: "Account name*",
                    ),
                    initialValue: _stateAccount?.userName,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter account name";
                      }
                    },
                    onSaved: (String value) {
                      this._stateAccount.userName = value;
                    },
                  ),
                  TextFormField(
                    key: _emailKey,
                    decoration: InputDecoration(
                      hintText: "e-mail",
                      labelText: "e-mail*",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    initialValue: _stateAccount?.email,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please Enter Email";
                      }
                    },
                    onSaved: (String value) {
                      this._stateAccount.email = value;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          key: _abbreviationKey,
                          maxLength: 2,
                          decoration: InputDecoration(
                            hintText: "Account abbreviation",
                            labelText: "Account abbreviation",
                          ),
                          initialValue: _stateAccount?.abbreviation,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter account abbreviation";
                            }
                          },
                          onSaved: (String value) {
                            this._stateAccount.abbreviation = value;
                          },
                        ),
                      ),
                      Flexible(
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Text("??"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 8),
              child: FloatingActionButton(
                key: _deleteAccountKey,
                heroTag: "DeleteAccount",
                onPressed: () => _onTapDelete(this.context),
                tooltip: 'Delete',
                child: Icon(Icons.delete),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: FloatingActionButton(
                key: _addNewAccountKey,
                heroTag: "AddNewAccount",
                onPressed: () => _onTapAddNew(this.context),
                tooltip: 'New',
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  void _addNewAccount() {
    Navigator.of(context).pushReplacement(EnhancedRoute.addUser());
  }

  _onTapDelete(BuildContext context) async {
    if (_stateAccount.id == null) {
      handleUnsavedAccount(context);
      return;
    }

    var accountHasDependents = await testIfAccountHasDependents(context);

    if (accountHasDependents) {
      return;
    }

    handleDeletingExistingAccount(context);
  }

  void handleDeletingExistingAccount(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            title: Text("Delete the account?"),
            actions: <Widget>[
              FlatButton(
                key: Key('confirmDeleteAccount'),
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  this._deleteAccount();
                },
              ),
              FlatButton(
                key: Key('cancelDeleteAccount'),
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  void handleUnsavedAccount(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            title: Text(
                "The account is not saved. Instead a reset will be triggered."),
            actions: <Widget>[
              FlatButton(
                key: Key('acceptResetAccount'),
                child: Text("Accept"),
                onPressed: () {
                  this._formKey.currentState.reset();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                key: Key('cancelResetAccount'),
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  _onTapAddNew(BuildContext context) async {
    var maxAccountsCountWasReached =
        await testIfMaxAccountsCountWasReached(context);

    if (maxAccountsCountWasReached) {
      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            title: Text("Confirm adding new account"),
            actions: <Widget>[
              FlatButton(
                key: Key('confirmAddingAccount'),
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  this._addNewAccount();
                },
              ),
              FlatButton(
                key: Key('cancelAddingAccount'),
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  Future<bool> testIfMaxAccountsCountWasReached(BuildContext context) async {
    bool maxAccountsCountReached;
    var accountsCount = await databaseProvider.getUserAccountProxiesCount();
    if (accountsCount > 3) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: Text("The accounts max limit was reached"),
              actions: <Widget>[
                FlatButton(
                  key: Key('okLimitReached'),
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
      );

      maxAccountsCountReached = true;
    } else {
      maxAccountsCountReached = false;
    }

    return maxAccountsCountReached;
  }

  Future<bool> testIfAccountHasDependents(BuildContext context) async {
    bool hasDependents;
    var dependentsCount = await databaseProvider
        .getHealthEntryProxiesByAccountId(_stateAccount.id);
    if (dependentsCount.length > 0) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                  "The account has dependents. As a result, deletion is forbidden.\nIf you really need to delete it, first go to 'Health Records' and delete all entries"),
              actions: <Widget>[
                FlatButton(
                  key: Key('acceptHasDependents'),
                  child: Text("Accept"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
      );

      hasDependents = true;
    } else {
      hasDependents = false;
    }

    return hasDependents;
  }

  Future _deleteAccount() async {
    databaseProvider.deleteUserAccount(this._stateAccount.id);

    var reminingUserAccounts =
        await databaseProvider.getUserAccountProxiesAll();

    if (reminingUserAccounts.length > 0) {
      databaseProvider.setCurrentUserAccount(reminingUserAccounts.first.id);
      Navigator.of(context).pushReplacementNamed("/");
    } else {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed("start");
    }
  }
}
