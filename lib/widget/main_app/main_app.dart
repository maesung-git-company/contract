import 'package:contract/page/class_stat_page/class_stat_page.dart';
import 'package:contract/page/home_page/home_page.dart';
import 'package:contract/page/school_stat_page/school_stat_page.dart';
import 'package:contract/widget_functional/swipe_app/swipe_app.dart';
import 'package:flutter/cupertino.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SwipeApp(
      pages: [
        HomePage(),
        ClassStatPage(),
        SchoolStatPage(),
      ],
      initialPageIndex: 0,
    );
  }
}
