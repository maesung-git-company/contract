
import 'dart:math';

import 'package:contract/core/config.dart';
import 'package:contract/core/data_storage.dart';
// ignore: unused_import
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
  late double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    progress = min(DataStorage.userData.steps / Config.stepRequiredPerTree, 1.0);

    return Skeleton.shade(
      child: Container(
        margin: EdgeInsets.fromLTRB(35, 0, 0, 0),
        height: 20,
        child: Center(
          child: LinearPercentIndicator(
            width: 150,
            lineHeight: 10,
            backgroundColor: Colors.grey.shade400,
            progressColor: Color(0xff53a96a),
            percent: progress,
            barRadius: Radius.circular(10),
          )
        ),
      ),
    );
  }
}
