import 'package:sqlite_m8_demo/models/user_account.dart';
import 'package:sqlite_m8_demo/models/user_account.g.m8.dart';
import 'package:sqlite_m8_demo/pages/helpers/db_adapter_state.dart';
import 'package:sqlite_m8_demo/routes/enhanced_route.dart';
import 'package:flutter/material.dart';

typedef AccountActionCallback = Future<bool> Function(int);

abstract class GuardedAccountState<T extends StatefulWidget>
    extends DbAdapterState<T> {
  UserAccountProxy guardedCurrentAccount;
  List<UserAccountProxy> guardedUserAccounts;

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
    await databaseProvider.setCurrentUserAccount(userAccount.id);
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
      guardedCurrentAccount = await databaseProvider.getCurrentUserAccount();
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
    guardedUserAccounts = await databaseProvider.getUserAccountProxiesAll();
    guardedUserAccounts.removeWhere((a) => a.isCurrent == true);
  }

  void goToStartPage() {
    Navigator.of(context).push(EnhancedRoute.editUser(guardedCurrentAccount));
    return;
  }
}
