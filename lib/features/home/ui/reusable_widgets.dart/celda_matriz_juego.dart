import 'package:flutter/material.dart';

import '../views/home_view.dart';

// ignore: must_be_immutable
class CeldaMatriz extends StatefulWidget {
  CeldaMatriz(
      {super.key,
      required this.actualValue,
      required this.color,
      required this.enabled,
      required this.action,
      required this.update});
  final Function action;
  Function update;
  Player actualValue;
  bool enabled;
  Color color;
  @override
  State<CeldaMatriz> createState() => _CeldaMatrizState();
}

class _CeldaMatrizState extends State<CeldaMatriz> {
  bool isHovered = false;

  @override
  void initState() {
    widget.update = () {
      setState(() {});
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onHover: (value) {
          if (widget.enabled) {
            setState(() {
              isHovered = widget.actualValue == Player.none ? value : false;
            });
          }
        },
        onTap: () async {
          if (widget.enabled && widget.actualValue == Player.none) {
            await widget.action();
            setState(() {});
          }
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.enabled
                  ? isHovered
                      ? Colors.orange
                      : widget.color
                  : widget.color,
              border: Border.all(color: Colors.black, width: 2)),
          child: Text(
              widget.actualValue == Player.player
                  ? "X"
                  : widget.actualValue == Player.cpu
                      ? "O"
                      : "",
              style: TextStyle(
                  color: widget.actualValue == Player.player
                      ? Colors.red
                      : Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ));
  }
}
