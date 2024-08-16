import 'dart:async';

import 'package:contract/core/global.dart';
import 'package:contract/structure/enum/pedestrian_status.dart';
import 'package:contract/widget/class_stat_drawer/class_stat_drawer.dart';
import 'package:contract/widget/home_page_app_bar/home_page_app_bar.dart';
import 'package:contract/widget/leader_board_panel/leader_board_panel.dart';
import 'package:contract/widget/progress_panel/progress_panel.dart';
import 'package:contract/widget/tree/tree.dart';
import 'package:contract/widget/workout_stopwatch_panel/workout_stopwatch.dart';
import 'package:flutter/material.dart';


// Color Codes
// #2E3532
// #7E9181
// #A0AAB2

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initTimer();
  }

  // void sendClassListPageNav() { // todo connect this to home page, scroll?
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ClassListPage()),
  //   );
  // }

  void initTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      final as = Global.appStatus;

      if (as.pedestrianStatus != CustomPedestrianStatus.walking) return;

      Global.userData.secondsActive += 1;
    });

    Timer.periodic(Duration(seconds: 5), (timer) {
      Global.userData.onUpdate();
      // onUpdate() method is for when userData is modified
      // but this time i'm calling it manually so the app can sync with the server
      Global.serverManager.updateUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: HomePageAppBar(),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Tree(),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    children: [
                      ProgressPanel(),
                      WorkoutStopwatchPanel(),
                      LeaderBoardPanel()
                    ],
                  ),
                ),
              )
            ],
          )
        ),
        drawer: ClassStatDrawer(),
        drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      ),
    );
  }
}
