import 'package:flutter/material.dart';
import './ourColors.dart' as ourColors;
import './testData.dart' as testData;

class TripsView extends StatelessWidget {
  final Function edit;
  TripsView({this.edit});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your trips',
                    style: ourColors.headerText,
                  ),
                  IconButton(onPressed: () => edit(-1), icon: Icon(Icons.add)),
                ],
              )),
          Expanded(
              child: ListView.builder(
                  itemCount: testData.fakeTrips['data'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return TripItem(
                      duration: testData.fakeTrips['data'][index]['duration'],
                      id: testData.fakeTrips['data'][index]['duration'],
                      tripType: testData.fakeTrips['data'][index]['tripType'],
                      edit: edit,
                    );
                  }))
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TripItem extends StatelessWidget {
  final String tripType;
  final Function edit;
  final int id, duration;
  int points;
  TripItem({this.tripType, this.id, this.duration, this.edit}) {
    if (tripType == 'car') {
      points = 0 - (duration.toDouble() * .25).round();
    } else if (tripType == 'public') {
      points = (duration.toDouble() * .5).round();
    } else if (tripType == 'bike') {
      points = duration;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 60,
      decoration: BoxDecoration(
          color: ourColors.bgDark, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ourColors.bgLight,
                    // TODO: Add image based on travel type
                  )),
              Text('  ' + this.duration.toString() + " minutes: ",
                  style: TextStyle(
                    color: ourColors.textLight,
                    fontSize: 20,
                  )),
              Text(
                points.toString(),
                style: TextStyle(
                  color: (points < 0) ? ourColors.red : ourColors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          IconButton(
            onPressed: () => edit(id),
            icon: Icon(Icons.edit),
            color: ourColors.textLight,
          ),
        ],
      ),
    );
  }
}
