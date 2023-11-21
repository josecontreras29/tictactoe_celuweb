import 'package:flutter/material.dart';

class BackgroundTablero extends StatelessWidget {
  const BackgroundTablero({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Center(
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.deepPurple[300],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[900]!,
                          spreadRadius: 1,
                          blurRadius: 3)
                    ]),
                child: child)));
  }
}
