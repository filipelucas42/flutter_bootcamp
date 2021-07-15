import 'package:flutter/material.dart';
import '../screens/MyApp.dart';
import '../src/MyNotes.dart';

class EditNoteScreen extends StatelessWidget {
  late TextEditingController noteForm;
  late TextEditingController noteTitle;
  late Notes notes;
  late Note note;
  EditNoteScreen(Notes notes, Note note) {
    print("edit note screen ${note.key}");
    this.notes = notes;
    this.note = note;
    this.noteForm = new TextEditingController(text: note.text);
    this.noteTitle = new TextEditingController(text: note.title);
  }
  @override
  Widget build(BuildContext context) {
    final title = 'Edit Note';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(16),
              child: TextFormField(
                controller: noteTitle,
                maxLines: null,
              )),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: TextFormField(
                    controller: noteForm,
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  )))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Row contents horizontally,

        children: [
          FloatingActionButton.extended(
              onPressed: () {
                var text = this.noteForm.text.toString();
                var title = this.noteTitle.text.toString();
                var note = new Note(title, text);
                print("on press key ${this.note.key}");
                note.key = this.note.key;
                this.notes.changeNote(this.note.key, note);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp(this.notes)),
                );
              },
              heroTag: "edit button",
              label: Text("Edit Note")),
          SizedBox(
            height: 10,
            width: 10,
          ),
          FloatingActionButton.extended(
              onPressed: () {
                var key = this.note.key;
                this.notes.deleteNote(key);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp(this.notes)),
                );
              },
              heroTag: "delete button",
              label: Text("Delete Note"))
        ],
      ),
/*         floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              var text = this.noteForm.text.toString();
              var title = this.noteTitle.text.toString();
              var note = new Note(title, text);
              print("on press key ${this.note.key}");
              note.key = this.note.key;
              this.notes.changeNote(this.note.key, note);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp(this.notes)),
              );
            },
            label: Text("Edit Note")) */
    );
  }
}
