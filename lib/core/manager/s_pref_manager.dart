import 'package:contract/structure/class/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPrefManager {
  static Future<UserData?> getSavedUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      UserData userData = UserData(
          id: prefs.getInt(PrefName.userId)!,
          steps: prefs.getInt(PrefName.userSteps)!,
          secondsActive: prefs.getInt(PrefName.userSecondsActive)!,
          belongClassId: prefs.getString(PrefName.userBelongClassId)!
      );

      return userData;
    }
    catch (e) {
      deleteSavedUserData();
      return null;
    }
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