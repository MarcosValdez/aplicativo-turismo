import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class notePage extends StatefulWidget {
  @override
  _notesState createState() => _notesState();
}
class _notesState extends State<notePage>{
  
  Future<List> notas = getNotes("marcos@gmail.com")

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Notas'),
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<List>(
        stream: getNotes(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final notes = snapshot.data!;

            return ListView(
              //children: notes,
            )
          }
        },
      )
    );
  }

  Widget btn_get(){
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        width: 150,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: (){
            Future<List> items = getNotes("marcos@gmail.com");
            print(items);
          },
          icon: Icon(Icons.exit_to_app),
          label: Text('Obtener', textAlign: TextAlign.center),
        )
    );
  }

  Stream<List> getNotes() => FirebaseFirestore.instance
      .collection("Note")
      .snapshots()
      .map((event) =>
        event.docs.map((e) => e.get("text")).toList());
}