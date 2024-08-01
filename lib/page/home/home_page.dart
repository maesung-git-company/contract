import 'dart:async';

import 'package:contract/page/class_list/class_list_page.dart';
import 'package:contract/widget/step_counter.dart';
import 'package:flutter/material.dart';
import 'package:contract/widget/info_box.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    List<UserData> res =
        await sm.getUserDatasOfClass(cls[0].uuid); // todo 다른 클래스 선택기능
    res.sort((a, b) => b.steps.compareTo(a.steps));

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new));
          }),
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

        /*----------------------------------------------------------*/

        body: Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              Flexible(
                  flex: 20,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, style: BorderStyle.solid, color: Colors.grey.shade500),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                            flex: 50,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(25, 25, 25, 5),
                                  height: 54,
                                  child: StepCounter(),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(35, 5, 35, 25),
                                  height: 30,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('/ 10000 steps',
                                     style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 22
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                        Flexible(
                          flex: 50,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(70, 55, 0, 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 50,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffbae5c6)
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('{0}%',
                                        style: TextStyle(
                                          color: Color(0xff53a96a),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(60, 5, 0, 20),
                                height: 20,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: StepProgress(),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              Flexible(
                flex: 20,
                child: Text('ad'),
                  ),
              Flexible(
                  flex: 60,
                  child: Text('ge')
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
      child: Column(children: [
        SizedBox(
          height: 20,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text('Current steps',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100)),
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
      ]),
    );
  }
}

/*--------------------------------------------------------------------*/

final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Color.fromARGB(255, 68, 88, 218),
    Color.fromARGB(255, 103, 39, 177)
  ],
).createShader(Rect.fromLTWH(0.0, 0.0, 200, 70.0));

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
    return LinearPercentIndicator(
      width: 150,
      lineHeight: 10,
      backgroundColor: Colors.grey.shade400,
      progressColor: Color(0xff53a96a),
      percent: _displayedProgress,
      barRadius: Radius.circular(10),
    );
  }
}
