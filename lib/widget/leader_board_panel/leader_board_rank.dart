import 'package:contract/core/global.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:contract/structure/util/data_processor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderBoardRank extends StatefulWidget {
  const LeaderBoardRank({super.key});

  @override
  State<LeaderBoardRank> createState() => _LeaderBoardRankState();
}

class _LeaderBoardRankState extends State<LeaderBoardRank> {
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
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          SizedBox(
            height: 25,
            width: double.infinity,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Leader Board",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "in your class",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600
                  ),
                ),
              )
          ),
          SizedBox(
            width: double.infinity,
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      "you are on",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${classmatesDataSorted != null
                          ? classmatesDataSorted!.indexWhere((user) => user.id == Global.userData.id) + 1
                          : "-"}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "th",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600
                      ),
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}
