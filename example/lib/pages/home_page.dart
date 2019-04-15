import 'package:example/fragments/health_conditions_fragment.dart';
import 'package:example/pages/app_drawer.dart';
import 'package:flutter/material.dart';

class HomePageRoute extends MaterialPageRoute {
  HomePageRoute() : super(builder: (context) => new HomePage());
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static const String routeName = '/';
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String title;

  _onSelectItem(String key, {bool fromDrawer = true}) {
    this.title = parseKey(key);

    setState(() => _selectedDrawerIndex = key);
    if (fromDrawer) {
      Navigator.of(context).pop();
    }
  }

  String parseKey(String key) {
    return key;
  }

  @override
  void initState() {
    super.initState();
    _appDrawer = new AppDrawer(_onSelectItem);
  }

  AppDrawer _appDrawer;
  _getDrawerItemWidget(String pos) {
    switch (pos) {
      case "Health Conditions":
        return new HealthConditionsFragment();
      case "Gym Places":
        return new HealthConditionsFragment();
      default:
        return new Text("Error");
    }
  }

  String _selectedDrawerIndex = "Health Conditions";

  @override
  Widget build(BuildContext context) {
    return _buildFragment(_selectedDrawerIndex);
  }

  dynamic _buildFragment(String selectedDrawerIndex) {
    if (selectedDrawerIndex == "Account") {
      print("We should never get here");
    }

    return new WillPopScope(
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(this.title ?? "Gymspector"),
          actions: <Widget>[],
        ),
        drawer: _appDrawer,
        body: _getDrawerItemWidget(selectedDrawerIndex),
      ),
      onWillPop: () {
        return new Future(() => false);
      },
    );
  }
}
