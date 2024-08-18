
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
  double _progressPercentage = 0.0;

  @override
  void initState() {
    super.initState();
    const int srpt = Config.stepRequiredPerTree;
    Global.userData.addListener(this, () {
      setState(() {
        _progressPercentage = Global.userData.steps / srpt < 1
            ? Global.userData.steps / srpt
            : 1.0;
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
            width: 150,
            lineHeight: 10,
            backgroundColor: Colors.grey.shade400,
            progressColor: Color(0xff53a96a),
            percent: _progressPercentage,
            barRadius: Radius.circular(10),
          )
        ),
      ),
    );
  }
}
