import 'package:contract/widget/home_page_app_bar/home_page_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SchoolStatPage extends StatefulWidget { // todo
  const SchoolStatPage({super.key});

  @override
  State<SchoolStatPage> createState() => _SchoolStatPageState();
}

class _SchoolStatPageState extends State<SchoolStatPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: HomePageAppBar(),
        body: Container(
          color: Colors.grey[200],
          child: ListView(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  color: Colors.red,
                )
              ),
              Flexible(
                flex: 5,
                child: Container(

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
