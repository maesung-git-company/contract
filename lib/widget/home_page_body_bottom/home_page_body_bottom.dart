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
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                    width: double.infinity,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Leader Board",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "in your class",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600
                        ),
                      ),
                    )
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "you are on",
                            style: TextStyle(
                              fontSize: 16,
                                color: Colors.grey.shade600
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                              "{0}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "th",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                            "1st",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "242511",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(25, 10, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "2nd",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "242511",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(25, 10, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "3rd",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "242511",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

