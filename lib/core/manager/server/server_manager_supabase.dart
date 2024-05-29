import 'dart:math';

import 'package:contract/core/manager/server/interface_server_manager.dart';
import 'package:contract/structure/class/class_data.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

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

    final data = await getUserDataRaw(userId);

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

  @override
  Future<DateTime> getClassLatestSumWhen(Uuid id) async {
    final data = await getClassDataRaw(id);
    return data['latest_sum_when'];
  }

  @override
  Future<List<UserData>> getUserDatasOfClass(Uuid id) async {
    final cd = await getClassDataRaw(id);
    List<UserData> res = [];

    for (final id in cd['users_id']) {
      res.add(await retrieveUserData(id));
    }

    return res;
  }

  @override
  Future<ClassData> retrieveClassData(Uuid id) async {
    print('--------------------------------');
    final cd = await getClassDataRaw(id);
    ClassData res = ClassData();

    res.id = id;
    res.name = cd['name'];

    return res;
  }

  @override
  Future<List<ClassData>> getBelongClasses(int userId) async {
    final data = await getUserDataRaw(userId);
    final belongClasses = data['belong_classes_id'];
    final List<ClassData> res = [];

    if (belongClasses == null) return res;

    for (var id in belongClasses) {
      var a = await retrieveClassData(id); // todo this s**t not works lol
      res.add(a);
    }
    print(res);
    print("-----------res---------");
    return res;
  }

  @override
  Future<int> getLatestClassTotalSteps(Uuid id) async {
    final data = await getClassDataRaw(id);
    return data['latest_sum_of_steps'];
  }

  @override
  Future<void> updateClassLatestTotalSteps(Uuid id, int totalSteps) async {
    await _supabase
      .from('class')
      .update({
        'latest_sum_of_steps': totalSteps,
        'latest_sum_when': DateTime.now()
      })
      .eq('id', id);
  }

  @override
  Future<Map<String, dynamic>> getClassDataRaw(Uuid id) async {
    final data = await _supabase
        .from('class')
        .select()
        .eq('id', id)
        .single();

    return data;
  }

  @override
  Future<Map<String, dynamic>> getUserDataRaw(int userId) async {
    final data = await _supabase
        .from('user_data')
        .select()
        .eq('id', userId)
        .single();

    return data;
  }
}