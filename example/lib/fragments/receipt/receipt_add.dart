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
  final _descriptionKey = Key("receiptDescriptionField");
  final _expirationKey = Key("receiptExpirationDateField");
  final _numberOfItemsKey = Key("receiptNumberOfItemsField");
  final _isBioKey = Key("receiptIsBioSwitch");
  final _quantityKey = Key("receiptQuantityField");
  final _temperatureKey = Key("receiptStorageTemperatureField");

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
            key: Key("saveReceiptButton"),
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
                    key: _descriptionKey,
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
                    key: _expirationKey,
                    //initialValue: "2061-07-28 17:50:03", // DateTime.now().add(Duration(days: 30)).toIso8601String(),
                    decoration: InputDecoration(
                      hintText: "expiration Date (format: 2071-05-30 17:50:03)",
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
                      key: _isBioKey,
                      title: const Text('Is Bio'),
                      value: _stateReceipt.isBio,
                      onChanged: (bool val) =>
                          setState(() => _stateReceipt.isBio = val)),
                  TextFormField(
                    key: _numberOfItemsKey,
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
                    key: _quantityKey,
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
                    key: _temperatureKey,
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
