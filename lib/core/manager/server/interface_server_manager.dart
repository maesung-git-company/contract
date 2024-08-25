import 'package:contract/structure/class/school_data.dart';
import 'package:contract/structure/class/user_data.dart';

import '../../../structure/class/class_data.dart';

abstract interface class ServerManagerI {
  Future<void> connectDB();

  Future<Map<String, dynamic>> getUserDataRaw(int userId);
  Future<UserData> retrieveUserData(int userId);
  Future<void> uploadUserData(UserData userData);

  Future<Map<String, dynamic>> getClassDataRaw(String uuid);
  Future<ClassData> retrieveClassData(String uuid);
  Future<List<UserData>> getUserDatasOfClass(ClassData classData);
  Future<void> uploadClassData(ClassData classData);

  Future<Map<String, dynamic>> getSchoolDataRaw(String uuid);
  Future<SchoolData> retrieveSchoolData(String uuid);
  Future<List<ClassData>> getClassDatasOfSchool(SchoolData schoolData);
  Future<void> uploadSchoolData(SchoolData schoolData);
}
