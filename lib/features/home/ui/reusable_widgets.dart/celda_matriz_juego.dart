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
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: widget.enabled
                  ? isHovered
                      ? Colors.orange
                      : widget.color
                  : widget.color,
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
              widget.actualValue == Player.player
                  ? "X"
                  : widget.actualValue == Player.cpu
                      ? "O"
                      : "",
              style: TextStyle(
                  color: widget.actualValue == Player.player
                      ? Colors.red
                      : Colors.yellow,
                  fontSize: 60,
                  fontWeight: FontWeight.w900)),
        ));
  }
}
