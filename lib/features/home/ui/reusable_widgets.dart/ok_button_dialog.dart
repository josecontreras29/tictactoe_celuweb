import 'package:flutter/material.dart';

Future<dynamic> okButton(BuildContext context, String title) {
  return showDialog(
      context: context,
      builder: (context) => Dialog(
              child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Accept")),
                )
              ],
            ),
          )));
}
