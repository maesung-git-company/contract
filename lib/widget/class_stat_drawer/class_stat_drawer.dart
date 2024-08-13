import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClassStatDrawer extends StatefulWidget {
  const ClassStatDrawer({super.key});

  @override
  State<ClassStatDrawer> createState() => _ClassStatDrawerState();
}

class _ClassStatDrawerState extends State<ClassStatDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(  // todo
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
