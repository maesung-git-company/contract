import 'package:flutter/material.dart';

class MainBox extends StatelessWidget {
  const MainBox({super.key, 
    required this.theWidth, 
    required this.theHeight,
    required this.theChild,
    required this.theTop,
    required this.theBottom,
    });
    
  final theChild;
  final theWidth;
  final theHeight;
  final theTop;
  final theBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, theTop, 10, theBottom),
      width: theWidth,
      height: theHeight,
      child: theChild,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, style: BorderStyle.solid, color: Colors.grey.shade500),
      ),
    );
  }
}

class IndicatorBar extends StatelessWidget {
  const IndicatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 80,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, style: BorderStyle.solid, color: Colors.grey.shade500),
      ),
    );
  }
}