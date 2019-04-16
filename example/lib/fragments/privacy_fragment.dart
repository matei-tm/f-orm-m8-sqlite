import 'package:flutter/material.dart';

class PrivacyFragment extends StatefulWidget {
  _PrivacyFragmentState createState() => _PrivacyFragmentState();
}

class _PrivacyFragmentState extends State<PrivacyFragment> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle titleStyle = themeData.textTheme.title;
    final TextStyle subtitleStyle = themeData.textTheme.subtitle;
    final TextStyle contentTextStyle = themeData.textTheme.body2;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(style: titleStyle, text: "Empty page"),
                      TextSpan(
                        style: contentTextStyle,
                        text: '\n\n',
                      ),
                      TextSpan(
                        style: subtitleStyle,
                        text: '\n\nNo content',
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
