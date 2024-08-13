import 'package:flutter/material.dart';

class HomePageBodyBottom extends StatefulWidget {
  const HomePageBodyBottom({super.key});

  @override
  State<HomePageBodyBottom> createState() => _HomePageBodyBottomState();
}

class _HomePageBodyBottomState extends State<HomePageBodyBottom> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 60,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            style: BorderStyle.solid, color: Colors.grey.shade500
          )
        )
      ),
    );
  }
}
