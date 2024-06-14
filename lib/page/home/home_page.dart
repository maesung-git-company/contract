import 'package:contract/page/class_list/class_list_page.dart';
import 'package:flutter/material.dart';

import '../../core/global.dart';
import '../../structure/class/user_data.dart';

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
        body: SizedBox(
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
      margin: EdgeInsets.fromLTRB(25, 25, 25, 25),
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Current Steps', 
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          gradientText(),
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
    return Container(
      child: const Text('Class Indicator'),
    );
  }
}

Widget gradientText() {
   final Shader linearGradientShader = LinearGradient(colors: [Color(0xfff7b500), Color(0xff6dd400)]).createShader(Rect.fromCenter(center: Offset(0.1, 0.5), width: 50, height: 50));
   return Text('1557', style: TextStyle(foreground: Paint()..shader = linearGradientShader, fontSize: 54));
}