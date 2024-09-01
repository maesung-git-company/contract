// ignore: unused_import
import 'package:contract/core/data_storage.dart';
import 'package:contract/core/global.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:contract/widget_functional/skeleton_safe/skeleton_safe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      RankRow(head: "1st", id: extractIdSafely(Global.ds.classmatesDataSortedBySteps, 0)),
      RankRow(head: "2nd", id: extractIdSafely(Global.ds.classmatesDataSortedBySteps, 1)),
      RankRow(head: "3rd", id: extractIdSafely(Global.ds.classmatesDataSortedBySteps, 2))
    ];

    return SkeletonSafe(
      inspectList: [context.watch<DataStorage>().classmatesDataSortedBySteps],
      onDisabled: Global.ds.tryUpdateClassmatesDataSortedBySteps,
      child: SizedBox(
        height: 190,
        child: Column(
          children: rankRows,
        ),
      )
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
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
