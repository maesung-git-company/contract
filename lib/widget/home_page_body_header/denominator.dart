import 'package:contract/core/config.dart';
import 'package:flutter/material.dart';

class Denominator extends StatefulWidget {
  const Denominator({super.key});

  @override
  State<Denominator> createState() => _DenominatorState();
}

class _DenominatorState extends State<Denominator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(35, 5, 35, 15),
      height: 26,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('/ ${Config.stepRequiredPerTree} steps',
          style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 20
          ),
        ),
      ),
    );
  }
}
