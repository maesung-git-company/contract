import 'package:contract/page/home/home_page.dart';
import 'package:contract/page/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/global.dart';
import 'core/manager/server/interface_server_manager.dart';
import 'core/manager/server/server_manager_supabase.dart';

/* todo list:
  - class preview bar onclick, curr
  - school db
  - background work ?
  - wifi
  - sum : 90% done
  - anti cheat ?
  - import by package ?
  - add group adder python files to project
  - visual : first to work - on jeery
 */

/* todo list for jeery:
  - A1
  - A2
  - A3
  - A4
  - A5
  - A6
 */

bool userLoggedIn = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await overallInit();
  grantPermission();

  //debug();

  runApp(Contract());
}

Future<void> debug() async {
  Global.prefs.remove("user_id");
}

Future<void> overallInit() async {
  // global
  Global.serverManager = ServerManagerSupabase() as ServerManagerI;
  Global.prefs = await SharedPreferences.getInstance();

  await Global.serverManager.initDB();

  int? userId = Global.prefs.getInt('user_id');
  if (userId != null) {
    Global.userData = await Global.serverManager.retrieveUserData(userId);
    print(Global.userData);
    userLoggedIn = true;
  }
}

Future<void> grantPermission() async {
  await Permission.activityRecognition.request();
}

class Contract extends StatefulWidget {
  const Contract({super.key});

  @override
  State<Contract> createState() => _ContractState();
}

class _ContractState extends State<Contract> {
  @override
  Widget build(BuildContext context) {
    late Widget page;


    page = userLoggedIn ? HomePage() : LoginPage();

    return MaterialApp(
      home: page
    );
  }
}


