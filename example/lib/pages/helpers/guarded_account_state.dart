import 'package:example/main.adapter.g.m8.dart';
import 'package:example/models/user_account.dart';
import 'package:example/routes/start_page_route.dart';
import 'package:flutter/material.dart';

typedef AccountActionCallback = Future<bool> Function();

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
        callExtraLoad().then((result) {
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

  @override
  Widget build(BuildContext context) {
    return null;
  }

  Future<bool> _loadAsyncData() async {
    try {
      guardedCurrentAccount = await _db.getCurrentUserAccount();
      if (guardedCurrentAccount == null) {
        goToStartPage();
      }

      await _loadNonCurrentAccounts();
      return true;
    } catch (ex) {
      print(ex.toString());
      return false;
    }
  }

  Future _loadNonCurrentAccounts() async {
    guardedUserAccounts = await _db.getUserAccountProxiesAll();
    guardedUserAccounts.removeWhere((a) => a.isCurrent == true);
  }

  void goToStartPage() {
    Navigator.pushReplacement(context, StartPageRoute());
    return;
  }
}
