import 'package:contract/core/global.dart';
import 'package:contract/core/utility.dart';
import 'package:contract/page/login_page/login_page.dart';
import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(
          color: Colors.grey.shade500,
        ),
      ),
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
      title: const Text('매성 그린워킹'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            Global.ds.tryTotalSyncExceptUser();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
