import 'package:flutter/material.dart';
import '../src/MyNotes.dart';
import 'MyApp.dart';

class NewNoteScreen extends StatelessWidget {
  TextEditingController noteForm = new TextEditingController();
  TextEditingController noteTitle = new TextEditingController();
  Notes notes;
  NewNoteScreen(this.notes);
  @override
  Widget build(BuildContext context) {
    final title = 'Create Note';

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: noteTitle,
                  maxLines: null,
                  decoration: InputDecoration(hintText: "Title"),
                )),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: noteForm,
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(hintText: "Text"),
                    )))
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              var text = this.noteForm.text.toString();
              var title = this.noteTitle.text.toString();
              var note = new Note(title, text);
              notes.addNote(note);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp(this.notes)),
              );
            },
            label: Text("Create Note")));
  }
}
