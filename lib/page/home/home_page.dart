import 'package:contract/page/class_list/class_list_page.dart';
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
      color: Colors.black.withOpacity(0.3),
      child: Column(
        children: [
          Text('Current Steps', 
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              )
            ),
          Text('{0}', 
            style: TextStyle(
             color: Colors.white,
             fontSize: 24,
           )
         ),
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