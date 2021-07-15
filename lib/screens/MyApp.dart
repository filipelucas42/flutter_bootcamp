import 'package:flutter/material.dart';
import '../src/MyNotes.dart';
import 'NewNoteScreen.dart';

class MyApp extends StatelessWidget {
  Notes notes;
  MyApp(this.notes);
  @override
  Widget build(BuildContext context) {
    final title = 'Notes';

    return Scaffold(
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
    );
  }
}
