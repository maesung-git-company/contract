import 'package:contract/widget/step_counter.dart';
import 'package:flutter/material.dart';

import '../structure/class/activity_data.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, this.activityData});

  final activityData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      color: Colors.blue,
      child: StepCounter(),
    );
  }
}
