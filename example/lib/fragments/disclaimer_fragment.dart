import 'package:flutter/material.dart';

class DisclaimerFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle headlineStyle = themeData.textTheme.headline;
    final TextStyle titleStyle = themeData.textTheme.title;
    final TextStyle subtitleStyle = themeData.textTheme.subtitle;
    final TextStyle contentTextStyle = themeData.textTheme.body1;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(style: headlineStyle, text: "Disclaimer"),
                          TextSpan(
                            style: contentTextStyle,
                            text:
                                '\n\nThis is a demo application. Do not use for production purposes\n',
                          ),
                          TextSpan(
                            style: titleStyle,
                            text: '\n\nPurpose\n',
                          ),
                          TextSpan(
                            style: contentTextStyle,
                            text:
                                '\nThe only purpose of this example is to be a showcase of flutter-sqlite-m8 generator based on the orm-m8 annotation framework\n',
                          ),
                          TextSpan(
                            style: titleStyle,
                            text: '\n\nDependencies\n',
                          ),
                          TextSpan(
                            style: subtitleStyle,
                            text: '\nflutter-sqlite-m8\nflutter-orm-m8',
                          ),
                          TextSpan(
                            style: titleStyle,
                            text: '\n\nCRUD showcase',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            style: subtitleStyle,
                            text: 'Interface: DbAccountEntity',
                          ),
                          TextSpan(
                            style: contentTextStyle,
                            text:
                                '\nExample: User Account\nModel: UserAccount\nField types: bool, int, String',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, right: 30.0, left: 30.0, bottom: 50.0),
                    child: Image.asset("docs/usecase001-320.gif"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            style: subtitleStyle,
                            text: 'Interface: DbAccountRelatedEntity',
                          ),
                          TextSpan(
                            style: contentTextStyle,
                            text:
                                '\nExample: Health Records\nModel: HealthEntry\nField types: DateTime, int, String',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, right: 30.0, left: 30.0, bottom: 50.0),
                    child: Image.asset("docs/usecase002-320.gif"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            style: subtitleStyle,
                            text: 'Interface: DbEntity',
                          ),
                          TextSpan(
                            style: contentTextStyle,
                            text:
                                '\nExample: Gym Places\nModel: GymLocation\nField types: int, String',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, right: 30.0, left: 30.0, bottom: 50.0),
                    child: Image.asset("docs/usecase003-320.gif"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            style: subtitleStyle,
                            text: 'Interface: DbEntity',
                          ),
                          TextSpan(
                            style: contentTextStyle,
                            text:
                                '\nExample: Receipts\nModel: Receipt\nField types: bool, DateTime, double, int, num, String',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0, right: 30.0, left: 30.0, bottom: 50.0),
                    child: Image.asset("docs/usecase004-320.gif"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
