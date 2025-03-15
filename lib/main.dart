
import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:'/splash' ,
      routes: {
        '/': (context) => HomePage(),
        '/splash': (context) => firstPage(),
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
      Navigator.pushNamed(context, '/');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Image.asset("img/img3.png"),
    );
  }
}
class HomePage extends StatefulWidget{
  _homePageState createState() => _homePageState();
}
class _homePageState extends State<HomePage>{

  TextEditingController searchcontroller=TextEditingController();
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 100,
        elevation: 4,
        backgroundColor: Color(0xFF18185C),
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.border_color_outlined,
            color: Color(0xFFB1C9EF),
            size: 28,
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: Color(0xFF2E2E6E),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: searchcontroller,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Color(0xFFB1C9EF)),
              prefixIcon: Icon(Icons.search, color: Color(0xFFB1C9EF)),
              border: InputBorder.none, // Pas de bordure
              contentPadding: EdgeInsets.all(12), // Espacement intérieur
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Color(0xFFB1C9EF)),
            onPressed: () {
            },
          ),
        ],
      ),

      backgroundColor:  Color(0xFFB1C9EF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
            Text("Functionalities",
              textAlign: TextAlign.start,
              style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF18185C),
              ),
            ),
            Text("see all",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 15,
                    decoration: TextDecoration.underline,
                  color: Color(0xFF18185C),
                ),
              )]
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF628ECB),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        iconSize: 30, // Taille de l'icône
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Color(0xFF18185C), // Couleur de l'icône
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Text(
                      "Create \n Class",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF18185C),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF628ECB),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        iconSize: 30,
                        icon: Icon(
                          Icons.groups_outlined,
                          color: Color(0xFF18185C),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Text(
                      "Create \n group",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF18185C),
                      ),
                    ),
                  ],
            ),
        ],
      ),

      ]
    ));
  }
}