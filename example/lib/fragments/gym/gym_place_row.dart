import 'package:example/models/gym_location.g.m8.dart';
import 'package:flutter/material.dart';

typedef GymLocationRowActionCallback = void Function(
    GymLocationProxy gymLocation);

class GymLocationRow extends StatelessWidget {
  GymLocationRow({
    this.gymLocation,
    this.onPressed,
  }) : super(key: ObjectKey(gymLocation));

  final GymLocationProxy gymLocation;

  final GymLocationRowActionCallback onPressed;

  GestureTapCallback _getHandler(GymLocationRowActionCallback callback) {
    return callback == null ? null : () => callback(gymLocation);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 6.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor))),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                  children: <Widget>[
                    Expanded(flex: 1, child: Text(gymLocation.description)),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline:
                      DefaultTextStyle.of(context).style.textBaseline),
            ),
            IconButton(
              key: Key('delBtnGymPlace${gymLocation.id}'),
              icon: const Icon(Icons.delete),
              color: Theme.of(context).accentColor,
              onPressed: _getHandler(onPressed),
            ),
          ],
        ),
      ),
    );
  }
}
