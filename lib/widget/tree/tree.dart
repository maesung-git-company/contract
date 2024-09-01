
import 'package:contract/core/config.dart';
import 'package:contract/core/data_storage.dart';
import 'package:contract/core/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Tree extends StatefulWidget {
  const Tree({super.key});

  @override
  State<Tree> createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataStorage>(
      builder: (_, provider, __) {
        return Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(50, 20, 50, 20),
            width: double.infinity,
            child: Image(
              image: getTreeImgByProgress(),
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    );
  }
}


AssetImage getTreeImgByProgress() {
  double progress = Global.ds.userData.steps % Config.stepRequiredPerTree
      / Config.stepRequiredPerTree;

  String path = [
    'assets/images/tree1.png',
    'assets/images/tree2.png',
    'assets/images/tree3.png',
    'assets/images/tree4.png'
  ][(progress * 4).toInt()];

  return AssetImage(path);
}
