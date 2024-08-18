import 'package:contract/core/global.dart';
import 'package:contract/structure/class/user_data.dart';

// todo maybe store the data as static to save times on sorting?
Future<List<UserData>> getClassmatesSortedBySteps() async {
  final sm = Global.serverManager;
  final cls = await sm.getBelongClasses(Global.userData.id);

  List<UserData> res =
  await sm.getUserDatasOfClass(cls[0].uuid);

  res.sort((a, b) => b.steps.compareTo(a.steps));

  return res;
}