import 'package:contract/core/utility.dart';
import 'package:contract/page/login_page/login_page.dart';
import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  Utility.logOut();
                  return LoginPage();
                }),
              );
            },
            icon: Icon(Icons.arrow_back_ios_new));
      }),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey.shade500,
        ),
      ),
      title: const Text('Step Counter'),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
