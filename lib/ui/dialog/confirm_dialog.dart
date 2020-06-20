import 'package:coin_balance_calculator/model/item.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final Item item;

  const ConfirmDialog({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(item.name),
      content: Text("Confirm to delete ${item.name}"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text("Delete"),
          color: Theme.of(context).accentColor,
        )
      ],
    );
  }
}
