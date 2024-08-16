import 'package:contract/widget/leader_board_panel/leader_board_rank.dart';
import 'package:flutter/material.dart';

import 'leader_board_ranking.dart';

class LeaderBoardPanel extends StatefulWidget {
  const LeaderBoardPanel({super.key});

  @override
  State<LeaderBoardPanel> createState() => _LeaderBoardPanelState();
}

class _LeaderBoardPanelState extends State<LeaderBoardPanel> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            LeaderBoardRank(),
            LeaderBoardRanking()
          ],
        ),
      ),
    );
  }
}
