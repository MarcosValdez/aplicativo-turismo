import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aplicativo_turismo/screens/Notes/new_note.dart';

class notePage extends StatefulWidget {
  @override
  _notesState createState() => _notesState();
}
class _notesState extends State<notePage>{

  final correoPrueba = "marco@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Notas'),
      ),
      backgroundColor: Colors.black87,
      body: lstNote()
    );
  }

  Widget lstNote() => StreamBuilder<List<Note>>(
    stream: getNotes(correoPrueba),
    builder: (context, snapshot){
      if(snapshot.hasData){
        final notes = snapshot.data!;
        final notestxt = notes.map(buildNote).toList();
        return ListView.separated(
          itemCount: notes.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.white,
            height: 1.0,
          ),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                child: notestxt[index]
            ),
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );

  Widget btn_newnote(){
    return Container(
        margin: EdgeInsets.only(top: 30),
        width: 150,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => newnotePage())
            );
          },
          icon: Icon(Icons.travel_explore),
          label: Text('nueva nota', textAlign: TextAlign.center),
        )
    );
  }

  Widget buildNote(Note note) => Text(
      note.text,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto'
      ),
  );

  Stream<List<Note>> getNotes(String correo) => FirebaseFirestore.instance
      .collection("Note")
      .where("correo", isEqualTo: correo)
      .snapshots()
      .map((snapshot) =>
        snapshot.docs.map((doc) => Note.fromJson(doc.data())).toList());
}

class Note{
  String id;
  final String correo;
  final String text;

  Note({
    this.id = '',
    required this.correo,
    required this.text
  });

  static Note fromJson(Map<String, dynamic> j) => Note(
      //id: j['id'],
      correo: j['correo'],
      text: j['text']
  );
}