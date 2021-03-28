import 'package:flutter/material.dart';
import './ourColors.dart' as ourColours;
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class EditTrip extends StatelessWidget {
  Function goBackToLists;
  int editId;
  String tripType;
  EditTrip({this.goBackToLists, this.editId});
  @override
  Widget build(BuildContext context) {
    String value = 'car';
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            (editId == -1) ? 'Create a trip' : 'Edit a trip',
            style: ourColours.headerText,
          ),
          CustomRadioButton(
            radioButtonValue: (value) => print(value),
            unSelectedColor: ourColours.bgLight,
            selectedColor: ourColours.bgDark,
            buttonLables: [
              "Car",
              "Public",
              "Bike",
            ],
            buttonValues: [
              "car",
              "public",
              "bike",
            ],
            defaultSelected: "car",
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration:
                InputDecoration(hintText: 'Duration of the trip in minutes'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: goBackToLists, child: Text('Cancel')),
              (editId != -1)
                  ? ElevatedButton(onPressed: null, child: Text('Delete'))
                  : Text(''),
              ElevatedButton(onPressed: null, child: Text('Confirm'))
            ],
          )
        ],
      ),
    );
  }
}
