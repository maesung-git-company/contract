import 'package:flutter/material.dart';

class HomePageBodyTorso extends StatefulWidget {
  const HomePageBodyTorso({super.key});

  @override
  State<HomePageBodyTorso> createState() => _HomePageBodyTorsoState();
}

class _HomePageBodyTorsoState extends State<HomePageBodyTorso> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 25, 20, 25),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "15:57",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Workouts this day",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

