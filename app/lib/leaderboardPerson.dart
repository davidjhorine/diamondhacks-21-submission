import 'package:flutter/material.dart';
import './ourColors.dart' as ourColors;
import 'package:pie_chart/pie_chart.dart';

class LeaderboardPerson extends StatelessWidget {
  final String username;
  final int place, car, public, bike;
  LeaderboardPerson(
      {this.username, this.car, this.public, this.bike, this.place});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        height: 60,
        decoration: BoxDecoration(
            color: ourColors.bgDark, borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // The two rows should look like this: [ [OO]     O ]
          children: [
            Row(
              children: [
                MiniGraph(this.place.toDouble(), this.car.toDouble(),
                    this.public.toDouble(), this.bike.toDouble()),
                Text(
                  // Substituting spaces instead of a container with margins allows for more rapid development times
                  " " + this.username,
                  style: TextStyle(color: ourColors.textLight, fontSize: 20),
                )
              ],
            ),
            IconButton(
              onPressed: () => 1 + 1,
              icon: Icon(Icons.delete),
              color: ourColors.textLight,
            )
          ],
        ));
  }
}

// ignore: must_be_immutable
class MiniGraph extends StatelessWidget {
  // These cannot be finals because the place value has to change later
  double place, car, public, bike;
  MiniGraph(this.place, this.car, this.public, this.bike);
  @override
  Widget build(BuildContext context) {
    place++; // Accounts for the fact that indexes start at 0, but the real world doesn't have a 0th place
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            dataMap: {"car": car, "public": public, "bike": bike},
            colorList: [ourColors.red, ourColors.blue, ourColors.green],
            legendOptions: LegendOptions(showLegends: false),
            chartRadius: 50,
            chartValuesOptions: ChartValuesOptions(showChartValues: false),
          ),
          Container(
            alignment: Alignment.center,
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (this.place == 1) ? ourColors.green : ourColors.bgLight,
            ),
            child: Text(
              this.place.toInt().toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ourColors.textDark,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
