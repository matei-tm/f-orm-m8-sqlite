import 'package:example/fragments/contact/receipt_row.dart';
import 'package:example/main.adapter.g.m8.dart';
import 'package:example/models/receipt.dart';
import 'package:flutter/material.dart';

class ReceiptsFragment extends StatefulWidget {
  final Key _parentScaffoldKey;
  ReceiptsFragment(this._parentScaffoldKey);

  _ReceiptsFragmentState createState() => _ReceiptsFragmentState();
}

class _ReceiptsFragmentState extends State<ReceiptsFragment> {
  List<Receipt> receipts = [];

  @override
  void initState() {
    super.initState();
    _loadAsyncCurrentData().then((result) => setState(() => receipts = result));
  }

  Future<List<Receipt>> _loadAsyncCurrentData() async {
    var db = DatabaseHelper();

    return await db.getReceiptProxiesAll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView.builder(
              itemCount: receipts.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return ReceiptRow(
                  receipt: receipts[index],
                  onPressedDelete: (h) {
                    _deleteReceipt(h);
                  },
                  onPressedUpdate: (h) {
                    _updateReceipt(h);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  onPressed: () {
                    _addReceipt();
                  },
                  tooltip: "Add Receipt",
                  child: new Icon(Icons.add)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addReceipt() async {
    final result = await Navigator.of(context).pushNamed("/receipts/add");

    if (result != null) {
      receipts.add(result);
    }
  }

  Future<void> _deleteReceipt(Receipt h) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => new AlertDialog(
            title: Text("Confirm Delete Receipt"),
            actions: <Widget>[
              new FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteReceiptFromDatabase(h);
                },
              ),
              new FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  Future<void> _deleteReceiptFromDatabase(Receipt h) async {
    var db = DatabaseHelper();

    await db.deleteReceipt(h.id);
    receipts.remove(h);
    setState(() {});
  }

  Future<void> _updateReceipt(Receipt h) async {
    var db = DatabaseHelper();

    await db.updateReceipt(h);
    receipts.removeWhere((item) => item.id == h.id);
    receipts.add(h);
    setState(() {});
  }
}
