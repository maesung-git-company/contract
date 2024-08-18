import 'package:contract/core/config.dart';
import 'package:contract/core/global.dart';
import 'package:contract/structure/class/class_data.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:contract/structure/util/data_processor.dart';
import 'package:contract/widget/home_page_app_bar/home_page_app_bar.dart';
import 'package:contract/widget_functional/skeleton_safe/skeleton_safe.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ClassStatPage extends StatefulWidget {
  const ClassStatPage({super.key});

  @override
  State<ClassStatPage> createState() => _ClassStatPageState();
}

class _ClassStatPageState extends State<ClassStatPage> {
  List<UserData>? classmatesDataSorted;
  ClassData? classData;

  @override
  void initState() {
    super.initState();
    Global.userData.addListener(this, () {
      updateData();
    });
    updateData();
  }

  void updateData() {
    Global.serverManager.getBelongClasses(Global.userData.id).then((List<ClassData> cd) {
      if (!mounted) return;
      setState(() {
        classData = cd[0]; // todo classes
      });
    });

    getClassmatesSortedBySteps().then((List<UserData> cmd) {
      if (!mounted) return;
      setState(() {
        classmatesDataSorted = cmd;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ClassStatRankRow> classStatRankRows = [];

    if (classmatesDataSorted != null) {
      for (int i = 0; i < classmatesDataSorted!.length; i++) {
        classStatRankRows.add(ClassStatRankRow(user: classmatesDataSorted![i], rank: i,));
      }
    }

    return MaterialApp(
      home: Scaffold(
        appBar: HomePageAppBar(), // todo jeery 앱바수정
        body: Container(
          color: Colors.grey[200],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                decoration: BoxDecoration(
                  color: Color(0xff53a96a),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: SkeletonSafe(
                  inspectList: [classData],
                  onDisabled: updateData,
                  child: Text(
                      "${classData?.name}",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
              ),
              SkeletonSafe(
                inspectList: [classmatesDataSorted],
                onDisabled: updateData,
                pseudoLayout: Column(
                  children: [ // lol
                    ClassStatRankRow(user: Global.userData, rank: 1),
                    ClassStatRankRow(user: Global.userData, rank: 1),
                    ClassStatRankRow(user: Global.userData, rank: 1),
                    ClassStatRankRow(user: Global.userData, rank: 1),
                    ClassStatRankRow(user: Global.userData, rank: 1),
                    ClassStatRankRow(user: Global.userData, rank: 1),
                    ClassStatRankRow(user: Global.userData, rank: 1),
                    ClassStatRankRow(user: Global.userData, rank: 1),
                  ],
                ),
                child: SkeletonSafe(
                  inspectList: [classmatesDataSorted],
                  onDisabled: updateData,
                  child: Column(
                    children: classStatRankRows,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ClassStatRankRow extends StatefulWidget {
  final UserData user;
  final int rank;

  const ClassStatRankRow({super.key, required this.user, required this.rank});

  @override
  State<ClassStatRankRow> createState() => _ClassStatRankRowState();
}

class _ClassStatRankRowState extends State<ClassStatRankRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(fontSize: 16),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Center(
                  child: Text("${widget.rank}등",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Center(
                child: Text(widget.user.id.toString(),
                  style: TextStyle(
                      fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600
                  ),
                )
              ),
            ),
            Flexible(
              flex: 2,
              child: Center(
                child: Text("${(widget.user.steps / Config.stepRequiredPerTree * 100).round()}%",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ),
            ),
            Center(
              child: LinearPercentIndicator(
                width: 170,
                lineHeight: 10,
                backgroundColor: Colors.grey.shade400,
                progressColor: Color(0xff53a96a),
                percent: widget.user.steps / Config.stepRequiredPerTree < 1
                    ? widget.user.steps / Config.stepRequiredPerTree
                    : 1.0,
                barRadius: Radius.circular(10),
              )
            ),
            Flexible(
              flex: 3,
              child: Center(
                child: Text("${widget.user.steps}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
// todo 반친구 정보 갱신, 페이지 넘어오면 리로드(리더보드