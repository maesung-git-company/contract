import 'package:contract/widget/step_counter/step_counter.dart';
import 'package:flutter/material.dart';

import 'denominator.dart';
import 'percentage.dart';
import 'progress_bar.dart';

class HomePageBodyHeader extends StatefulWidget {
  const HomePageBodyHeader({super.key});

  @override
  State<HomePageBodyHeader> createState() => _HomePageBodyHeaderState();
}

class _HomePageBodyHeaderState extends State<HomePageBodyHeader> { // todo jeery 오버플로 하는거 고쳐줘
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 15,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, style: BorderStyle.solid, color: Colors.grey.shade500),
        ),
        child: Row(
          children: [
            // left side
            Flexible(
              flex: 50,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 45, 0),
                    height: 48,
                    child: StepCounter(),
                  ),
                  Denominator()
                ],
              )
            ),
            // right side
            Flexible(
              flex: 50,
              child: Column(
                children: [
                  Percentage(),
                  ProgressBar()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
