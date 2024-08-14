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
