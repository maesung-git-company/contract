import 'package:contract/page/class_list/class_list_page.dart';
import 'package:contract/widget/step_counter.dart';
import 'package:flutter/material.dart';

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
          title: const Text('Step Counter'),
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                flex: 3, 
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: StepIndicator(),
                ),
              )),
              Flexible(
                flex: 7, 
                child: Container(
                  color: Colors.green,
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
      margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: Row(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text('Current Steps',
                 style: TextStyle(fontSize: 16,)),
                StepCounter()
              ],
            ),
          ),
        ],
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