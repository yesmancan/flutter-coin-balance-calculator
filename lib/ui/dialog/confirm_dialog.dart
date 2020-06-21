import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String name;

  const ConfirmDialog({ this.name});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(name),
      content: Text("Confirm to delete $name"),
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
