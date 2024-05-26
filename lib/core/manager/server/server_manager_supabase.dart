import 'dart:math';

import 'package:contract/core/manager/server/interface_server_manager.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../global.dart';

class ServerManagerSupabase implements ServerManagerI {
  static late final _supabase;

  @override
  Future<void> initDB() async {
    await dotenv.load(fileName: 'assets/config/.env');
    
    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_KEY'),
    );

    _supabase = Supabase.instance.client;
  }

  @override
  Future<UserData> retrieveUserData(int userId) async {
    UserData userData = UserData();

    final data = await _supabase
        .from('user_data')
        .select()
        .eq('id', userId)
        .single();

    userData.id = userId;
    userData.steps = data["steps"];
    userData.minutesActive = data["minutes_active"];

    return userData;
  }

  @override
  updateUserData() async {
    final oldUserData = await retrieveUserData(Global.userData!.id);

    UserData ud = Global.userData!;

    ud.steps = max(ud.steps, oldUserData.steps);
    ud.minutesActive = max(ud.minutesActive, oldUserData.minutesActive);

    await _supabase
        .from('user_data')
        .update({
          'steps': ud.steps,
          'minutes_active': ud.minutesActive
        })
        .eq('id', ud.id);
  }
}