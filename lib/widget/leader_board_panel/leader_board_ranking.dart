import 'package:contract/core/data_storage.dart';
// ignore: unused_import
import 'package:contract/core/global.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:contract/widget_functional/skeleton_safe/skeleton_safe.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LeaderBoardRanking extends StatefulWidget {
  const LeaderBoardRanking({super.key});

  @override
  State<LeaderBoardRanking> createState() => _LeaderBoardRankingState();
}

class _LeaderBoardRankingState extends State<LeaderBoardRanking> {
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final List<RankRow> rankRows = [
      RankRow(head: "1st", id: extractIdSafely(DataStorage.classmatesDataSortedBySteps, 0)),
      RankRow(head: "2nd", id: extractIdSafely(DataStorage.classmatesDataSortedBySteps, 1)),
      RankRow(head: "3rd", id: extractIdSafely(DataStorage.classmatesDataSortedBySteps, 2))
    ];

    return SkeletonSafe(
      inspectList: [DataStorage.classmatesDataSortedBySteps],
      onDisabled: DataStorage.tryUpdateClassmatesDataSortedBySteps,
      reloadAfterMillisecond: 1000,
      reloadCallback: () { setState(() {}); },
      child: Flexible(
        flex: 1,
        child: Column(
          children: [
            SizedBox(  // todo jeery 이거 실행했을때 세로줄이 안맞는데 해결가능? - 확인좀 -
              // todo - ㄴㄴ 아이디 숫자부분에서 세로로 줄 그었을때 맞는걸로 해줘
              width: double.infinity,
              height: 25,
            ),
            Column(
              children: rankRows,
            )
          ],
        ),
      ),
    );
  }
}

String extractIdSafely(List<UserData>? x, int idx) {
  return x != null ? x[idx].id.toString() : "000000";
}

class RankRow extends StatelessWidget {
  final String head;
  final String id;

  const RankRow({super.key, required this.head, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.fromLTRB(25, 0, 0, 25),
      child: Row(
        children: [
          Text(
            head,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
            child: Text(
              id,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
