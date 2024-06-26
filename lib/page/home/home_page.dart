
import 'dart:async';

import 'package:contract/page/class_list/class_list_page.dart';
import 'package:flutter/material.dart';
import 'package:contract/widget/info_box.dart';
import '../../core/global.dart';
import '../../structure/class/user_data.dart';
import 'package:percent_indicator/percent_indicator.dart';


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
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu));
            }
          ),
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

        /*----------------------------------------------------------*/

        drawer: Drawer(
          backgroundColor: Colors.grey.shade200,
          child: ListView(
            padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
            children: [
              SizedBox(
                height: 64,
                child: DrawerHeader(
                  child: Text('DrawerHeader'),
                ),
              ),
              ListTile(
                title: Text('Leader board', style: TextStyle(color: Colors.black, fontSize: 16),),
                onTap: () {},
              ),
              ListTile(
                title: Text('Setting', style: TextStyle(color: Colors.black, fontSize: 16),),
                onTap: () {},
              ),
              ListTile(
                title: Text('About', style: TextStyle(color: Colors.black, fontSize: 16),),
                onTap: () {},
              )
            ]
          )
        ),

        /*----------------------------------------------------------*/
        
        body: Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              Flexible(
                flex: 35, 
                child: SizedBox(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 6, 
                        child: MainBox(
                          theWidth: double.infinity,
                          theHeight: double.infinity,
                          theChild: Center(
                            child: StepIndicator(),
                          )
                        )
                      ),
                      Flexible(
                        flex: 4,
                        child: MainBox(
                          theWidth: double.infinity,
                          theHeight: double.infinity,
                          theChild: Center(
                            child: StepProgress(),
                          )
                        )
                      )
                    ],
                  ),
                )
              ),
              Flexible(
                flex: 65, 
                child: MainBox(
                  theWidth: double.infinity,
                  theHeight: double.infinity,
                  theChild: Center(
                    child: Text('hello'),
                  ),
                )
              ),
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
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 20,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text('Current steps',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100
                )
              ),
            ),
          ),
          SizedBox(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '1557', // todo 내가 싸줄꼐
                style: TextStyle(
                  fontSize: 64,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}

/*--------------------------------------------------------------------*/

/*
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
*/

ListTile _title(String title, String subtitle) => ListTile(
  title: Text(title, style: TextStyle(color: Colors.black, fontSize: 24),),
  subtitle: Text(subtitle, style: TextStyle(color: Colors.black, fontSize: 16),),
); 

Widget _buildList() => ListView(
  children: [
      
  ],
); 

final Shader linearGradient = LinearGradient(
  colors: <Color>[Color.fromARGB(255, 68, 88, 218), Color.fromARGB(255, 103, 39, 177)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200, 70.0));

class theDrawer extends StatefulWidget {
  const theDrawer({super.key});

  @override
  State<theDrawer> createState() => _theDrawerState();
}

class _theDrawerState extends State<theDrawer> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class StepProgress extends StatefulWidget {
  const StepProgress({super.key});

  @override
  State<StepProgress> createState() => _StepProgressState();
}

class _StepProgressState extends State<StepProgress> {
  double _displayedProgress = 0.0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _displayedProgress = Global.userData!.steps.toDouble() / 10000;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CircularPercentIndicator(
        radius: 80.0,
        lineWidth: 15.0,
        percent: _displayedProgress,
        center: Text('hehe'),
      )
    );
  }
}