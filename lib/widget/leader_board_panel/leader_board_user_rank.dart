import 'package:contract/core/data_storage.dart';
import 'package:contract/core/global.dart';
import 'package:contract/structure/util/nullObjSafe.dart';
import 'package:contract/widget_functional/skeleton_safe/skeleton_safe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LeaderBoardUserRank extends StatefulWidget {
  const LeaderBoardUserRank({super.key});

  @override
  State<LeaderBoardUserRank> createState() => _LeaderBoardUserRankState();
}

class _LeaderBoardUserRankState extends State<LeaderBoardUserRank> {
  final _smallGrayStyle = TextStyle(
      fontSize: 16,
      color: Colors.grey.shade600,
    );
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final int ranking = (nullObjSafe(Global.ds.classmatesDataSortedBySteps)
        .indexWhere((user) => user.id == Global.ds.userData.id) + 1);

    return SkeletonSafe(
      inspectList: [context.watch<DataStorage>().classmatesDataSortedBySteps],
      onDisabled: Global.ds.tryUpdateClassmatesDataSortedBySteps,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "걸음 순위표",
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
                  "당신의 반에서",
                  style: _smallGrayStyle,
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
                      "당신은 ",
                      style: _smallGrayStyle,
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
                      "등 입니다",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    )
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

// String getOrderPostfix(int ranking) {
//   if (ranking <= 3) return ["?", "st", "nd", "rd"][ranking];
//   return "th";
// }