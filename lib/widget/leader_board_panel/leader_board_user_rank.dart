import 'package:contract/core/data_storage.dart';
import 'package:contract/structure/util/nullObjSafe.dart';
import 'package:contract/widget_functional/skeleton_safe/skeleton_safe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LeaderBoardUserRank extends StatefulWidget {
  const LeaderBoardUserRank({super.key});

  @override
  State<LeaderBoardUserRank> createState() => _LeaderBoardUserRankState();
}

class _LeaderBoardUserRankState extends State<LeaderBoardUserRank> {
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final int ranking = (nullObjSafe(DataStorage.classmatesDataSortedBySteps)
        .indexWhere((user) => user.id == DataStorage.userData.id) + 1);

    return SkeletonSafe(
      inspectList: [DataStorage.classmatesDataSortedBySteps],
      onDisabled: DataStorage.tryUpdateClassmatesDataSortedBySteps,
      reloadAfterMillisecond: 1000,
      reloadCallback: () { setState(() {}); },
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 0, 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "in your class",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
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
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(ranking.toString(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      getOrderPostfix(ranking),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getOrderPostfix(int ranking) {
  if (ranking <= 3) return ["st", "nd", "rd"][ranking];
  return "th";
}