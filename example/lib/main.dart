import 'package:sqlite_m8_demo/main.adapter.g.m8.dart';
import 'package:sqlite_m8_demo/pages/account_page.dart';
import 'package:sqlite_m8_demo/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(GymspectorApp(DatabaseProvider(DatabaseAdapter())));

class GymspectorApp extends StatelessWidget {
  final databaseProvider;

  GymspectorApp(this.databaseProvider);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'orm-m8 Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(
          title: 'orm-m8 Demo Home Page3', databaseProvider: databaseProvider),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static MyHomePageState myState;

  MyHomePage({Key key, this.title, this.databaseProvider}) : super(key: key);

  final String title;
  final DatabaseProvider databaseProvider;

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
    var _db = widget.databaseProvider;

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
            debugShowCheckedModeBanner: false,
            initialRoute: _currentRoute,
            routes: {
              '/': (context) => HomePage(),
              'start': (context) => AccountPage(null),
            },
          );
  }
}
