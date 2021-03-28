import 'package:flutter/material.dart';
import './ourColors.dart' as ourColors;

class AddNewCompetitor extends StatefulWidget {
  final Function goHome;
  AddNewCompetitor({this.goHome});

  @override
  _AddNewCompetitorState createState() => _AddNewCompetitorState();
}

class _AddNewCompetitorState extends State<AddNewCompetitor> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Want to compare your Carbon Points?',
              style: ourColors.headerText,
            ),
            Text(
                '\nAdd a competitor to compare points and stats on a leaderboard\n',
                style: TextStyle(color: ourColors.textDark, fontSize: 20)),
            TextField(
              decoration:
                  InputDecoration(hintText: 'Username of your competitor'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: this.widget.goHome, child: Text('Nevermind')),
                ElevatedButton(onPressed: null, child: Text('Add competitor!'))
              ],
            )
          ],
        ));
  }
}
