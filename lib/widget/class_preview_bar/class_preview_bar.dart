import 'package:flutter/material.dart';

import 'package:contract/page/class_stat/class_stat_page.dart';

class ClassPreviewBar extends StatefulWidget {
  final String title;
  final int steps;

  ClassPreviewBar({super.key, required this.title, required this.steps});

  @override
  State<ClassPreviewBar> createState() => _ClassPreviewBarState();
}

class _ClassPreviewBarState extends State<ClassPreviewBar> {
  static const titleStyle = TextStyle(
    color: Colors.black,
    decoration: TextDecoration.none,
    fontSize: 40
  );

  void sendClassStatPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClassStatPage()),
    );
  }

  @override
  Widget build(BuildContext context) {  // todo A1 메인화면에서 학사모 누르면 뜨는 화면에서 자신이 소속된 반이 쭉 뜨게 해놓음. 그 각각 반의 bar인데 좀 꾸며주셈
    return GestureDetector(
      onTap: sendClassStatPage,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: Align(
              // alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: titleStyle,
                  ),
                  SizedBox(width: 19, height: double.infinity),
                  Text(widget.steps.toString())
                ],
              ),
            ),
          ),
          Divider(
            height: 10,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
