import 'dart:async';

import 'package:contract/core/config.dart';
import 'package:contract/core/global.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _displayedProgress = 0.0;

  @override
  void initState() {
    super.initState();
    const int srpt = Config.stepRequiredPerTree;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _displayedProgress = Global.userData.steps.toDouble() % srpt / srpt;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(60, 5, 10, 10),
      height: 20,
      child: Align(
        alignment: Alignment.centerRight,
        child: LinearPercentIndicator(
          width: 120,
          lineHeight: 10,
          backgroundColor: Colors.grey.shade400,
          progressColor: Color(0xff53a96a),
          percent: _displayedProgress,
          barRadius: Radius.circular(10),
        )
      ),
    );
  }
}
