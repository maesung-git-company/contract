import 'package:contract/widget/progress_panel/denominator.dart';
import 'package:contract/widget/progress_panel/percentage.dart';
import 'package:contract/widget/progress_panel/progress_bar.dart';
import 'package:contract/widget/progress_panel/step_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          // Left side
          Flexible(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: StepCounter(),
                  ),
                  Flexible(
                    flex: 1,
                    child: Denominator(),
                  ),
                ],
              ),
            ),
          ),
          //-------------------------------------------------------------------//
          // Right side
          Flexible(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Percentage(),
                  ),
                  Flexible(
                    flex: 1,
                    child: ProgressBar(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

