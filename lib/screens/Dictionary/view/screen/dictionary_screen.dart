import 'package:aplicativo_turismo/color_constants.dart';
import 'package:aplicativo_turismo/screens/Dictionary/view/widget/dictionary_widget.dart';
import 'package:flutter/material.dart';

class DictionaryScreen extends StatefulWidget{
  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}
class _DictionaryScreenState extends State<DictionaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.secondaryColor,
          title: Text("Biblioteca", style: Theme
              .of(context)
              .textTheme
              .bodySmall
              ?.merge(TextStyle(color: Colors.white))),
        ),
        backgroundColor: ColorConstants.lightBackground,
        body: DictionaryWidget()
    );
  }
}