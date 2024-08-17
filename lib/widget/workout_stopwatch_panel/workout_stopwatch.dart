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
  void initState() {
    super.initState();
    Global.userData.addListener(() { setState(() {}); });
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 25, 20, 25),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  "${addPadding(Global.userData.secondsActive ~/ (60 * 60), 2)}"
                      ":${addPadding(Global.userData.secondsActive ~/ 60, 2)}",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Workouts this day",
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
