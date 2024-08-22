import 'package:contract/structure/class/user_data.dart';

import '../../../structure/class/class_data.dart';

abstract interface class ServerManagerI {
  Future<void> connectDB();

  Future<Map<String, dynamic>> getUserDataRaw(int userId);
  Future<UserData> retrieveUserData(int userId);
  //Future<void> updateUserData(); // todo

  Future<Map<String, dynamic>> getClassDataRaw(String uuid);
  Future<ClassData> retrieveClassData(String uuid);
  Future<List<UserData>> getUserDatasOfClass(ClassData classData);
  Future<void> uploadClassData(ClassData classData);
  // todo update, school
}
