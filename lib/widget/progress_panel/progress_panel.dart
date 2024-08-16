import 'package:contract/widget/progress_panel/denominator.dart';
import 'package:contract/widget/progress_panel/percentage.dart';
import 'package:contract/widget/progress_panel/progress_bar.dart';
import 'package:contract/widget/progress_panel/step_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressPanel extends StatefulWidget {
  const ProgressPanel({super.key});

  @override
  State<ProgressPanel> createState() => _ProgressPanelState();
}

class _ProgressPanelState extends State<ProgressPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          // left side
          Flexible(
              flex: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 25,
                  ),
                  StepCounter(),
                  Denominator(),
                ],
              )
          ),
          // right side
          Flexible(
            flex: 50,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 30,
                ),
                Percentage(),
                ProgressBar(),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
