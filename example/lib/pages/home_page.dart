import 'package:example/fragments/health_conditions_fragment.dart';
import 'package:example/fragments/privacy_fragment.dart';
import 'package:example/pages/helpers/app_drawer.dart';
import 'package:flutter/material.dart';

class HomePageRoute extends MaterialPageRoute {
  HomePageRoute() : super(builder: (context) => HomePage());
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  static const String routeName = '/';
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
    _appDrawer = AppDrawer(_onSelectItem);
  }

  AppDrawer _appDrawer;
  _getDrawerItemWidget(String pos) {
    switch (pos) {
      case "Health Conditions":
        return HealthConditionsFragment(_scaffoldKey);
      case "Gym Places":
        return PrivacyFragment();
      default:
        return Text("Error");
    }
  }

  String _selectedDrawerIndex = "Gym Places";

  @override
  Widget build(BuildContext context) {
    return _buildFragment(_selectedDrawerIndex);
  }

  dynamic _buildFragment(String selectedDrawerIndex) {
    if (selectedDrawerIndex == "Account") {
      print("We should never get here");
    }

    return WillPopScope(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(this.title ?? "Gymspector"),
          actions: <Widget>[],
        ),
        drawer: _appDrawer,
        body: _getDrawerItemWidget(selectedDrawerIndex),
      ),
      onWillPop: () {
        return Future(() => false);
      },
    );
  }
}
