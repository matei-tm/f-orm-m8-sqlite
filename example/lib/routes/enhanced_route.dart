import 'package:sqlite_m8_demo/fragments/receipt/receipt_edit.dart';
import 'package:sqlite_m8_demo/models/receipt.dart';
import 'package:sqlite_m8_demo/models/user_account.dart';
import 'package:sqlite_m8_demo/pages/account_page.dart';
import 'package:flutter/material.dart';

class EnhancedRoute extends MaterialPageRoute {
  EnhancedRoute(UserAccount userAccount)
      : super(builder: (context) => AccountPage(userAccount));
  EnhancedRoute.editReceipt(Receipt receipt)
      : super(builder: (context) => ReceiptEditPage(currentReceipt: receipt));
}
