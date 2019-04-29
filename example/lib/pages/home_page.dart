import 'package:example/fragments/disclaimer_fragment.dart';
import 'package:example/fragments/gym_places_fragment.dart';
import 'package:example/fragments/health_records_fragment.dart';
import 'package:example/fragments/receipts_fragment.dart';
import 'package:example/pages/helpers/app_drawer.dart';
import 'package:flutter/material.dart';

class HomePageRoute extends MaterialPageRoute {
  HomePageRoute() : super(builder: (context) => HomePage());
}

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  HomePage({Key key, this.scaffoldKey}) : super(key: key);

  static const String routeName = '/';

  @override
  HomePageState createState() {
    return HomePageState(scaffoldKey);
  }
}

class HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey; // = GlobalKey<ScaffoldState>();
  String title;

  HomePageState(scaffoldKey);

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
      case "Health Records":
        return HealthRecordsFragment(scaffoldKey);
      case "Gym Places":
        return GymPlacesFragment(scaffoldKey);
      case "Receipts":
        return ReceiptsFragment(scaffoldKey);
      case "Disclaimer":
        return DisclaimerFragment();
      default:
        return Text("Error");
    }
  }

  String _selectedDrawerIndex = "Disclaimer";

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
        key: scaffoldKey,
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
