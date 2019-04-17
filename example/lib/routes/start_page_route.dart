import 'package:example/models/user_account.dart';
import 'package:example/pages/account_page.dart';
import 'package:flutter/material.dart';

class StartPageRoute extends MaterialPageRoute {
  StartPageRoute(UserAccount userAccount)
      : super(builder: (context) => AccountPage(userAccount));
}
