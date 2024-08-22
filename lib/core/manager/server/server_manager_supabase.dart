
import 'package:contract/core/manager/server/interface_server_manager.dart';
import 'package:contract/structure/class/class_data.dart';
import 'package:contract/structure/class/user_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

 // todo return null 처리
class ServerManagerSupabase implements ServerManagerI {
  static var supabase;

  @override
  Future<void> connectDB() async { // todo connect
    await dotenv.load(fileName: 'assets/config/.env');
    
    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_KEY'),
    );

    supabase = Supabase.instance.client;
  }

  @override
  Future<Map<String, dynamic>> getUserDataRaw(int userId) async {
    final data = await supabase
        .from('user_data')
        .select()
        .eq('id', userId)
        .single();

    return data;
  }

  @override
  Future<UserData> retrieveUserData(int userId) async {
    final data = await getUserDataRaw(userId);

    UserData userData = UserData(
      id: userId,
      steps: data['steps'],
      secondsActive: data['seconds_active'],
      belongClassId: data['belong_class_id']
    );

    return userData;
  }

  // @override
  // updateUserData() async {
  //   final oldUserData = await retrieveUserData(DataStorage.userData?.id);
  //
  //   UserData ud = Global.userData;
  //
  //   ud.steps = max(ud.steps, oldUserData.steps);
  //   ud.secondsActive = max(ud.secondsActive, oldUserData.secondsActive);
  //
  //   await _supabase
  //       .from('user_data')
  //       .update({
  //         'steps': ud.steps,
  //         'seconds_active': ud.secondsActive
  //       })
  //       .eq('id', ud.id);
  // }

  @override
  Future<Map<String, dynamic>> getClassDataRaw(String uuid) async {
    final data = await supabase
        .from('class')
        .select()
        .eq('id', uuid)
        .single();

    return data;
  }

  @override
  Future<ClassData> retrieveClassData(String uuid) async {
    final data = await getClassDataRaw(uuid);

    ClassData res = ClassData(
      uuid: uuid,
      name: data['name'],
      usersId: List<int>.from(data['users_id'] as List),
      latestSumOfSteps: data['latest_sum_of_steps'],
      latestSumWhen: DateTime.parse(data['latest_sum_when'])
    );

    return res;
  }

  @override
  Future<List<UserData>> getUserDatasOfClass(ClassData classData) async {
    List<UserData> res = [];

    for (final int id in classData.usersId) {
      res.add(await retrieveUserData(id));
    }

    return res;
  }

  @override
  Future<void> uploadClassData(ClassData classData) async {
    await supabase
      .from('class')
      .update({
        'latest_sum_of_steps': classData.latestSumOfSteps,
        'latest_sum_when': classData.latestSumWhen
      })
      .eq('id', classData.uuid);
  }
}