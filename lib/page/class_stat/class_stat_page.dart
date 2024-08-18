import 'package:contract/core/global.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:contract/structure/util/data_processor.dart';
import 'package:contract/widget/home_page_app_bar/home_page_app_bar.dart';
import 'package:contract/widget_functional/skeleton_safe/skeleton_safe.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ClassStatPage extends StatefulWidget {
  const ClassStatPage({super.key});

  @override
  State<ClassStatPage> createState() => _ClassStatPageState();
}

class _ClassStatPageState extends State<ClassStatPage> {
  List<UserData>? classmatesDataSorted;

  @override
  void initState() {
    super.initState();
    Global.userData.addListener(this, () {
      updateClassmatesData();
    });
    updateClassmatesData();
  }

  void updateClassmatesData() {
    getClassmatesSortedBySteps().then((List<UserData> cmd) {
      if (!mounted) return;
      setState(() {
        classmatesDataSorted = cmd;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DrawerRankRow> drawerRankRows = [];

    if (classmatesDataSorted != null) {
      for (UserData user in classmatesDataSorted!) {
        drawerRankRows.add(DrawerRankRow(name: user.id.toString()));
      }
    }

    return MaterialApp(
      home: Scaffold(
        appBar: HomePageAppBar(), // todo jeery 앱바수정
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader( // todo jeery 헤더 꾸며'줘'
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            SkeletonSafe(
              inspectList: [classmatesDataSorted],
              onDisabled: updateClassmatesData,
              pseudoLayout: Column(
                children: [ // lol
                  DrawerRankRow(name: "placeHolderplaceHolderplaceHolderplaceHolderplaceHolder"),
                  DrawerRankRow(name: "placeHolderplaceHolderplaceHolderplaceHolderplaceHolder"),
                  DrawerRankRow(name: "placeHolderplaceHolderplaceHolderplaceHolderplaceHolder"),
                  DrawerRankRow(name: "placeHolderplaceHolderplaceHolderplaceHolderplaceHolder"),
                  DrawerRankRow(name: "placeHolderplaceHolderplaceHolderplaceHolderplaceHolder"),
                  DrawerRankRow(name: "placeHolderplaceHolderplaceHolderplaceHolderplaceHolder"),
                  DrawerRankRow(name: "placeHolderplaceHolderplaceHolderplaceHolderplaceHolder"),
                  DrawerRankRow(name: "placeHolderplaceHolderplaceHolderplaceHolderplaceHolder"),
                  DrawerRankRow(name: "placeHolderplaceHolderplaceHolderplaceHolderplaceHolder")
                ],
              ),
              child: Column(
                children: drawerRankRows,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerRankRow extends StatefulWidget {
  final String name;

  const DrawerRankRow({super.key, required this.name});

  @override
  State<DrawerRankRow> createState() => _DrawerRankRowState();
}

class _DrawerRankRowState extends State<DrawerRankRow> {
  @override
  Widget build(BuildContext context) { // todo jeery 이거 옆에 걸음수 표시하는거 추가점
    return ListTile(
      title: Text(widget.name),
    );
  }
}
