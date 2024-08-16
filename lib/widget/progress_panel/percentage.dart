import 'package:contract/core/global.dart';
import 'package:flutter/cupertino.dart';

class Percentage extends StatefulWidget {
  const Percentage({super.key});

  @override
  State<Percentage> createState() => _PercentageState();
}

class _PercentageState extends State<Percentage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(50, 0, 40, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 60,
          height: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffbae5c6)
          ),
          child: Center(
            child: Container(
              margin: EdgeInsets.all(1),
              child: Text('${(Global.userData.steps / 10000 * 100).round()}%',
                style: TextStyle(
                  color: Color(0xff53a96a),
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
