import 'package:contract/structure/class/user_data.dart';
import 'package:uuid/uuid.dart';

import '../../../structure/class/class_data.dart';

abstract interface class ServerManagerI {
  Future<void> initDB();

  Future<Map<String, dynamic>> getUserDataRaw(int userId);
  Future<UserData> retrieveUserData(int userId);
  Future<void> updateUserData();
  Future<List<ClassData>> getBelongClasses(int userId);

  Future<Map<String, dynamic>> getClassDataRaw(Uuid id);  // todo perhaps refactoring all the param names
  Future<ClassData> retrieveClassData(Uuid id);
  Future<DateTime> getClassLatestSumWhen(Uuid id);
  Future<List<UserData>> getUserDatasOfClass(Uuid id);
  Future<void> updateClassLatestTotalSteps(Uuid id, int totalSteps);
  Future<int> getLatestClassTotalSteps(Uuid id);
}