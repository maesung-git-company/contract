import 'dart:ui';

import 'package:contract/page/class_list/class_list_page.dart';
import 'package:flutter/material.dart';

import '../../core/global.dart';
import '../../structure/class/user_data.dart';


// Color Codes 
// #2E3532
// #7E9181
// #A0AAB2



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void sendClassListPageNav() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClassListPage()),
    );
  }

  Future<List<UserData>> getClassStatsSorted() async {
    final sm = Global.serverManager;
    final cls = await sm.getBelongClasses(Global.userData!.id);
    List<UserData> res = await sm.getUserDatasOfClass(cls[0].uuid);  // todo 다른 클래스 선택기능
    res.sort((a, b) => b.steps.compareTo(a.steps));

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_outlined)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
          title: const Text('Step Counter'),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Flexible(
                flex: 3, 
                child: SizedBox(
                  child: Center(
                    child: StepIndicator(),
                ),
              )),
              Flexible(
                flex: 7, 
                child: SizedBox(
                  child: const Center(
                    child: ClassIndicator(),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}


class StepIndicator extends StatefulWidget {
  const StepIndicator({super.key});

  @override
  State<StepIndicator> createState() => _StepIndicatorState();
}

class _StepIndicatorState extends State<StepIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(25, 0, 25, 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Current Steps', 
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: Colors.black),
          ),
          Text('1557',
            style: TextStyle(fontSize: 64, fontWeight: FontWeight.w700, foreground: Paint()..shader = linearGradient),
          )
        ]
      ),
    );
  }
}

/*--------------------------------------------------------------------*/

class ClassIndicator extends StatefulWidget {
  const ClassIndicator({super.key});

  @override
  State<ClassIndicator> createState() => _ClassIndicatorState();
}

class _ClassIndicatorState extends State<ClassIndicator> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        margin: EdgeInsets.all(25),
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 2,
                  color: Colors.grey.withOpacity(0.80)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.85),
                    Colors.white.withOpacity(0.75),
                  ]
                ),  
              ),
            ),
            Center(
              child: _buildList(),
            )
          ],
        ),
      )
    );
  }
}

ListTile _title(String title, String subtitle) => ListTile(
  title: Text(title, style: TextStyle(color: Colors.black, fontSize: 24),),
  subtitle: Text(subtitle, style: TextStyle(color: Colors.black, fontSize: 16),),
); 

Widget _buildList() => ListView(
  children: [
    ClassListPage(),
    ClassListPage(),
    ClassListPage(),
  ],
); 

final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0xff6FDA44), Color(0xff27B166)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200, 70.0));