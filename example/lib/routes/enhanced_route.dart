import 'package:example/fragments/contact/receipt_edit.dart';
import 'package:example/models/receipt.dart';
import 'package:example/models/user_account.dart';
import 'package:example/pages/account_page.dart';
import 'package:flutter/material.dart';

class GymspectorRoute extends MaterialPageRoute {
  GymspectorRoute(UserAccount userAccount)
      : super(builder: (context) => AccountPage(userAccount));
  GymspectorRoute.editReceipt(Receipt receipt)
      : super(
            builder: (context) => ReceiptEditPage(currentReceipt: receipt));
}
