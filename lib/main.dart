
import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:'/' ,
      routes: {
        '/': (context) => firstPage(),
        '/homepage': (context) =>HomePage(),
      },
    )
  );
}

class firstPage extends StatefulWidget{

  firstPageState createState() => firstPageState();
}
class firstPageState extends State<firstPage> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/homepage');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('img/img3.png'),

        ],
      ),
    );
  }
}
class HomePage extends StatefulWidget{
  _homePage createState() => _homePage();

}
class _homePage extends State<HomePage>{
  TextEditingController searchcontroller=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        AppBar(
          elevation: 4, // Ombre pour un effet d'élévation
          backgroundColor: Color(0xFF18185C), // Couleur de fond sombre
          titleSpacing: 0, // Pour que le champ de recherche soit collé à l'icône
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.border_color_outlined,
              color: Color(0xFFB1C9EF),
              size: 28, // Agrandir l'icône
            ),
          ),
          title: Container(
            decoration: BoxDecoration(
              color: Color(0xFF2E2E6E), // Fond plus clair pour le champ
              borderRadius: BorderRadius.circular(20), // Coins arrondis
            ),
            child: TextField(
              controller: searchcontroller,
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white), // Couleur du texte de recherche
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Color(0xFFB1C9EF)), // Couleur du texte d'indice
                prefixIcon: Icon(Icons.search, color: Color(0xFFB1C9EF)), // Icône de recherche
                border: InputBorder.none, // Pas de bordure
                contentPadding: EdgeInsets.all(12), // Espacement intérieur
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: Color(0xFFB1C9EF)), // Icône de menu
              onPressed: () {
                // Action lors de l'appui sur l'icône
              },
            ),
          ],
        ),
    );
}
}