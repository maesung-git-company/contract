import 'package:contract/page/stats/class_stat_page.dart';
import 'package:contract/widget/step_counter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void sendClassNav() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClassStatPage()),
    );
  }

  @override
  Widget build(BuildContext context) { // todo A5 로그아웃 버튼 만들어주셈 ## Global.prefs.remove("user_id"); ## 호출하고 메인화면으로 돌아가든 하면 될듯
    return MaterialApp(
        title: 'TitleMain',
        home: Scaffold(
            body: Stack(
                children: [
                  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StepCounter() // todo A6 소나무 png 따서 초록색 차는거 그거 구현좀 ㅎ
                        ],
                      )
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                        children: [
                          OutlinedButton( // todo A2 학사모 모양 버튼인데 이거 클래스로 분리할 수 있으면 해주고 크기 키우거나 해서 잘보이게 해주셈
                            onPressed: sendClassNav,
                            style: ButtonStyle(),
                            child: Icon(
                              Icons.school_sharp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox( width: 0, height: 200, ),
                        ]
                    ),
                  ),
                ]
            )
        )
    );
  }
}
