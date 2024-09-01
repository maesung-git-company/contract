// ignore: unused_import
import 'package:contract/core/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WorkoutStopwatchPanel extends StatefulWidget {
  const WorkoutStopwatchPanel({super.key});

  @override
  State<WorkoutStopwatchPanel> createState() => _WorkoutStopwatchPanelState();
}

class _WorkoutStopwatchPanelState extends State<WorkoutStopwatchPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 20, 20, 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "${addPadding(Global.ds.userData.secondsActive ~/ (60 * 60), 2)}"
                    ":${addPadding(Global.ds.userData.secondsActive ~/ 60, 2)}",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "  Workouts this day",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade600,
                  letterSpacing: 1.1
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


String addPadding(int x, int till) {
  String res = x.toString();
  while (res.length < till) {
    res = "0$res";
  }
  return res;
}
