import 'package:flutter/material.dart';
import './ourColors.dart' as ourColors;

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Settings',
            style: ourColors.headerText,
          ),
          Text(
            'Change password',
            style: TextStyle(color: ourColors.textDark, fontSize: 20),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Old Password'),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'New Password'),
          ),
          ElevatedButton(onPressed: null, child: Text('Change Password')),
          Text('\n\nWARNING! The "delete account" button is permanant!',
              style: TextStyle(color: ourColors.red, fontSize: 20)),
          ElevatedButton(onPressed: null, child: Text('Delete Account')),
        ],
      ),
    );
  }
}
