import 'package:contract/structure/class/user_data.dart';

import '../../../structure/class/class_data.dart';

abstract interface class ServerManagerI {
  Future<void> initDB();

  Future<Map<String, dynamic>> getUserDataRaw(int userId);
  Future<UserData> retrieveUserData(int userId);
  Future<List<ClassData>> getBelongClasses(int userId);
  Future<void> updateUserData();

  Future<Map<String, dynamic>> getClassDataRaw(String uuid);
  Future<List<UserData>> getUserDatasOfClass(String uuid);
  Future<DateTime> getClassLatestSumWhen(String uuid);
  Future<int> getLatestClassTotalSteps(String uuid);
  Future<ClassData> retrieveClassData(String uuid);
  Future<void> updateClassLatestTotalSteps(String uuid, int totalSteps);
}