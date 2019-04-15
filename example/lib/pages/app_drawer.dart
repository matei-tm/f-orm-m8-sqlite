import 'package:example/models/user_account.dart';
import 'package:example/pages/guarded_account_state.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  final void Function(String) onSelectItem;

  const AppDrawer(
    this.onSelectItem, {
    Key key,
  }) : super(key: key);

  @override
  State createState() => new AppDrawerState();
}

class AppDrawerState extends GuardedAccountState<AppDrawer> {
  _onTapOtherAccounts(BuildContext context, UserAccount userAccount) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => new AlertDialog(
            title:
                Text("EmergencyStrings.of(context).confirmSwitchingAccount()"),
            actions: <Widget>[
              new FlatButton(
                child: Text("EmergencyStrings.of(context).oK()"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _switchAccount(userAccount, context);
                },
              ),
              new FlatButton(
                child: Text("EmergencyStrings.of(context).cancel()"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  void _switchAccount(UserAccount userAccount, BuildContext context) {
    setState(() {


      guardedUserAccounts.remove(userAccount);
      guardedUserAccounts.add(guardedCurrentAccount);
      guardedCurrentAccount = userAccount;

      widget.onSelectItem("Gym Places");
    });
  }

  List<Widget> _buildOtherAccounts(accounts) {
    var result = List<Widget>();
    if (guardedUserAccounts == null) return result;

    for (var userAccount in guardedUserAccounts) {
      result.add(new GestureDetector(
        onTap: () => _onTapOtherAccounts(context, userAccount),
        child: new Semantics(
          label: "EmergencyStrings.of(context).switchAccount()",
          child: new CircleAvatar(
            backgroundColor: Colors.brown,
            child: new Text(userAccount.abbreviation),
          ),
        ),
      ));
    }

    return result;
  }

  List<Widget> _buildUserAccounts(BuildContext context) {
    if (guardedCurrentAccount == null) return List<Widget>();

    return [
      new UserAccountsDrawerHeader(
          accountName: Text(guardedCurrentAccount.userName),
          accountEmail: Text(guardedCurrentAccount.email),
          currentAccountPicture: new CircleAvatar(
            backgroundColor: Colors.brown,
            child: new Text(guardedCurrentAccount.abbreviation),
          ),
          otherAccountsPictures: _buildOtherAccounts(guardedUserAccounts))
    ];
  }

  List<Widget> _buildDrawerList(BuildContext context) {
    List<Widget> children = [];
    children
      ..addAll(_buildUserAccounts(context))
      ..addAll([new Divider()])
      ..addAll(_buildActions(context));
    return children;
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      ListTile(
        leading: new Icon(Icons.healing),
        title: Text("Health Conditions"),
        onTap: () {
          widget.onSelectItem("HealthConditions");
        },
      ),
      const Divider(
        color: Colors.black,
      ),
      ListTile(
        leading: new Icon(Icons.account_circle),
        title: Text("User Account"),
        onTap: () {
          goToStartPage();
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (guardedCurrentAccount == null) return Container();
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero, children: _buildDrawerList(context)),
    );
  }
}
