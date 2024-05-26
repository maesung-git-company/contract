import 'package:contract/widget/step_counter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TitleMain',
      home: Scaffold(
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StepCounter()
                ],
              )
          )
      )
    );
  }
}