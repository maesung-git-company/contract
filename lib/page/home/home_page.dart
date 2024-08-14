import 'dart:async';

import 'package:contract/core/global.dart';
import 'package:contract/page/class_list/class_list_page.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:contract/widget/class_stat_drawer/class_stat_drawer.dart';
import 'package:contract/widget/home_page_app_bar/home_page_app_bar.dart';
import 'package:contract/widget/home_page_body_bottom/home_page_body_bottom.dart';
import 'package:contract/widget/home_page_body_header/home_page_body_header.dart';
import 'package:contract/widget/home_page_body_torso/home_page_body_torso.dart';
import 'package:contract/widget_functional/swipeable/swipeable.dart';
import 'package:flutter/material.dart';


// Color Codes
// #2E3532
// #7E9181
// #A0AAB2

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void sendClassListPageNav() { // todo connect this to home page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClassListPage()),
    );
  }

  Future<List<UserData>> getClassStatsSorted() async {
    final sm = Global.serverManager;
    final cls = await sm.getBelongClasses(Global.userData.id);
    List<UserData> res =
    await sm.getUserDatasOfClass(cls[0].uuid); // todo 다른 클래스 선택기능
    res.sort((a, b) => b.steps.compareTo(a.steps));

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: HomePageAppBar(),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Flexible(
                flex: 5,
                child: Center(
                  child: Text('사진을 넣는 것에 관한 문제를 제기하는것이 기열찐빠황룡같지는 않은지를 감히 제가 알아도 되는지를 정확히 이야기해주십사 감찰해주실 수 있는지에 대한 승인을 요구하는 것에 대하여 의문이 존재함을 표현해도 되는지를 알렸을때 이상이 없는지 여쭤보는 것에 대한 허락을 구하는 것을 감히 제가 알게 되었다고 가정했을 때 해병대 내부에 이변이 생기지는 않는지에 대한 답을 요청하는 것을 표현해도 되는지를 시인해주실 수 있는지묻는것이 기열찐빠같은 요청에 해당하지 않는지에 대한 답을 요청하는 것에 대해 인지할 자격이 본 해병에게 있는지에 대한 설문을 하여도 괜찮은지를 시인해주실 수 있는지에 대해 본 해병이 감지해도 되는지를 말씀해주실 수 있는지의 여부에 대해 의문을 가져도 되는지에 대한 설문을 하여도 괜찮은지가 가능한지를 알기 위해 중첩의문문을 계속해도 되는지를 알려주시는 것이 괜찮은지의 여부를 지각(知覺)해도 되는지에 대한 답변을 감히 요구하는 것에 대하여 적절한지에 대해 거북하게 느끼시지는 않는지를 가르쳐주실 수 있는지를 받아들이실 수 있는지를 묻는 것을 감사(監査)해주실 수 있는지를 감히 제가 알게 되었다고 가정했을 때 해병대 내부에 이변이 생기지는 않는지를 바라도 되는지가 공정한지를 심의해주실 수 있는지에 대해 궁금증을 가져도 되겠습니까?'),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    children: [
                      HomePageBodyHeader(),
                      HomePageBodyTorso(),
                      HomePageBodyBottom(),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
        drawer: ClassStatDrawer(),
        drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      ),
    );
  }
}

// 그림
// 검은 상자








// class StepIndicator extends StatefulWidget {
//   const StepIndicator({super.key});
//
//   @override
//   State<StepIndicator> createState() => _StepIndicatorState();
// }
//
// class _StepIndicatorState extends State<StepIndicator> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       child: Column(children: [
//         SizedBox(
//           height: 20,
//           child: Align(
//             alignment: Alignment.bottomLeft,
//             child: Text('Current steps',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100)),
//           ),
//         ),
//         SizedBox(
//           child: Align(
//             alignment: Alignment.topLeft,
//             child: Text(
//               '1557',
//               style: TextStyle(
//                 fontSize: 64,
//                 foreground: Paint()..shader = linearGradient,
//               ),
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }
//
// /*--------------------------------------------------------------------*/
//
// final Shader linearGradient = LinearGradient(
//   colors: <Color>[
//     Color.fromARGB(255, 68, 88, 218),
//     Color.fromARGB(255, 103, 39, 177)
//   ],
// ).createShader(Rect.fromLTWH(0.0, 0.0, 200, 70.0));
//
