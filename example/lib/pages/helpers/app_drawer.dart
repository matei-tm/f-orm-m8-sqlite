import 'package:example/models/user_account.dart';
import 'package:example/pages/helpers/guarded_account_state.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  final void Function(String) onSelectItem;

  const AppDrawer(
    this.onSelectItem, {
    Key key,
  }) : super(key: key);

  @override
  State createState() => AppDrawerState();
}

class AppDrawerState extends GuardedAccountState<AppDrawer> {
  _onTapOtherAccounts(BuildContext context, UserAccount userAccount) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            title: Text("Confirm Switching Account"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  switchAccount(userAccount, context);
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

  @override
  Future switchAccount(UserAccount userAccount, BuildContext context) async {
    await super.switchAccount(userAccount, context);
    widget.onSelectItem("Disclaimer");
  }

  List<Widget> _buildOtherAccounts(accounts) {
    var result = List<Widget>();
    if (guardedUserAccounts == null) return result;

    for (var userAccount in guardedUserAccounts) {
      result.add(GestureDetector(
        onTap: () => _onTapOtherAccounts(context, userAccount),
        child: Semantics(
          label: "Switch account",
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: Text(userAccount.abbreviation),
          ),
        ),
      ));
    }

    return result;
  }

  List<Widget> _buildUserAccounts(BuildContext context) {
    if (guardedCurrentAccount == null) return List<Widget>();

    return [
      UserAccountsDrawerHeader(
          accountName: Text(guardedCurrentAccount.userName),
          accountEmail: Text(guardedCurrentAccount.email),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              guardedCurrentAccount.abbreviation,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          otherAccountsPictures: _buildOtherAccounts(guardedUserAccounts))
    ];
  }

  List<Widget> _buildDrawerList(BuildContext context) {
    List<Widget> children = [];
    children
      ..addAll(_buildUserAccounts(context))
      ..addAll(_buildActions(context));
    return children;
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.healing),
        title: Text("Health Records"),
        onTap: () {
          widget.onSelectItem("Health Records");
        },
      ),
      ListTile(
        leading: Icon(Icons.fitness_center),
        title: Text("Gym Places"),
        onTap: () {
          widget.onSelectItem("Gym Places");
        },
      ),
      ListTile(
        leading: Icon(Icons.receipt),
        title: Text("Receipts"),
        onTap: () {
          widget.onSelectItem("Receipts");
        },
      ),
      ListTile(
        leading: Icon(Icons.verified_user),
        title: Text("Disclaimer"),
        onTap: () {
          widget.onSelectItem("Disclaimer");
        },
      ),
      const Divider(
        color: Colors.black,
      ),
      ListTile(
        leading: Icon(Icons.account_circle),
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
