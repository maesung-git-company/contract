import 'package:contract/core/config.dart';
import 'package:contract/core/data_storage.dart';
import 'package:flutter/cupertino.dart';

class Tree extends StatefulWidget {
  const Tree({super.key});

  @override
  State<Tree> createState() => _TreeState();
}

class _TreeState extends State<Tree> {
  @override
  void initState() {
    DataStorage.userData.addListener(this, () { setState(() {}); });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Image(
          image: getTreeImgByProgress(),
          fit: BoxFit.cover,
        )
      ),
    );
  }
}


AssetImage getTreeImgByProgress() {
  double progress = DataStorage.userData.steps % Config.stepRequiredPerTree
      / Config.stepRequiredPerTree;

  String path = [
    'assets/images/tree1.png',
    'assets/images/tree2.png',
    'assets/images/tree3.png',
    'assets/images/tree4.png'
  ][(progress * 4).toInt()];

  return AssetImage(path);
}
