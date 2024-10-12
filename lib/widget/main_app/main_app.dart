import 'dart:async';

import 'package:contract/core/config.dart';
import 'package:contract/core/data_storage.dart';
import 'package:contract/core/global.dart';
import 'package:contract/core/manager/s_pref_manager.dart';
import 'package:contract/page/class_stat_page/class_stat_page.dart';
import 'package:contract/page/home_page/home_page.dart';
import 'package:contract/page/school_stat_page/school_stat_page.dart';
import 'package:contract/structure/enum/custom_pedestrian_status.dart';
import 'package:contract/structure/util/string_to_pedestrian_status.dart';
import 'package:contract/widget_functional/swipe_app/swipe_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Timer activityTracker;
  late Timer cacheSyncer;
  late Timer userDataUploader;

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  late int _lastSteps = -1;

  @override
  void initState() {
    super.initState();
    initTimer();
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
    if (_lastSteps == -1) {
      _lastSteps = event.steps;
      Global.ds.addStep();
    }
    Global.ds.addStep(n: (event.steps - _lastSteps));
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    Global.appStatus.pedestrianStatus = string2pedestrianStatus(event.status);
  }

  void onPedestrianStatusError(error) {
    Global.appStatus.pedestrianStatus = CustomPedestrianStatus.unknown;
  }

  void initTimer() {
    activityTracker = Timer.periodic(Duration(seconds: Config.activityTrackerDelayS), (timer) {
      final as = Global.appStatus;

      if (as.pedestrianStatus != CustomPedestrianStatus.walking) return;

      Global.ds.addActiveTime();
    });

    cacheSyncer = Timer.periodic(Duration(seconds: Config.cacheSyncerDelayS), (timer) {
      Global.ds.tryTotalSyncExceptUser();
    });

    userDataUploader = Timer.periodic(Duration(seconds: Config.userDataUploaderDelayS), (timer) {
      Global.ds.tryUploadUserData();
      SPrefManager.saveUserData(Global.ds.userData);
    });
  }

  @override
  void dispose() {
    activityTracker.cancel();
    cacheSyncer.cancel();
    userDataUploader.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => Global.ds,
      child: SwipeApp(
        pages: [
          HomePage(),
          ClassStatPage(),
          SchoolStatPage(),
        ],
        initialPageIndex: 0,
      ),
    );
  }
}
