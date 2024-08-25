import 'package:contract/structure/class/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPrefManager {
  static late final UserData? _savedUserData;

  static Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      _savedUserData = UserData(
        id: prefs.getInt(PrefName.userId)!,
        steps: prefs.getInt(PrefName.userId)!,
        secondsActive: prefs.getInt(PrefName.userId)!,
        belongClassId: prefs.getString(PrefName.userSecondsActive)!
      );
    }
    catch (e) {
      deleteSavedUserData();
      _savedUserData = null;
    }
  }

  static UserData? getSavedUserData() {
    return _savedUserData;
  }

  static Future<void> deleteSavedUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(PrefName.userId);
    prefs.remove(PrefName.userSteps);
    prefs.remove(PrefName.userSecondsActive);
    prefs.remove(PrefName.userBelongClassId);
  }

  static Future<void> saveUserData(UserData userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(PrefName.userId, userData.id);
    prefs.setInt(PrefName.userSteps, userData.steps);
    prefs.setInt(PrefName.userSecondsActive, userData.secondsActive);
    prefs.setString(PrefName.userBelongClassId, userData.belongClassId);
  }
}

class PrefName {
  static const userId = 'userId';
  static const userSteps = 'userSteps';
  static const userSecondsActive = 'userSecondsActive';
  static const userBelongClassId = 'userBelongClassId';
}