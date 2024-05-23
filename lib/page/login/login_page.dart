import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/global.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  // Obtain shared preferences.
  final TextEditingController _loginIdController = TextEditingController();
  String _textMsg = "";

  Future<void> saveLoginId(int loginId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('login_id', loginId);
  }

  onLoginAttempt() async { // todo login session
    final supabase = Supabase.instance.client;
    int userId = int.parse(_loginIdController.text);

    if (userId > 32767) {
      displayErrorMessage("정상적인 숫자를 써주세요..");
      return;
    }

    try {
      final data = await supabase
          .from('user_data')
          .select()
          .eq('id', userId)
          .single();

      onLoginSuccess();
    }
    catch (e) {
      onLoginFail();
    }
  }

  onLoginSuccess() {
    saveLoginId(int.parse(_loginIdController.text));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  onLoginFail() {
    displayErrorMessage("존재하는 아이디를 써주세요.. 에러라 판단되면 2216을 찾으시오..");
  }

  displayErrorMessage(String msg) {
    setState(() {
      _textMsg = msg;
    });
  }

  removeErrorMessageAfter(int milliseconds) {  // todo not done yet, handle future thing
    Future.delayed(
      Duration(milliseconds: milliseconds), () {
        displayErrorMessage("");
      }
    );
  }

  displayErrorMessageFor(String msg, int milliseconds) {
    displayErrorMessage(msg);

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
                  onPressed: onLoginAttempt,
                  child: const Text('확인',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              Text(
                _textMsg,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        )
    );
  }
}

