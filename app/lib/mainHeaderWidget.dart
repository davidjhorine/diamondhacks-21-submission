// This widget will be used to display the graph and percentage header on the main screen
import 'package:flutter/material.dart';
import './ourColors.dart' as ourColors;
import 'package:pie_chart/pie_chart.dart';

class HeaderWidget extends StatefulWidget {
  Map stats;
  HeaderWidget({this.stats});
  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
          /*image: DecorationImage(
          image: AssetImage('put thing here'), //TODO: Add correct image
          fit: BoxFit.cover,
        ),*/
          color: ourColors.bgDark,
          image: DecorationImage(
              image: AssetImage('images/BikeHeader.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  ourColors.bgDark.withOpacity(.8),
                  BlendMode
                      .darken)), //This image causes readability to suffer too much
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _AnimatedHeaderGraph(stats: widget.stats),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.stats['carUsage'].toString() + '% Car',
                style: TextStyle(
                    color: ourColors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [ourColors.textShadow]),
              ),
              Text(
                widget.stats['publicUsage'].toString() + '% Public',
                style: TextStyle(
                    color: ourColors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [ourColors.textShadow]),
              ),
              Text(
                widget.stats['bikeUsage'].toString() + '% Bike',
                style: TextStyle(
                    color: ourColors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [ourColors.textShadow]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedHeaderGraph extends StatefulWidget {
  Map stats;
  _AnimatedHeaderGraph({this.stats});
  @override
  __AnimatedHeaderGraphState createState() => __AnimatedHeaderGraphState();
}

class __AnimatedHeaderGraphState extends State<_AnimatedHeaderGraph> {
  @override
  Widget build(BuildContext context) {
    final Map<String, double> pieData = {
      "Car": widget.stats['carUsage'].toDouble(),
      "Public": widget.stats['publicUsage'].toDouble(),
      "Bike": widget.stats['carUsage'].toDouble(),
    };
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          colorList: [ourColors.red, ourColors.blue, ourColors.green],
          dataMap: pieData,
          legendOptions: LegendOptions(showLegends: false),
          chartRadius: 100,
          chartValuesOptions: ChartValuesOptions(showChartValues: false),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: ourColors.bgDark,
              shape: BoxShape.circle,
            ),
            width: 90,
            height: 90,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.stats['score'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: ourColors.textLight,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'points this month',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: ourColors.textLight),
                ),
              ],
            )),
          ),
        )
      ],
    );
  }
}
