import 'package:flutter/material.dart';

import '../../structure/class/class_data.dart';
import '../../widget/class_preview_bar.dart';
import 'package:contract/core/global.dart';

class ClassListPage extends StatefulWidget {
  const ClassListPage({super.key});

  @override
  State<ClassListPage> createState() => _ClassListPageState();
}

class _ClassListPageState extends State<ClassListPage> { // todo A4 학사모 누르면 뜨는 페이지인데 지금 너무하게 못생겼으니 부탁함, 홈페이지로 돌아가는 버튼도 추가 요망.

  Future<List<ClassPreviewBar>> getClasses() async {
    final sm = Global.serverManager;
    List<ClassPreviewBar> res = [];

    final List<ClassData> cds = await sm.getBelongClasses(Global.userData!.id);

    for (final classData in cds) {
      final tmp = ClassPreviewBar(
        title: classData.name,
        steps: await classData.getTotalStep(),
      );
      res.add(tmp);
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {

    // List<Widget> children = [
    //   SizedBox(
    //     width: 0,
    //     height: 100,
    //   )
    // ];
    //
    // children.addAll(_classList);

    return FutureBuilder(
      future: getClasses(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return CircularProgressIndicator();
        }
        else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(fontSize: 15),
            ),
          );
        }
        else {
          return MaterialApp(
              home: Container(
                color: Colors.white,
                child: Column(
                  children: snapshot.data,
                ),
              )
          );
        }
      }
    );
  }
}
