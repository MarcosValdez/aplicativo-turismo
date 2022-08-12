import 'package:aplicativo_turismo/Turismo/models/pais.dart';
import 'package:flutter/material.dart';

class PaisListItem extends StatelessWidget {
  const PaisListItem({Key? key, required this.post}) : super(key: key);

  final Pais post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        //leading: Text('${post.codigo}', style: textTheme.caption),
        //leading: Text('sss', style: textTheme.caption),
        title: Text(post.nombre),
        isThreeLine: true,
        subtitle: Text(post.continente),
        dense: true,
      ),
    );
  }
}