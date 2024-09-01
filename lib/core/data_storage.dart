import 'dart:math';

import 'package:contract/structure/class/class_data.dart';
import 'package:contract/structure/class/school_data.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:flutter/cupertino.dart';

import 'global.dart';

class DataStorage with ChangeNotifier {
  late UserData userData;
  ClassData? classData;
  SchoolData? schoolData;

  List<UserData>? classmatesDataSortedBySteps;

  final Map<Data, bool> updating = {
    Data.userData: false,
    Data.classData: false,
    Data.schoolData: false,
    Data.classmatesDataSortedBySteps: false,
  };

  Future<bool> tryUpdateUserData() async {
    if (updating[Data.userData]!) return false;
    updating[Data.userData] = true;

    try {
      final UserData updatedUserData = await Global.serverManager.retrieveUserData(userData.id);
      userData.steps = max(userData.steps, updatedUserData.steps);
      userData.secondsActive = max(userData.secondsActive, updatedUserData.secondsActive);
      notifyListeners();
      return true;
    }
    catch (e) {
      return false;
    }
    finally {
      updating[Data.userData] = false;
    }
  }

  Future<bool> tryUpdateClassData({bool upload = false}) async {
    if (updating[Data.classData]!) return false;
    updating[Data.classData] = true;

    try {
      final ClassData updatedClassData = await Global.serverManager.retrieveClassData(userData.belongClassId);

      DateTime now = DateTime.now();

      if (now.difference(updatedClassData.latestSumWhen).inMinutes > 5) {
        updatedClassData.latestSumOfSteps = await getTotalStepsOfClass(updatedClassData);
        updatedClassData.latestSumWhen = now;
        if (upload) tryUploadClassData();
      }

      // apply db data to local
      if (classData == null) {
        classData = updatedClassData;
        notifyListeners();
        return true;
      }

      classData!.latestSumOfSteps = max(classData!.latestSumOfSteps, updatedClassData.latestSumOfSteps);
      classData!.latestSumWhen = now.isAfter(updatedClassData.latestSumWhen) ? now : updatedClassData.latestSumWhen;

      notifyListeners();
      return true;
    }
    catch (e) {
      return false;
    }
    finally {
      updating[Data.classData] = false;
    }
  }

  Future<bool> tryUpdateClassmatesDataSortedBySteps() async {
    if (updating[Data.classmatesDataSortedBySteps]!) return false;
    updating[Data.classmatesDataSortedBySteps] = true;

    try {
      final sm = Global.serverManager;

      if (classData == null) {
        await tryUpdateClassData();
      }

      if (classData == null) {
        return false;
      }

      List<UserData> res =
      await sm.getUserDatasOfClass(classData!);

      res.sort((a, b) => b.steps.compareTo(a.steps));

      classmatesDataSortedBySteps = res;

      notifyListeners();
      return true;
    }
    catch (e) {
      return false;
    }
    finally {
      updating[Data.classmatesDataSortedBySteps] = false;
    }
  }

  Future<bool> tryUploadUserData() async {
    try {
      await Global.serverManager.uploadUserData(userData);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> tryUploadClassData() async {
    try {
      await Global.serverManager.uploadClassData(classData!);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<void> tryTotalUpdate() async {
    tryUpdateUserData();
    tryUpdateClassData(upload: true);
    tryUpdateClassmatesDataSortedBySteps();
  }

  void totalDelete() {
    classData = null;
    classmatesDataSortedBySteps = null;
    schoolData = null;
  }

  Future<bool> tryInitUserData(int id) async {
    try {
      userData = await Global.serverManager.retrieveUserData(id);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  void addStep() {
    userData.steps++;
    notifyListeners();
  }

  void addActiveTime() {
    userData.secondsActive++;
    notifyListeners();
  }
}

Future<int> getTotalStepsOfClass(ClassData classData) async {
  final sm = Global.serverManager;
  int sum = 0;

  List<UserData> userDatas = await sm.getUserDatasOfClass(classData);

  for (final ud in userDatas) { sum += ud.steps; }

  return sum;
}

enum Data {
  userData,
  classData,
  schoolData,
  classmatesDataSortedBySteps,
}
