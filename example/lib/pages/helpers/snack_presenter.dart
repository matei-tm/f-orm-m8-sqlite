import 'package:flutter/material.dart';

class SnackPresenter {
  static void showError(String message, GlobalKey<ScaffoldState> globalKey) {
    globalKey.currentState.showSnackBar(SnackBar(
      key: Key('errorSnack'),
      content: ListTile(
        title: Text('Error:'),
        subtitle: Text(
          message,
        ),
      ),
      duration: Duration(seconds: 3),
    ));
  }

  static void showInfo(String message, GlobalKey<ScaffoldState> globalKey) {
    globalKey.currentState.showSnackBar(SnackBar(
      key: Key('infoSnack'),
      content: ListTile(
        title: Text('Info:'),
        subtitle: Text(
          message,
        ),
      ),
      duration: Duration(seconds: 3),
    ));
  }
}
