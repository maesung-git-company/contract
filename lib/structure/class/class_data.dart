import 'package:contract/structure/class/user_data.dart';
import 'package:uuid/uuid.dart';

import '../../core/global.dart';
import 'interface_organization.dart';

class ClassData implements OrganizationI {
  @override
  late final Uuid id;

  @override
  late final String name;

  @override
  Future<int> getTotalStep() async {
    final sm = Global.serverManager;

    final DateTime dt = await sm.getClassLatestSumWhen(id);
    final difference = DateTime.now().difference(dt);

    int res;

    if (difference.inMinutes > 1) {
      int sum = 0;
      List<UserData> uds = await sm.getUserDatasOfClass(id);

      for (final ud in uds) { sum += ud.steps; }

      sm.updateClassLatestTotalSteps(id, sum);  // todo perhaps refactoring
      res = sum;
    }
    else {
      res = await sm.getLatestClassTotalSteps(id);
    }

    return res;
  }
}
