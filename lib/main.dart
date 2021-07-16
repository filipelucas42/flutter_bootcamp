import 'package:flutter/material.dart';
import 'screens/MyApp.dart';
import 'src/MyNotes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var notes = new Notes();
  await notes.getStorageInstance();
  notes.syncNotes();
  runApp(MyApp(notes));
}
