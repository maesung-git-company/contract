import 'dart:async';

import 'package:contract/core/config.dart';
import 'package:contract/core/global.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    return Skeleton.shade(
      child: Container(
        margin: EdgeInsets.fromLTRB(35, 0, 0, 0),
        height: 20,
        child: Center(
          child: LinearPercentIndicator(
            width: 170,
            lineHeight: 10,
            backgroundColor: Colors.grey.shade400,
            progressColor: Color(0xff53a96a),
            percent: _displayedProgress,
            barRadius: Radius.circular(10),
          )
        ),
      ),
    );
  }
}
