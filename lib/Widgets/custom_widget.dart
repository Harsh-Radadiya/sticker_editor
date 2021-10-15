import 'package:flutter/material.dart';

class CustomeWidgets {
  static Widget customButton({
    required String btnName,
    required void Function() onPressed,
  }) {
    return MaterialButton(
        height: 40,
        minWidth: 110,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.blueGrey,
        disabledColor: Colors.grey,
        child: Text(
          btnName,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
        onPressed: onPressed);
  }
}
