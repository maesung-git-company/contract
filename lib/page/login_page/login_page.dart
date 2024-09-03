// ignore: unused_import
import 'dart:math';

// ignore: unused_import
import 'package:contract/core/data_storage.dart';
import 'package:contract/core/global.dart';
import 'package:contract/core/manager/s_pref_manager.dart';
import 'package:contract/widget/main_app/main_app.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginIdController = TextEditingController();
  late UniqueKey _uniqueKey;
  String _textMsg = "";

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  onLoginAttempt() async {
    int userId = int.parse(loginIdController.text);

    if (userId.toString().length > 6) {
      displayErrorMessageFor(
        "정상적인 숫자를 써주세요..",
        5000
      );
      return;
    }

    bool success = await Global.ds.tryInitUserData(userId);
    if (success) {
      onLoginSuccess();
    }
    else {
      onLoginFail();
    }
  }

  onLoginSuccess() {
    SPrefManager.saveUserData(Global.ds.userData);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainApp()),
    );
  }

  onLoginFail() {
    displayErrorMessageFor(
      "다음 중 하나의 문제가 발생했습니다: \n아이디, 인터넷 연결, 개발자 2216",
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
          body: Container(
            margin: EdgeInsets.fromLTRB(40, 50, 40, 0),
            child: Column(
              children: [
                Text("Log In",
                  style: TextStyle(
                    fontSize: 50, 
                    fontWeight: FontWeight.w700,
                    color: Colors.black, 
                  ),
                ),
                Text(
                  "아이디는 24(학번)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff757575)
                  ),
                ),
                SizedBox(height: 250,),
                LoginTextField(loginIdController: loginIdController),
                SizedBox(height: 50,),
                OutlinedButton(onPressed: onLoginAttempt, child: Text("로그인")),
                Text(_textMsg,)
              ],
            ),
          ),
        )
      );
    }
  }

class LoginTextField extends StatefulWidget {
  final loginIdController;
  
  const LoginTextField({super.key, this.loginIdController});

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.loginIdController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: '아이디를 입력하세요..',
        hintText: 'ex)242216',
      ),
    );
  }
}
