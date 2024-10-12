import 'package:flutter/cupertino.dart';

class ClassData with ChangeNotifier {
  late final String uuid;
  late final String name;
  late final List<int> usersId;
  late final String belongSchoolUuid;
  late int latestSumOfSteps;
  late DateTime latestSumWhen;

  ClassData({
    required this.uuid,
    required this.name,
    required this.usersId,
    required this.latestSumOfSteps,
    required this.latestSumWhen,
    required this.belongSchoolUuid
  });
}
