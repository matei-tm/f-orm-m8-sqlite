import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/pages/account_page.dart';
import 'package:sqlite_m8_demo/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(GymspectorApp(DatabaseHelper()));

class GymspectorApp extends StatelessWidget {
  final databaseHelper;

  GymspectorApp(this.databaseHelper);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'orm-m8 Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(
          title: 'orm-m8 Demo Home Page', databaseHelper: databaseHelper),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static MyHomePageState myState;

  MyHomePage({Key key, this.title, this.databaseHelper}) : super(key: key);

  final String title;
  final DatabaseHelper databaseHelper;

  @override
  MyHomePageState createState() {
    myState = MyHomePageState();
    return myState;
  }
}

class MyHomePageState extends State<MyHomePage> {
  String _currentRoute;

  MyHomePageState();

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
    var _db = widget.databaseHelper;
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
            key: const ValueKey<String>('OrmM8Example'),
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
