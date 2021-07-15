import 'package:flutter/material.dart';
import '../screens/EditNoteScreen.dart';

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
  Map<String, Note> notes = {};
  addNote(Note note) {
    print("adding note ${note.key}");
    notes[note.key] = note;
  }

  changeNote(String key, Note note) {
    print("change note $key");
    note.key = key;
    this.notes[key] = note;
  }

  deleteNote(String key) {
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
