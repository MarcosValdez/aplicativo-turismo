import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var Places = ['Macchu Picchu', 'Iquitos', 'Lunahuana'];
  var Desc = [
    'Machu Picchu es una ciudadela inca ubicada en las alturas de las montañas de los Andes en Perú, sobre el valle del río Urubamba.',
    'Iquitos es una ciudad puerto peruana y una vía de acceso a los alojamientos en la selva y las villas del norte del Amazonas.',
    'Lunahuaná es una localidad peruana capital del distrito homónimo ubicado en la provincia de Cañete en el departamento de Lima.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sitios Turisticos - Perú'),
      ),
      backgroundColor: Colors.black87,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CarouselSlider(
            options: CarouselOptions(height: 520),
            items: ['assets/img1.jpg', 'assets/img2.jpg', 'assets/img3.jpg']
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
                                  fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white,),
                            ),
                          if (i == 'assets/img2.jpg')
                            Text(
                              "${Places[1]}",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white,),
                            ),
                          if (i == 'assets/img3.jpg')
                            Text(
                              "${Places[2]}",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white,),
                            ),
                          Image.asset(i),
                          SizedBox(height: 20),
                          if (i == 'assets/img1.jpg')
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: Text("${Desc[0]}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,),
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
                                      color: Colors.white,),
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
                                      color: Colors.white,),
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
        ),
      ),
    );
  }
}
