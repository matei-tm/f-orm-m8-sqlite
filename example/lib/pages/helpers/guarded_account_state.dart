import 'package:example/main.adapter.g.m8.dart';
import 'package:example/models/user_account.dart';
import 'package:example/routes/enhanced_route.dart';
import 'package:flutter/material.dart';

typedef AccountActionCallback = Future<bool> Function(int);

abstract class GuardedAccountState<T extends StatefulWidget> extends State<T> {
  UserAccount guardedCurrentAccount;
  List<UserAccount> guardedUserAccounts;

  var _db = DatabaseHelper();

  AccountActionCallback callExtraLoad;

  @override
  void initState() {
    super.initState();

    _loadAsyncData().then((result) {
      if (callExtraLoad != null) {
        print("Guarded extra load is called");
        callExtraLoad(result).then((result) {
          setState(() {
            print("Loading extra is $result");
          });
        });
      } else {
        setState(() {
          print("Loading only accounts is $result");
        });
      }
    });
  }

  Future switchAccount(UserAccount userAccount, BuildContext context) async {
    await _db.setCurrentUserAccount(userAccount.id);
    guardedUserAccounts.remove(userAccount);
    guardedUserAccounts.add(guardedCurrentAccount);
    guardedCurrentAccount = userAccount;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }

  Future<int> _loadAsyncData() async {
    try {
      guardedCurrentAccount = await _db.getCurrentUserAccount();
      if (guardedCurrentAccount == null) {
        goToStartPage();
      }

      await _loadNonCurrentAccounts();
      return guardedCurrentAccount.id;
    } catch (ex) {
      print(ex.toString());
      return 0;
    }
  }

  Future _loadNonCurrentAccounts() async {
    guardedUserAccounts = await _db.getUserAccountProxiesAll();
    guardedUserAccounts.removeWhere((a) => a.isCurrent == true);
  }

  void goToStartPage() {
    Navigator.of(context).push(GymspectorRoute(guardedCurrentAccount));
    return;
  }
}
