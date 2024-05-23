import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../structure/class/activity_data.dart';
import '../../widget/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {  // todo login, init global
    return const MaterialApp(
      title: 'TitleMain',
      home: Scaffold(
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeContent()
                ],
              )
          )
      )
    );
  }
}