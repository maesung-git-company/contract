import 'package:contract/page/class_stat/class_stat_page.dart';
import 'package:contract/page/home/home_page.dart';
import 'package:contract/widget_functional/swipe_app/swipe_app.dart';
import 'package:flutter/cupertino.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SwipeApp(
      pages: [
        HomePage(),
        ClassStatPage(), // todo SchoolStatPage
      ],
      initialPageIndex: 0,
    );
  }
}
