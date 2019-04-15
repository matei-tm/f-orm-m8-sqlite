import 'package:example/fragments/health_conditions_fragment.dart';
import 'package:example/pages/account_page.dart';
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/HealthCondition',
      routes: {
        '/': (context) => HealthConditionsFragment(),
        '/HealthCondition': (context) => AccountPage(),
      },
    );
  }
}
