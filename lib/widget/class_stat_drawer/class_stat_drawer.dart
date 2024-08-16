import 'package:contract/core/global.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:contract/structure/util/data_processor.dart';
import 'package:flutter/material.dart';

class ClassStatDrawer extends StatefulWidget {
  const ClassStatDrawer({super.key});

  @override
  State<ClassStatDrawer> createState() => _ClassStatDrawerState();
}

class _ClassStatDrawerState extends State<ClassStatDrawer> {
  List<UserData>? classmatesDataSorted;

  @override
  void initState() {
    super.initState();
    Global.userData.addListener(() {
      updateClassmatesData();
    });
    updateClassmatesData();
  }

  void updateClassmatesData() {
    if (!mounted) return;
    setState(() {
      getClassmatesSortedBySteps().then((List<UserData> cmd) {
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

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader( // todo jeery 헤더 꾸며'줘'
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          Column( // todo jeery 로딩 전 그거좀 추가해줘
            children: drawerRankRows,
          )
        ],
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
