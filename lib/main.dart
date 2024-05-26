import 'package:contract/page/home/home_page.dart';
import 'package:contract/page/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import 'core/global.dart';
import 'core/manager/server/interface_server_manager.dart';
import 'core/manager/server/server_manager_supabase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await overallInit();

  debug(); // todo remove debug
  // todo make accounts

  int? userId = Global.prefs.getInt('user_id');
  if (userId != null) {
    Global.userData = await Global.serverManager.retrieveUserData(userId);
  }

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

    page = Global.userData != null ? HomePage() : LoginPage();
    // if (Global.userData.id == null) {
    //   page = LoginPage();
    // }
    // else {
    //   page = HomePage();
    // }

    return MaterialApp(
      home: page
    );
  }
}


