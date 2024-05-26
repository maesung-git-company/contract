import 'dart:async';

import 'package:contract/structure/enum/pedestrian_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:pedometer/pedometer.dart';

import '../core/global.dart';
import '../structure/util/string_to_pedestrian_status.dart';

class StepCounter extends StatefulWidget {
  const StepCounter({super.key});

  @override
  State<StepCounter> createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _displayedText = '?';
  /* todo list
  - visual : first to work
  - sum : working on
  - anti cheat
   */

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initTimer();
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void initTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      final as = Global.appStatus;

      if (as.pedestrianStatus != CustomPedestrianStatus.walking) return;

      as.secondsActive += 1;
      if (as.secondsActive == 60) {
        as.secondsActive = 0;
        Global.userData!.minutesActive += 1;
      }
    });
  }

  void onStepCount(StepCount event) {
    Global.userData!.steps += 1;
    Global.serverManager.updateUserData();

    setState(() {
      _displayedText = Global.userData!.steps.toString();
    });
  }

  void onStepCountError(error) {
    setState(() {
      _displayedText = "권한을 확인해 주세요..";
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    Global.appStatus.pedestrianStatus = string2pedestrianStatus(event.status);
  }

  void onPedestrianStatusError(error) {
    Global.appStatus.pedestrianStatus = CustomPedestrianStatus.unknown;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Center(
          child: Text(
            _displayedText,
            style: TextStyle(fontSize: 60),
          )
      ),
    );
  }
}
