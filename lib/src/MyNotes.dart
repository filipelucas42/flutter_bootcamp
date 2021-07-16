import 'package:flutter/material.dart';
import '../screens/EditNoteScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Note {
  String text = "";
  String key = "";
  String title = "";

  Note(this.title, this.text) {
    this.key = new UniqueKey().toString();
    print("generate note ${this.key}");
  }

  changeText(String text) {
    this.text = text;
  }
}

class Notes {
  late SharedPreferences storage;
  late Map<String, dynamic> jsonNote;
  Map<String, Note> notes = {};
  syncNotes() {
    final keys = this.storage.getKeys();
    keys.forEach((element) {
      this.jsonNote = jsonDecode(this.storage.getString(element)!);

      Note note = new Note(this.jsonNote["title"], this.jsonNote["text"]);
      note.key = this.jsonNote["key"];
      notes[note.key] = note;
    });
  }

  saveNoteToStorage(Note note) {
    Map aux = {};
    aux["key"] = note.key;
    aux["title"] = note.title;
    aux["text"] = note.text;
    this.storage.setString(note.key, jsonEncode(aux));
  }

  getStorageInstance() async {
    this.storage = await SharedPreferences.getInstance();
  }

  addNote(Note note) async {
    this.saveNoteToStorage(note);
    notes[note.key] = note;
  }

  changeNote(String key, Note note) {
    print("change note $key");
    note.key = key;
    this.saveNoteToStorage(note);
    this.notes[key] = note;
  }

  deleteNote(String key) {
    this.storage.remove(key);
    notes.remove(key);
  }

  returnWidgets(BuildContext context) {
    var widgets = <Widget>[];
    this.notes.keys.forEach((element) {
      widgets.add(InkWell(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EditNoteScreen(this, this.notes[element]!)),
          )
        },
        child: ListTile(
          title: Text(notes[element]!.title),
          subtitle: Text(notes[element]!.text),
        ),
      ));
    });
    return widgets;
  }
}
