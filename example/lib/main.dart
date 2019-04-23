import 'package:example/fragments/contact/receipt_add.dart';
import 'package:example/main.adapter.g.m8.dart';
import 'package:example/pages/account_page.dart';
import 'package:example/pages/home_page.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
void main() => runApp(GymspectorApp(scaffoldKey));

class GymspectorApp extends StatelessWidget {
  GymspectorApp(GlobalKey<ScaffoldState> scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'orm-m8 Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(
        title: 'orm-m8 Demo Home Page',
        scaffoldKey: scaffoldKey,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  var scaffoldKey;

  MyHomePage({Key key, this.title, this.scaffoldKey}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState(scaffoldKey);
}

class MyHomePageState extends State<MyHomePage> {
  String _currentRoute;

  var scaffoldKey;

  MyHomePageState(this.scaffoldKey);

  @override
  void initState() {
    super.initState();

    _getInitialRoute().then((initialRoute) {
      this._currentRoute = initialRoute;
      setState(() {
        print("Initial route is $initialRoute");
      });
    });
  }

  Future<String> _getInitialRoute() async {
    var _db = DatabaseHelper();
    if (_db.extremeDevelopmentMode) {
      return 'start';
    }

    var _currentAccount = await _db.getCurrentUserAccount();
    if (_currentAccount == null) {
      return 'start';
    } else {
      return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_currentRoute == null)
        ? Container()
        : MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            initialRoute: _currentRoute,
            routes: {
              '/': (context) => HomePage(
                    scaffoldKey: scaffoldKey,
                  ),
              '/receipts/add': (context) => ReceiptAddPage(null),
              'start': (context) => AccountPage(null),
            },
          );
  }
}
