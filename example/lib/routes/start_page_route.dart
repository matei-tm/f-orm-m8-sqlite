import 'package:example/fragments/health_conditions_fragment.dart';
import 'package:example/pages/account_page.dart';
import 'package:flutter/material.dart';

class StartPageRoute extends MaterialPageRoute {
  StartPageRoute() : super(builder: (context) => AccountPage());

  // StartPageRoute.goToDrawer()
  //     : super(builder: (context) => HealthConditionsFragment());
}
