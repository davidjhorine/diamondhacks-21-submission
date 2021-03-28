//This file defines the colorscheme of the app
import 'package:flutter/material.dart';

// These colors are the main colors of the app
const textLight = Color(0xFFEEF0F2);
const textDark = Color(0xFF171212);
const bgLight = Color(0xFFC5BCB4);
const bgDark = Color(0xFF856A6A);

// These colors will be used for the graph and anytime a bright accent is needed
const red = Color(0xFF8D3948);
const green = Color(0xFF7BA381);
const blue = Color(0xFF83B2EC);

// These's aren't colors, but close enough that they'll go here anyways
const textShadow =
    Shadow(blurRadius: 5, color: Colors.black12, offset: Offset(0, 1));
const headerText =
    TextStyle(fontSize: 30, color: textDark, fontWeight: FontWeight.bold);
