import 'dart:math';

import 'package:contract/structure/class/class_data.dart';
import 'package:contract/structure/class/school_data.dart';
import 'package:contract/structure/class/user_data.dart';

import 'global.dart';

class DataStorage {
  static late UserData userData;
  static ClassData? classData;
  static SchoolData? schoolData;

  static List<UserData>? classmatesDataSortedBySteps;
  // todo 업데이트 한지 지난 시간 타이머
  static Future<bool> tryUpdateUserData() async {
    try {
      final UserData updatedUserData = await Global.serverManager.retrieveUserData(userData.id);
      userData.steps = max(userData.steps, updatedUserData.steps);
      userData.secondsActive = max(userData.secondsActive, updatedUserData.secondsActive);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  static Future<bool> tryUpdateClassData({bool upload = false}) async {
    print("클래스업뎃!!!"); // todo remove
    try {
      final ClassData updatedClassData = await Global.serverManager.retrieveClassData(userData.belongClassId);

      DateTime now = DateTime.now();

      if (now.difference(updatedClassData.latestSumWhen).inMinutes > 5) {
        updatedClassData.latestSumOfSteps = await getTotalStepsOfClass(updatedClassData);
        updatedClassData.latestSumWhen = now;
        if (upload) tryUploadClassData();
      }

      if (classData == null) {
        classData = updatedClassData;
        return true;
      }

      classData!.latestSumOfSteps = max(classData!.latestSumOfSteps, updatedClassData.latestSumOfSteps);
      classData!.latestSumWhen = now.isAfter(updatedClassData.latestSumWhen) ? now : updatedClassData.latestSumWhen;

      return true;
    }
    catch (e) {
      return false;
    }
  }

  static Future<bool> tryUpdateClassmatesDataSortedBySteps() async {
    try {
      final sm = Global.serverManager;
      final ClassData classData = DataStorage.classData!;

      List<UserData> res =
      await sm.getUserDatasOfClass(classData);

      res.sort((a, b) => b.steps.compareTo(a.steps));

      return true;
    }
    catch (e) {
      return false;
    }
  }

  static Future<bool> tryUploadClassData() async {
    try {
      await Global.serverManager.uploadClassData(DataStorage.classData!);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  static Future<bool> tryInitUserData(int id) async {
    try {
      userData = await Global.serverManager.retrieveUserData(id);
      return true;
    }
    catch (e) {
      return false;
    }
  }
}

Future<int> getTotalStepsOfClass(ClassData classData) async {
  final sm = Global.serverManager;
  int sum = 0;

  List<UserData> userDatas = await sm.getUserDatasOfClass(classData);

  for (final ud in userDatas) { sum += ud.steps; }

  return sum;
}