import 'package:contract/core/global.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:contract/structure/util/data_processor.dart';
import 'package:flutter/material.dart';

class LeaderBoardRanking extends StatefulWidget {
  const LeaderBoardRanking({super.key});

  @override
  State<LeaderBoardRanking> createState() => _LeaderBoardRankingState();
}

class _LeaderBoardRankingState extends State<LeaderBoardRanking> {
  List<UserData>? classmatesDataSorted;

  @override
  void initState() {
    super.initState();
    Global.userData.addListener(() {
      updateClassmatesData();
    });
    updateClassmatesData();
  }

  void updateClassmatesData() {
    setState(() {
      getClassmatesSortedBySteps().then((List<UserData> cmd) {
        classmatesDataSorted = cmd;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<RankRow> rankRows = [
      RankRow(head: "1st", id: extractIdSafely(classmatesDataSorted, 0)),
      RankRow(head: "2nd", id: extractIdSafely(classmatesDataSorted, 1)),
      RankRow(head: "3rd", id: extractIdSafely(classmatesDataSorted, 2))
    ];

    return Flexible(
      flex: 1,
      child: Column(
        children: [
          SizedBox(  // todo jeery 이거 실행했을때 세로줄이 안맞는데 해결가능?
            width: double.infinity,
            height: 10,
          ),
          Column(
            children: rankRows,
          )
        ],
      ),
    );
  }
}

String extractIdSafely(List<UserData>? x, int idx) {
  return x != null ? x[idx].id.toString() : "-";
}

class RankRow extends StatelessWidget {
  final String head;
  final String id;

  const RankRow({super.key, required this.head, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
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
            width: 10,
          ),
          Text(
            id,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
