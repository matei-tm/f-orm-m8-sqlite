import 'package:flutter/material.dart';

class PrivacyFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle titleStyle = themeData.textTheme.title;
    final TextStyle subtitleStyle = themeData.textTheme.subtitle;
    final TextStyle contentTextStyle = themeData.textTheme.body2;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(style: titleStyle, text: "Disclaimer"),
                  TextSpan(
                    style: contentTextStyle,
                    text: '\nThis is a sample application\n',
                  ),
                  TextSpan(
                    style: subtitleStyle,
                    text: '\n\nNo content',
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
