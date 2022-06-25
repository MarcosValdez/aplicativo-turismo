import 'package:flutter/material.dart';

class ModalFit extends StatelessWidget {
  const ModalFit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 8, //or null
              decoration:
                  InputDecoration.collapsed(hintText: "Ingresa la nota ..."),
            ),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.blue),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 80),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }
}
