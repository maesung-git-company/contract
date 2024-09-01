import 'dart:async';

import 'package:contract/core/data_storage.dart';
import 'package:contract/structure/enum/custom_pedestrian_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';

import '../../core/global.dart';
import '../../structure/util/string_to_pedestrian_status.dart';

class StepCounter extends StatefulWidget {
  const StepCounter({super.key});

  @override
  State<StepCounter> createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount);

    if (!mounted) return;
  }

  void onStepCount(StepCount event) {
    Global.ds.addStep();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    Global.appStatus.pedestrianStatus = string2pedestrianStatus(event.status);
  }

  void onPedestrianStatusError(error) {
    Global.appStatus.pedestrianStatus = CustomPedestrianStatus.unknown;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Text(context.watch<DataStorage>().userData.steps.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}