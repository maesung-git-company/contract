import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/global.dart';
import '../../structure/class/user_data.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginIdController = TextEditingController();
  late UniqueKey _uniqueKey;
  String _textMsg = "";

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  onLoginAttempt() async {
    int userId = int.parse(_loginIdController.text);

    if (userId > pow(2, (4 * 8 - 1)) - 1) {
      displayErrorMessageFor(
        "정상적인 숫자를 써주세요..",
        5000
      );
      return;
    }

    Global.serverManager.retrieveUserData(userId).then((value) {
      onLoginSuccess(value);
    }).catchError((error) {
      onLoginFail();
    });
  }

  onLoginSuccess(UserData userData) {
    Global.prefs.setInt('user_id', userData.id);
    Global.userData = userData;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  onLoginFail() {
    displayErrorMessageFor(
      "존재하는 아이디를 써주세요.. 에러라 판단되면 2216을 찾으시오..",
      5000
    );
  }

  displayErrorMessage(String msg) {
    setState(() {
      _textMsg = msg;
    });
  }

  displayErrorMessageFor(String msg, int milliseconds) {
    displayErrorMessage(msg);

    UniqueKey tmp = UniqueKey();
    _uniqueKey = tmp;

    Future.delayed(
      Duration(milliseconds: milliseconds), () {
        if (tmp == _uniqueKey) displayErrorMessage("");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
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

