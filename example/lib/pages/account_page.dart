import 'package:example/main.adapter.g.m8.dart';
import 'package:example/models/user_account.g.m8.dart';
import 'package:example/routes/start_page_route.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  final UserAccountProxy _stateAccount;

  AccountPage(this._stateAccount);

  _AccountPageState createState() => _AccountPageState(_stateAccount);
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();

  UserAccountProxy _stateAccount;
  String title;
  DatabaseHelper _db = DatabaseHelper();

  _AccountPageState(UserAccountProxy stateAccount) {
    if (stateAccount == null) {
      title = "New";
      this._stateAccount = UserAccountProxy(null, null, null);
    } else {
      title = "Edit";
      this._stateAccount = stateAccount;
    }
  }

  Future<void> submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      _db = DatabaseHelper();

      int id;
      _stateAccount.isCurrent = true;

      if (_stateAccount.id == null) {
        id = await _db.saveUserAccount(_stateAccount);
      } else {
        id = await _db.updateUserAccount(_stateAccount);
      }

      _db.setCurrentUserAccount(id);

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
                          backgroundColor: Colors.red,
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
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: FloatingActionButton(
                onPressed: () => _onTapAddNew(this.context),
                tooltip: 'Info',
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  void _addNewAccount() {
    Navigator.of(context).pushReplacement(StartPageRoute(null));
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
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  this._addNewAccount();
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  Future testIfMaxAccountsCountWasReached(BuildContext context) async {
    bool maxAccountsCountReached;
    var accountsCount = await _db.getUserAccountProxiesCount();
    if (accountsCount > 3) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: Text("The accounts max limit was reached"),
              actions: <Widget>[
                FlatButton(
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
}
