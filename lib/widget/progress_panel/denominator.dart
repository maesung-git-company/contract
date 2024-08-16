import 'package:contract/core/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Denominator extends StatefulWidget {
  const Denominator({super.key});

  @override
  State<Denominator> createState() => _DenominatorState();
}

class _DenominatorState extends State<Denominator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('/${NumberFormat('#,###').format(Config.stepRequiredPerTree)} steps',
          style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}
