import 'package:flutter/cupertino.dart';

class Tree extends StatefulWidget {
  const Tree({super.key});

  @override
  State<Tree> createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  @override
  Widget build(BuildContext context) {  // todo jeery 그림추가
    return Flexible(
      flex: 5,
      child: Center(
        child: Text(''),
      ),
    );
  }
}
