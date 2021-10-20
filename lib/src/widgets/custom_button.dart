import 'package:flutter/material.dart';

class CustomeWidgets {
  static Widget customButton({
    required String btnName,
    required void Function() onPressed,
  }) {
    return MaterialButton(
        height: 40,
        minWidth: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.blue,
        disabledColor: Colors.grey,
        child: Text(
          btnName,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
        onPressed: onPressed);
  }
}
