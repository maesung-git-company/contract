import 'package:flutter/material.dart';

class HomePageBodyTorso extends StatefulWidget {
  const HomePageBodyTorso({super.key});

  @override
  State<HomePageBodyTorso> createState() => _HomePageBodyTorsoState();
}

class _HomePageBodyTorsoState extends State<HomePageBodyTorso> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 20,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1,
              style: BorderStyle.solid, color: Colors.grey.shade500
          ),
        ),
      ),
    );
  }
}
