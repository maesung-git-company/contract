import 'package:contract/widget/home_page_app_bar/home_page_app_bar.dart';
  import 'package:flutter/material.dart';

class SchoolStatPage extends StatefulWidget {
  const SchoolStatPage({super.key});

  @override
  State<SchoolStatPage> createState() => _SchoolStatPageState();
}

class _SchoolStatPageState extends State<SchoolStatPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: HomePageAppBar(),
        body: Container(
          color: Colors.grey[232],
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(  // 2nd
                    padding: const EdgeInsets.only(top: 20),
                    child: SchoolRankBox(rank: 2, color: Colors.green, size: 60, title: 'School B', score: 85),
                  ),
                  Padding(  // 1st
                    padding: const EdgeInsets.only(top: 0),
                    child: SchoolRankBox(rank: 1, color: Colors.yellow, size: 80, title: 'School A', score: 95),
                  ),
                  Padding( // 3rd
                    padding: const EdgeInsets.only(top: 30),
                    child: SchoolRankBox(rank: 3, color: Colors.blue, size: 60, title: 'School C', score: 80),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(  
                      title: Text('Item ${index + 1}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SchoolRankBox extends StatelessWidget {
  final int rank;
  final Color color;
  final double size;
  final String title;
  final int score;

  const SchoolRankBox({
    super.key,
    required this.rank,
    required this.color,
    this.size = 60,
    required this.title,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          width: size + 40,
          height: size + 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$rank',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
