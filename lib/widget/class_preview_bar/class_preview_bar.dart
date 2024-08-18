import 'package:contract/page/class_stat_page/class_stat_page.dart';
import 'package:flutter/material.dart';


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
  Widget build(BuildContext context) {
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
