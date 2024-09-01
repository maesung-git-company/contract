// used for global scope


import 'package:contract/core/data_storage.dart';

import '../structure/class/app_status.dart';
import 'manager/server/interface_server_manager.dart';

class Global {
  static final DataStorage ds = DataStorage();
  static AppStatus appStatus = AppStatus();

  static late ServerManagerI serverManager;
}


