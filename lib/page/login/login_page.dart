import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  // Obtain shared preferences.
  final TextEditingController _loginIdController = TextEditingController();

  Future<void> saveLoginId(int loginId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('login_id', loginId);
  }

  onLogin() async {
    final supabase = Supabase.instance.client;
    int userId = int.parse(_loginIdController.text);

    final data = await supabase
        .from('user_data')
        .select()
        .eq('id', userId)
        .single();
    // todo catch error

    print(data);
    print("------------------------");
    // saveLoginId(int.parse(_loginIdController.text));
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    int? loginId = Global.userData.id;



    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              
              SizedBox(width: 100, height: 350,),

              if (loginId == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _loginIdController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '본인의 연도학번 을 입력해주세요',
                      ),
                    ),
                  ),

              SizedBox( width: 100, height: 50, ),

              OutlinedButton(
                  onPressed: onLogin,
                  child: const Text('확인', 
                    style: TextStyle(color: Colors.black),
                  ),
                ),
            ],
          ),
        )
    );
  }
}

