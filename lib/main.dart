
import 'package:contract/core/manager/s_pref_manager.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:contract/widget/main_app/main_app.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/global.dart';
import 'core/manager/server/interface_server_manager.dart';
import 'core/manager/server/server_manager_supabase.dart';
import 'page/login_page/login_page.dart';

bool userLoggedIn = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  grantPermission();
  await overallInit();
  await attemptLogin();

  runApp(MaesungGreenWalking());
}

Future<void> overallInit() async {
  Global.serverManager = ServerManagerSupabase() as ServerManagerI;
  await Global.serverManager.connectDB();
}

Future<void> grantPermission() async {
  await Permission.activityRecognition.request();
}

class MaesungGreenWalking extends StatefulWidget {
  const MaesungGreenWalking({super.key});

  @override
  State<MaesungGreenWalking> createState() => _MaesungGreenWalkingState();
}

Future<void> attemptLogin() async {
  final UserData? savedUserData = await SPrefManager.getSavedUserData();
  if (savedUserData == null) return;
  userLoggedIn = true;

  Global.ds.userData = savedUserData;
  await Global.ds.tryUpdateUserData();
}

class _MaesungGreenWalkingState extends State<MaesungGreenWalking> {
  @override
  Widget build(BuildContext context) {
    late Widget page;

    page = (userLoggedIn)
        ? MainApp()
        : LoginPage();

    return MaterialApp(
      home: page
    );
  }
}


