import 'package:contract/core/data_storage.dart';
import 'package:contract/core/global.dart';
import 'package:contract/structure/class/class_data.dart';
import 'package:contract/structure/util/nullObjSafe.dart';
import 'package:contract/widget/home_page_app_bar/home_page_app_bar.dart';
import 'package:contract/widget_functional/skeleton_safe/skeleton_safe.dart';
  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchoolStatPage extends StatefulWidget {
  const SchoolStatPage({super.key});

  @override
  State<SchoolStatPage> createState() => _SchoolStatPageState();
}

class _SchoolStatPageState extends State<SchoolStatPage> {
  @override
  Widget build(BuildContext context) {
    final List<SchoolStatRankRow> schoolStatRankRows = [];
    final classDatas = Global.ds.wholeClassesSortedBySteps;

    if (classDatas != null) {
      for (int i = 0; i < classDatas.length; i++) {
        schoolStatRankRows.add(
            SchoolStatRankRow(classData: classDatas[i], rank: i + 1)
        );
      }
    }

    return MaterialApp(
      home: Scaffold(
        appBar: HomePageAppBar(),
        body: Container(
          color: Colors.grey[400],
          child: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 30,
              ),
              SkeletonSafe(
                inspectList: [context.watch<DataStorage>().wholeClassesSortedBySteps],
                onDisabled: Global.ds.tryUpdateWholeClassesSortedBySteps,
                retryAfterS: 1,
                pseudoLayout: Column(
                  children: [
                    SchoolStatRankRow(classData: nullObjSafe(Global.ds.classData), rank: 1,),
                    SchoolStatRankRow(classData: nullObjSafe(Global.ds.classData), rank: 2,),
                    SchoolStatRankRow(classData: nullObjSafe(Global.ds.classData), rank: 3,),
                    SchoolStatRankRow(classData: nullObjSafe(Global.ds.classData), rank: 4,),
                    SchoolStatRankRow(classData: nullObjSafe(Global.ds.classData), rank: 4,),
                    SchoolStatRankRow(classData: nullObjSafe(Global.ds.classData), rank: 4,),
                  ],
                ),
                child: Column(
                  children: schoolStatRankRows
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 30,
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class SchoolStatRankRow extends StatefulWidget {
  final ClassData classData;
  final int rank;

  const SchoolStatRankRow({
    super.key,
    required this.classData,
    required this.rank
  });

  @override
  State<SchoolStatRankRow> createState() => _SchoolStatRankRowState();
}

class _SchoolStatRankRowState extends State<SchoolStatRankRow> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = widget.rank <= 3
      ? [Colors.yellowAccent, Colors.white60, Colors.brown][widget.rank - 1]
      : Colors.white;
    double blurRad = widget.rank <= 3 ? (4 - widget.rank) * 3 + 5 : 3;

    return ListTile(
      title: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: widget.rank <= 3 ? backgroundColor : Colors.white60,
              blurRadius: blurRad,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              Flexible( // todo prettify
                flex: 2,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Center(
                    child: Text(
                      "${widget.rank}등",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Center(
                    child: Text(
                      widget.classData.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Center(
                    child: Text(
                      "총 ${widget.classData.latestSumOfSteps}걸음",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal
                      ),
                    )
                  ),
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}

// class SchoolRankBox extends StatelessWidget {
//   final int rank;
//   final Color color;
//   final double size;
//   final String title;
//   final int score;
//
//   const SchoolRankBox({
//     super.key,
//     required this.rank,
//     required this.color,
//     this.size = 60,
//     required this.title,
//     required this.score,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         Container(
//           width: size + 40,
//           height: size + 30,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.black, width: 2),
//           ),
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 '$rank',
//                 style: TextStyle(fontSize: 24, color: Colors.white),
//               ),
//               Text(
//                 'Score: $score',
//                 style: TextStyle(fontSize: 12, color: Colors.white70),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
