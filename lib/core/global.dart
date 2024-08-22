// used for global scope


import '../structure/class/app_status.dart';
import 'manager/server/interface_server_manager.dart';

class Global {
  static AppStatus appStatus = AppStatus();

  static late ServerManagerI serverManager;
}


