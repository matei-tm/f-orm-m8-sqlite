import 'package:sqlite_m8_demo/models/receipt.dart';
import 'package:flutter/material.dart';

typedef ReceiptRowActionCallback = void Function(Receipt receipt);

class ReceiptRow extends StatelessWidget {
  static const double height = 300.0;

  final RoundedRectangleBorder shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0),
    ),
  );

  final ReceiptRowActionCallback onPressedUpdate;
  final ReceiptRowActionCallback onPressedDelete;

  ReceiptRow({this.receipt, this.onPressedDelete, this.onPressedUpdate})
      : super(key: ObjectKey(receipt));

  final Receipt receipt;

  GestureTapCallback _getHandler(ReceiptRowActionCallback callback) {
    return callback == null ? null : () => callback(receipt);
  }

  @override
  Widget build(BuildContext context) {
    if (receipt == null) {
      return Container();
    }

    final _updateReceiptKey = Key("updBtnReceipt${receipt?.id}");
    final _deleteReceiptKey = Key("delBtnReceipt${receipt?.id}");

    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.black);
    final TextStyle descriptionStyle = theme.textTheme.subhead;

    return InkWell(
      child: Container(
        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 6.0),
        height: height,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Theme.of(context).dividerColor))),
        child: Card(
          shape: shape,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: DefaultTextStyle(
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: descriptionStyle,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "${receipt?.description}",
                            style: titleStyle,
                          ),
                        ),
                        Text("Decomposing: ${receipt?.decomposingDuration}"),
                        Text("Nr of molecules: ${receipt?.numberOfMolecules}"),
                        Text("Id: ${receipt?.id}"),
                        Text("Expiration Date: ${receipt?.expirationDate}"),
                        Text("Is Bio: ${receipt?.isBio}"),
                        Text("Number of Items: ${receipt?.numberOfItems}"),
                        Text("Quantity: ${receipt?.quantity}"),
                        Text(
                            "Storage Temperature: ${receipt?.storageTemperature}\u00b0"),
                      ],
                    ),
                  ),
                ),
              ),
              // share, explore buttons
              ButtonTheme.bar(
                child: ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      key: _updateReceiptKey,
                      child: Text(
                        "Edit",
                      ),
                      textColor: Theme.of(context).accentColor,
                      onPressed: _getHandler(onPressedUpdate),
                    ),
                    FlatButton(
                      key: _deleteReceiptKey,
                      child: Text(
                        "Delete",
                      ),
                      textColor: Theme.of(context).accentColor,
                      onPressed: _getHandler(onPressedDelete),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
