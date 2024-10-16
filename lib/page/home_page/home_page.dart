
import 'package:contract/widget/home_page_app_bar/home_page_app_bar.dart';
import 'package:contract/widget/leader_board_panel/leader_board_panel.dart';
import 'package:contract/widget/progress_panel/progress_panel.dart';
import 'package:contract/widget/tree/tree.dart';
import 'package:contract/widget/workout_stopwatch_panel/workout_stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';


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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: HomePageAppBar(),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Tree(),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: ProgressPanel(),
                      ),
                      Flexible(
                        flex: 2,
                        child: WorkoutStopwatchPanel(),
                      ),
                      Flexible(
                        flex: 5,
                        child: LeaderBoardPanel(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}