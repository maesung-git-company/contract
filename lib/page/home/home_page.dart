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
          color: Colors.grey.shade100,
          child: Column(
            children: [
              HomePageBodyHeader(),
              HomePageBodyTorso(),
              HomePageBodyBottom()
            ],
          ),
        ),
        drawer: ClassStatDrawer(),
        drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      ),
    );
  }
}

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
