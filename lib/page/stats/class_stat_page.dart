import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../structure/class/class_data.dart';
import '../../widget/class_preview_bar.dart';
import 'package:contract/core/global.dart';

class ClassStatPage extends StatefulWidget {
  const ClassStatPage({super.key});

  @override
  State<ClassStatPage> createState() => _ClassStatPageState();
}

class _ClassStatPageState extends State<ClassStatPage> {
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
        //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
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
