import 'package:example/main.adapter.g.m8.dart';
import 'package:example/pages/account_page.dart';
import 'package:example/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(GymspectorApp());

class GymspectorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'orm-m8 Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'orm-m8 Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String _currentRoute;

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
              '/': (context) => HomePage(),
              'start': (context) => AccountPage(null),
            },
          );
  }
}
