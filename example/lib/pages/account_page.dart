import 'package:example/main.adapter.g.m8.dart';
import 'package:example/models/user_account.g.m8.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();

  UserAccountProxy _stateAccount;
  String title;
  DatabaseHelper _db = DatabaseHelper();

  _AccountPageState();

  @override
  void initState() {
    super.initState();
    _stateAccount = _stateAccount ?? UserAccountProxy(null, null, null);
  }

  Future<void> submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      _db = new DatabaseHelper();

      int id;

      if (_stateAccount.id == null) {
        id = await _db.saveUserAccount(_stateAccount);
      } else {
        _stateAccount.isCurrent = true;
        id = await _db.updateUserAccount(_stateAccount);
      }

      Navigator.of(context).pushReplacementNamed("/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(this.title ?? "User account"),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.check),
            onPressed: submit,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(20.0),
            child: Form(
              autovalidate: false,
              key: _formKey,
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    decoration: new InputDecoration(
                      hintText: "Account name",
                      labelText: "Account name*",
                    ),
                    initialValue: _stateAccount.userName,
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
                    decoration: new InputDecoration(
                      hintText: "e-mail",
                      labelText: "e-mail*",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    initialValue: _stateAccount.email,
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
                      new Flexible(
                        child: TextFormField(
                          maxLength: 2,
                          decoration: new InputDecoration(
                            hintText: "Account abbreviation",
                            labelText: "Account abbreviation",
                          ),
                          initialValue: _stateAccount.abbreviation,
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
                      new Flexible(
                        child: new CircleAvatar(
                          backgroundColor: Colors.red,
                          child: new Text("??"),
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
                child: new Icon(Icons.add),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  void _addNewAccount() {
    setState(() {
      this._formKey.currentState.reset();
      _stateAccount = UserAccountProxy(null, null, null);
    });
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
      builder: (BuildContext context) => new AlertDialog(
            title: Text("Confirm adding new account"),
            actions: <Widget>[
              new FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  this._addNewAccount();
                },
              ),
              new FlatButton(
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
    var accountsCount = await _db.getUserAccountsCount();
    if (accountsCount > 3) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new AlertDialog(
              title: Text("The accounts max limit was reached"),
              actions: <Widget>[
                new FlatButton(
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
