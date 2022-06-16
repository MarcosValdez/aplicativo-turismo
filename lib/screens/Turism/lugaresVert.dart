import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imagesList = [
  'https://cdn.pixabay.com/photo/2020/11/01/23/22/breakfast-5705180_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/11/18/19/00/breads-1836411_1280.jpg',
  'https://cdn.pixabay.com/photo/2019/01/14/17/25/gelato-3932596_1280.jpg',
  'https://cdn.pixabay.com/photo/2017/04/04/18/07/ice-cream-2202561_1280.jpg',
];

final List<String> images =  ['assets/img1.jpg', 'assets/img2.jpg', 'assets/img3.jpg'];

final List<String> titles = [
  ' Coffee ',
  ' Bread ',
  ' Gelato ',
  ' Ice Cream ',
];

final List<String> Places = ['Macchu Picchu', 'Iquitos', 'Lunahuana'];
final List<String> Desc = [
  'Machu Picchu es una ciudadela inca ubicada en las alturas de las montañas de los Andes en Perú, sobre el valle del río Urubamba.',
  'Iquitos es una ciudad puerto peruana y una vía de acceso a los alojamientos en la selva y las villas del norte del Amazonas.',
  'Lunahuaná es una localidad peruana capital del distrito homónimo ubicado en la provincia de Cañete en el departamento de Lima.'
];
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: lugarTuristicoVert(),
  ));
}
class lugarTuristicoVert extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<lugarTuristicoVert> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Destinos turísticos'),
        ),
        backgroundColor: Colors.black87,
        body: CarouselSlider(
          options: CarouselOptions(
            height: 700,
            autoPlay: true,
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
            onPageChanged: (index, reason) {
              setState(
                    () {
                  _currentIndex = index;
                },
              );
            },
          ),
          items: images
              .map(
                (item) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                elevation: 6.0,
                shadowColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item),
                      Center(
                        child: Text(
                          '${Places[_currentIndex]}',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black45,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}