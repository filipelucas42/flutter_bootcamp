import 'package:flutter/material.dart';

void main() {
  var notes = new Notes();
  runApp(MyApp(notes));
}

class User {
  bool active = false;
}

User user = new User();

class MyApp extends StatelessWidget {
  Notes notes;
  MyApp(this.notes);
  @override
  Widget build(BuildContext context) {
    final title = 'Notes';

    return MaterialApp(
      title: title,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Column(
            children: notes.returnWidgets(context),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewNoteScreen(notes)),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

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

class Note {
  String text;
  String key;
  String title;
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
    this.notes[note.key] = note;
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
                    EditNoteScreen(this, this.notes[element])),
          )
        },
        child: ListTile(
          title: Text(notes[element].title),
          subtitle: Text(notes[element].text),
        ),
      ));
    });
    return widgets;
  }
}

class EditNoteScreen extends StatelessWidget {
  TextEditingController noteForm;
  TextEditingController noteTitle;
  Notes notes;
  Note note;
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
