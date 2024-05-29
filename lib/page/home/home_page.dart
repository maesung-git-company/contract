import 'package:contract/page/stats/class_stat_page.dart';
import 'package:contract/widget/step_counter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void sendClassNav() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClassStatPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TitleMain',
        home: Scaffold(
            body: Stack(
                children: [
                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StepCounter()
                        ],
                      )
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                        children: [
                          OutlinedButton(
                            onPressed: sendClassNav,
                            style: ButtonStyle(),
                            child: Icon(
                              Icons.school_sharp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox( width: 0, height: 200, ),
                        ]
                    ),
                  ),
                ]
            )
        )
    );
  }
}
