import 'package:contract/structure/class/user_data.dart';

import '../../core/global.dart';
import 'interface_organization.dart';

class ClassData implements OrganizationI {
  @override
  late final String uuid;

  @override
  late final String name;

  @override
  Future<int> getTotalStep() async { // todo should I put this thing in server manager?
    final sm = Global.serverManager;

    final DateTime dt = await sm.getClassLatestSumWhen(uuid);
    final difference = DateTime.now().difference(dt);

    int res;

    if (difference.inMinutes > 1) {
      int sum = 0;
      List<UserData> uds = await sm.getUserDatasOfClass(uuid);

      for (final ud in uds) { sum += ud.steps; }

      sm.updateClassLatestTotalSteps(uuid, sum);
      res = sum;
    }
    else {
      res = await sm.getLatestClassTotalSteps(uuid);
    }

    return res;
  }
}
