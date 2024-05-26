// used for global scope

import 'package:shared_preferences/shared_preferences.dart';

import '../structure/class/app_status.dart';
import '../structure/class/user_data.dart';
import 'manager/server/interface_server_manager.dart';

class Global {
  static UserData? userData;
  static AppStatus appStatus = AppStatus();

  static late ServerManagerI serverManager;
  static late SharedPreferences prefs;
}