
import 'package:contract/structure/class/class_data.dart';
import 'package:contract/structure/class/user_data.dart';
// ignore: unused_import
import 'package:supabase/supabase.dart';

T nullObjSafe<T>(T? value) {
  if (value != null) return value;

  if (T == UserData) {
    return UserData(
        id: 000000,
        steps: 1234,
        secondsActive: 12,
        belongClassId: "@@@@@@@@@@@@@@@"
    ) as T;
  }

  if (T == ClassData) {
    return ClassData(
        uuid: "@@@@@",
        name: "@@@@@@@@@@",
        usersId: [
          000000,
          000000,
          000000,
          000000,
          000000,
        ],
        latestSumOfSteps: 1234,
        latestSumWhen: DateTime.now(),
        belongSchoolUuid: ''
    ) as T;
  }

  if (T == List<UserData>) {
    return [
      nullObjSafe<UserData>(null),
      nullObjSafe<UserData>(null),
      nullObjSafe<UserData>(null),
      nullObjSafe<UserData>(null),
      nullObjSafe<UserData>(null),
    ] as T;
  }

  throw ArgumentError("null object of type $T does not exist!");
}