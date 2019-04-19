import 'package:example/main.adapter.g.m8.dart';
import 'package:example/models/receipt.dart';
import 'package:example/models/receipt.g.m8.dart';
import 'package:flutter/material.dart';

class ReceiptAddPage extends StatefulWidget {
  final Receipt _currentReceipt;

  ReceiptAddPage(this._currentReceipt);

  _ReceiptAddPageState createState() => _ReceiptAddPageState(_currentReceipt);
}

class _ReceiptAddPageState extends State<ReceiptAddPage> {
  final _formKey = GlobalKey<FormState>();

  Receipt _stateReceipt;
  String title;

  DatabaseHelper _db = DatabaseHelper();

  _ReceiptAddPageState(this._stateReceipt);

  @override
  void initState() {
    super.initState();

    _stateReceipt = _stateReceipt ??
        ReceiptProxy(
            isBio: true,
            expirationDate: null,
            quantity: null,
            numberOfItems: null,
            storageTemperature: null,
            description: null);
  }

  Future<void> submit() async {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();

      _db = DatabaseHelper();

      int id = await _db.saveReceipt(_stateReceipt);
      _stateReceipt.id = id;

      Navigator.of(context).pop(_stateReceipt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title ?? "Add Receipt"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: submit,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              autovalidate: false,
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Description",
                      labelText: "Description*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter description";
                      }
                    },
                    onSaved: (String value) {
                      _stateReceipt.description = value;
                    },
                  ),
                  // TextFormField(
                  //   decoration: new InputDecoration(
                  //     hintText: "decomposing Duration as Duration",
                  //     labelText: "decomposing Duration*",
                  //   ),
                  //   validator: (value) {
                  //     if (value.isEmpty) {
                  //       return "Please enter decomposingDuration";
                  //     }
                  //   },
                  //   onSaved: (String value) {
                  //     _stateReceipt.decomposingDuration =
                  //         Duration(hours: int.parse(value));
                  //   },
                  // ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "expiration Date (format: 2012-02-27 13:27:00)",
                      labelText: "expiration Date*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter expirationDate";
                      }
                    },
                    onSaved: (String value) {
                      _stateReceipt.expirationDate = DateTime.parse(value);
                    },
                  ),
                  SwitchListTile(
                      title: const Text('Is Bio'),
                      value: _stateReceipt.isBio,
                      onChanged: (bool val) =>
                          setState(() => _stateReceipt.isBio = val)),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "number of Items as int",
                      labelText: "number of Items*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter numberOfItems";
                      }
                    },
                    onSaved: (String value) {
                      _stateReceipt.numberOfItems = int.parse(value);
                    },
                  ),
                  // TextFormField(
                  //   decoration: new InputDecoration(
                  //     hintText: "numberOfMolecules as bigInt",
                  //     labelText: "numberOfMolecules*",
                  //   ),
                  //   validator: (value) {
                  //     if (value.isEmpty) {
                  //       return "Please enter numberOfMolecules";
                  //     }
                  //   },
                  //   onSaved: (String value) {
                  //     _stateReceipt.numberOfMolecules = BigInt.parse(value);
                  //   },
                  // ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "quantity as double",
                      labelText: "quantity*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter quantity";
                      }
                    },
                    onSaved: (String value) {
                      _stateReceipt.quantity = double.parse(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "storage Temperature as num",
                      labelText: "storage Temperature*",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter storage Temperature";
                      }
                    },
                    onSaved: (String value) {
                      _stateReceipt.storageTemperature = num.parse(value);
                    },
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
