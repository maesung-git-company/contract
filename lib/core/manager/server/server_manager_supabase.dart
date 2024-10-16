
import 'dart:math';

// ignore: unused_import
import 'package:contract/core/data_storage.dart';
import 'package:contract/core/manager/server/interface_server_manager.dart';
import 'package:contract/structure/class/class_data.dart';
import 'package:contract/structure/class/school_data.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ServerManagerSupabase implements ServerManagerI {
  static var supabase;

  @override
  Future<void> connectDB() async {
    await dotenv.load(fileName: 'assets/config/.env');
    
    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_KEY'),
    );

    supabase = Supabase.instance.client;
  }

  @override
  Future<Map<String, dynamic>> getUserDataRaw(int userId) async {
    final rawData = await supabase
        .from('user')
        .select()
        .eq('id', userId)
        .single();

    return rawData;
  }

  @override
  Future<UserData> retrieveUserData(int userId) async {
    final rawData = await getUserDataRaw(userId);

    UserData userData = UserData(
      id: userId,
      steps: rawData['steps'],
      secondsActive: rawData['seconds_active'],
      belongClassId: rawData['belong_class_id']
    );

    return userData;
  }

  @override
  uploadUserData(UserData userData) async {
    final serverUserData = await retrieveUserData(userData.id);

    await supabase
        .from('user')
        .update({
          'steps': max(userData.steps, serverUserData.steps),
          'seconds_active': max(userData.secondsActive, serverUserData.secondsActive)
        })
        .eq('id', userData.id);
  }

  @override
  Future<Map<String, dynamic>> getClassDataRaw(String uuid) async {
    final rawData = await supabase
        .from('class')
        .select()
        .eq('uuid', uuid)
        .single();

    return rawData;
  }

  @override
  Future<ClassData> retrieveClassData(String uuid) async {
    final rawData = await getClassDataRaw(uuid);

    ClassData res = ClassData(
      uuid: uuid,
      name: rawData['name'],
      usersId: List<int>.from(rawData['users_id'] as List),
      latestSumOfSteps: rawData['latest_sum_of_steps'],
      latestSumWhen: DateTime.parse(rawData['latest_sum_when']),
      belongSchoolUuid: rawData['belong_school_uuid']
    );

    return res;
  }

  @override
  Future<List<UserData>> getUserDatasOfClass(ClassData classData) async {
    List<UserData> res = [];

    for (final int id in classData.usersId) {
      res.add(await retrieveUserData(id));
    }

    return res;
  }

  @override
  Future<void> uploadClassData(ClassData classData) async {
    final serverClassData = await retrieveClassData(classData.uuid);

    await supabase
      .from('class')
      .update({
        'latest_sum_of_steps': max(classData.latestSumOfSteps, serverClassData.latestSumOfSteps),
        'latest_sum_when': classData.latestSumWhen.isAfter(serverClassData.latestSumWhen)
          ? classData.latestSumWhen.toIso8601String()
          : serverClassData.latestSumWhen.toIso8601String()
      })
      .eq('uuid', classData.uuid);
  }

  @override
  Future<Map<String, dynamic>> getSchoolDataRaw(String uuid) async {
    final data = await supabase
        .from('school')
        .select()
        .eq('uuid', uuid)
        .single();

    return data;
  }

  @override
  Future<SchoolData> retrieveSchoolData(String uuid) async {
    final rawData = await getSchoolDataRaw(uuid);

    SchoolData schoolData = SchoolData(
        uuid: rawData['uuid'],
        name: rawData['name'],
        classesUuid: List<String>.from(rawData['classes_uuid'] as List),
        latestSumOfSteps: rawData['latest_sum_of_steps'],
        latestSumWhen: DateTime.parse(rawData['latest_sum_when'])
    );

    return schoolData;
  }

  @override
  Future<List<ClassData>> getClassDatasOfSchool(SchoolData schoolData) async {
    List<ClassData> res = [];

    for (final String uuid in schoolData.classesUuid) {
      res.add(await retrieveClassData(uuid));
    }

    return res;
  }

  @override
  Future<void> uploadSchoolData(SchoolData schoolData) async {
    final serverSchoolData = await retrieveSchoolData(schoolData.uuid);

    await supabase
      .from('class')
      .update({
        'latest_sum_of_steps': max(schoolData.latestSumOfSteps, serverSchoolData.latestSumOfSteps),
        'latest_sum_when': schoolData.latestSumWhen.isAfter(serverSchoolData.latestSumWhen)
          ? schoolData.latestSumWhen.toIso8601String()
          : serverSchoolData.latestSumWhen.toIso8601String()
      })
      .eq('id', schoolData.uuid);
  }
}