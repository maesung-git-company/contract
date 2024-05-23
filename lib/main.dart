import 'package:contract/page/home/home_page.dart';
import 'package:contract/page/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env');

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_KEY'),
  );

  final prefs = await SharedPreferences.getInstance();
  prefs.remove("login_id");  // todo remove

  int? loginId = prefs.getInt('login_id');
  Global.userData.id = loginId;

  runApp(Contract());
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

    page = Global.userData.id != null ? HomePage() : LoginPage();
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


