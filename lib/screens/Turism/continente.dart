import 'package:aplicativo_turismo/screens/Turism/pais.dart';
import 'package:flutter/material.dart';

class continente extends StatefulWidget {
  @override
  _continenteState createState() => _continenteState();
}

class _continenteState extends State<continente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destinos a visitar"),
      ),
      backgroundColor: Colors.black,
      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ListaContinentes(),
/*            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_boton("America")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _boton("Europa"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _boton("Asia"),
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  var _lista=['America', 'Asia', 'Europa', 'Africa', 'Oceania'];
  var _vista="Seleccionar una opcion";
  Widget _ListaContinentes(){
    return  DropdownButtonFormField<String>(
      value: null,
      hint: Text(_vista),
      dropdownColor: Colors.blue, //dropdown background color
      isExpanded: true, //make true to make width 100%
      items: _lista.map((String a) {
        return DropdownMenuItem<String>(
          value: a,
          child: Text(a),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _vista=value!;
        });
      },

    )
    ;
  }

  Widget _boton(String texto) {
    return SizedBox(
        height: 90,
        width: 250,
        child: RaisedButton(
          child: Text(
            texto,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          color: Colors.blue,
          elevation: 5,
          padding: EdgeInsets.all(30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pais()),
            ),
          },
        ));
  }

}
