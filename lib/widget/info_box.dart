import 'package:flutter/material.dart';

class MainBox extends StatelessWidget {
  const MainBox({super.key, 
    required this.theWidth, 
    required this.theHeight,
    required this.theChild});
    
  final theChild;
  final theWidth;
  final theHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: theWidth,
      height: theHeight,
      child: theChild,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, style: BorderStyle.solid, color: Colors.grey.shade500),
      ),
    );
  }
}
