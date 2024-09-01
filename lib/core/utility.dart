// i know this file name might scare you
// but..
// some things are just
// inevitable.....

// yeah they actually aren't

// mostly

import 'package:contract/core/manager/s_pref_manager.dart';

import 'data_storage.dart';

class Utility {
  static void logOut() {
    SPrefManager.deleteSavedUserData();
    DataStorage.totalDelete();
  }
}