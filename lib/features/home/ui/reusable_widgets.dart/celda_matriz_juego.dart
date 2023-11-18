import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CeldaMatriz extends StatefulWidget {
  CeldaMatriz(
      {super.key,
      required this.valueCell,
      required this.action,
      required this.update});
  final Function action;
  Function update;
  String valueCell;
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
          setState(() {
            isHovered = widget.valueCell == "" ? value : false;
          });
        },
        onTap: () async {
          if (widget.valueCell == "") {
            await widget.action();
            setState(() {});
          }
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isHovered ? Colors.orange : Colors.transparent,
              border: Border.all(color: Colors.black, width: 2)),
          child: Text(widget.valueCell,
              style: Theme.of(context).textTheme.headlineSmall),
        ));
  }
}
