import 'package:aplicativo_turismo/Turismo/models/pais.dart';
import 'package:flutter/material.dart';

class PaisListItem extends StatelessWidget {
  const PaisListItem({Key? key, required this.post}) : super(key: key);

  final Pais post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
        child: Column(children: <Widget>[
      Container(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white38, width: 1),
            borderRadius: BorderRadius.circular(9),
          ),
          tileColor: Color.fromRGBO(207, 235, 229, 1),
          //tileColor: Color.fromARGB(255, 36, 219, 192),
          leading: Icon(Icons.emoji_flags),
          title: Text(post.nombre),
          subtitle: Text(post.continente),
          //dense: true,
          onTap: () => {print("object")},
        ),
      ))
    ]));
  }
}
