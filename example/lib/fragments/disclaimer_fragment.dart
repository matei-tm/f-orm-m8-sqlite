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
            child: new SingleChildScrollView(
              child: Padding(
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
                        text: '\n\nCRUD showcase\n',
                      ),
                      TextSpan(
                        style: contentTextStyle,
                        text: '\nHealth Conditions => DbAccountRelatedEntity',
                      ),
                      TextSpan(
                        style: contentTextStyle,
                        text: '\nGym Places => DbEntity',
                      ),
                      TextSpan(
                        style: contentTextStyle,
                        text: '\nUser Account => DbAccountEntity',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
