import 'package:flutter/material.dart';
import '../src/MyNotes.dart';
import 'NewNoteScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: notes.returnWidgets(context) +
                <Widget>[
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: FloatingActionButton.extended(
                            onPressed: () async {
                              var url = Uri.parse(
                                  'https://goquotes-api.herokuapp.com/api/v1/random/1?type=tag&val=motivational');
                              var response = await http.get(url);
                              print('Response body: ${response.body}');
                              Map<String, dynamic> resp =
                                  jsonDecode(response.body);
                              String text = "";
                              if (resp["count"] > 0) {
                                text =
                                    "${resp['quotes'][0]['text']} - ${resp['quotes'][0]['author']}";
                              }
                              final snackBar = SnackBar(
                                content: Text(text),
                                behavior: SnackBarBehavior.floating,
                                duration:
                                    Duration(seconds: 6, milliseconds: 500),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            },
                            label: const Text("Get Inspired"),
                          ))
                    ],
                  ),
                ],
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
