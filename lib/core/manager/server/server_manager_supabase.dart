import 'dart:math';

import 'package:contract/core/manager/server/interface_server_manager.dart';
import 'package:contract/structure/class/class_data.dart';
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
  Future<Map<String, dynamic>> getUserDataRaw(int userId) async {
    final data = await _supabase
        .from('user_data')
        .select()
        .eq('id', userId)
        .single();

    return data;
  }

  @override
  Future<UserData> retrieveUserData(int userId) async {
    UserData userData = UserData();

    final data = await getUserDataRaw(userId);

    userData.id = userId;
    userData.steps = data["steps"];
    userData.secondsActive = data["seconds_active"];
    userData.belongClassesUuid
      = List<String>.from(data['belong_classes_uuid'] as List);

    return userData;
  }

  @override
  Future<List<ClassData>> getBelongClasses(int userId) async {
    final data = await retrieveUserData(userId);
    final belongClassesUuid = data.belongClassesUuid;

    final List<ClassData> res = [];

    for (final uuid in belongClassesUuid) {
      final cd = await retrieveClassData(uuid);
      res.add(cd);
    }

    return res;
  }

  @override
  updateUserData() async {
    final oldUserData = await retrieveUserData(Global.userData.id);

    UserData ud = Global.userData;

    ud.steps = max(ud.steps, oldUserData.steps);
    ud.secondsActive = max(ud.secondsActive, oldUserData.secondsActive);

    await _supabase
        .from('user_data')
        .update({
          'steps': ud.steps,
          'seconds_active': ud.secondsActive
        })
        .eq('id', ud.id);
  }

  @override
  Future<Map<String, dynamic>> getClassDataRaw(String uuid) async {
    final data = await _supabase
        .from('class')
        .select()
        .eq('id', uuid)
        .single();

    return data;
  }

  @override
  Future<ClassData> retrieveClassData(String uuid) async {
    final cd = await getClassDataRaw(uuid);
    ClassData res = ClassData();

    res.uuid = uuid;
    res.name = cd['name'];

    return res;
  }

  @override
  Future<List<UserData>> getUserDatasOfClass(String uuid) async {
    final cd = await getClassDataRaw(uuid);
    List<UserData> res = [];

    for (final id in cd['users_id']) {
      res.add(await retrieveUserData(id));
    }

    return res;
  }

  @override
  Future<DateTime> getClassLatestSumWhen(String uuid) async {
    final data = await getClassDataRaw(uuid);
    return DateTime.parse(data['latest_sum_when']);
  }

  @override
  Future<int> getLatestClassTotalSteps(String uuid) async {
    final data = await getClassDataRaw(uuid);
    return data['latest_sum_of_steps'];
  }

  @override
  Future<void> updateClassLatestTotalSteps(String uuid, int totalSteps) async {
    await _supabase
      .from('class')
      .update({
        'latest_sum_of_steps': totalSteps,
        'latest_sum_when': DateTime.now().toString()
      })
      .eq('id', uuid);
  }
}