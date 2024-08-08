import 'package:flutter/material.dart';

class MainBox extends StatelessWidget {
  MainBox({super.key,
    required this.theTop,
    required this.theBottom,
    required this.theChild,
    });

  final theTop;
  final theBottom;
  final theChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, theTop, 10, theBottom),
      width: 100,
      height: 100,
      child: theChild,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, style: BorderStyle.solid, color: Colors.grey.shade500),
      ),
    );
  }
}
