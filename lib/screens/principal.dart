
import 'package:aplicativo_turismo/screens/Notes/view_notes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  @override
  _principalState createState() => _principalState();
}

class _principalState extends State<Principal> {
  int _currentIndex = 0;
  var Places = ['Macchu Picchu', 'Iquitos', 'Lunahuana'];
  var Desc = [
    'Machu Picchu es una ciudadela inca ubicada en las alturas de las montañas de los Andes en Perú, sobre el valle del río Urubamba.',
    'Iquitos es una ciudad puerto peruana y una vía de acceso a los alojamientos en la selva y las villas del norte del Amazonas.',
    'Lunahuaná es una localidad peruana capital del distrito homónimo ubicado en la provincia de Cañete en el departamento de Lima.'
  ];
  var Images = ['assets/img1.jpg', 'assets/img2.jpg', 'assets/img3.jpg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Sitios Turisticos - Perú'),
      ),*/
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          //padding: const EdgeInsets.all(10.0),
          children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 520,
              scrollDirection: Axis.vertical
            ),
            items: Images
                .map((i) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          if (i == 'assets/img1.jpg')
                            Text(
                              "${Places[0]}",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          if (i == 'assets/img2.jpg')
                            Text(
                              "${Places[1]}",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          if (i == 'assets/img3.jpg')
                            Text(
                              "${Places[2]}",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          Image.asset(
                              i,
                            height: 270,
                          ),
                          SizedBox(height: 20),
                          if (i == 'assets/img1.jpg')
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: Text("${Desc[0]}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          if (i == 'assets/img2.jpg')
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: Text("${Desc[1]}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          if (i == 'assets/img3.jpg')
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: Text("${Desc[2]}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            }).toList(),
          ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Images.map((urlOfItem) {
                int index = Images.indexOf(urlOfItem);
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Color.fromRGBO(0, 0, 0, 0.8)
                        : Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                );
              }).toList(),
            )*/
          ],
        ),
      ),
    );
  }

}
