import 'package:contract/structure/class/user_data.dart';

abstract interface class ServerManagerI {
  Future<void> initDB();
  Future<UserData> retrieveUserData(int userId);
  Future<void> updateUserData();
}