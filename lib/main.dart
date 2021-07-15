import 'package:flutter/material.dart';
import 'screens/MyApp.dart';
import 'src/MyNotes.dart';

void main() {
  var notes = new Notes();
  runApp(MyApp(notes));
}

class User {
  bool active = false;
}

User user = new User();
