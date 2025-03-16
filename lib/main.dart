
import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:'/3' ,
      routes: {
        '/': (context) => firstPage(),
        '/homepage': (context) =>HomePage(),
        '/3' : (context) =>classInfo()
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
          elevation: 4,
          backgroundColor: Color(0xFF18185C),
          titleSpacing: 0,
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
      backgroundColor: Color(0xFFFFFFFF) ,
      body:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(
                    "Functionalities",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF18185C),
                    ),
                  ),
                // Espacement entre les deux textes
                SizedBox(width: 75),
                InkWell (
                  onTap: () {
                    print("Texte cliqué !");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(7.0), // Espacement interne autour du texte
                    child: Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
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
                          Icons.auto_stories_outlined,
                          color: Color(0xFF18185C), // Couleur de l'icône
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Create \n Class",
                      style: TextStyle(
                        fontSize: 20,
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
                      textAlign: TextAlign.center,
                      "Create \n group",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF18185C),
                      ),
                    ),
                  ],
                ),
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
                          Icons.person,
                          color: Color(0xFF18185C), // Couleur de l'icône
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Text(
                      "add new\n Student ",
                      textAlign: TextAlign.center,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Espacement externe avant le texte "Functionalities"
                Padding(
                  padding: EdgeInsets.all(8.0), // Espacement interne autour du texte
                  child: Text(
                    "My Class",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF18185C),
                    ),
                  ),
                ),
                // Espacement entre les deux textes
                SizedBox(width: 75),
                InkWell(
                  onTap: () {
                    print("Texte cliqué !");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(7.0), // Espacement interne autour du texte
                    child: Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                      childAspectRatio: 1/3,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(padding:  EdgeInsets.fromLTRB(5, 5, 2, 0),
                                    child:Text("Title.......",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),
                                    ),),
                                  IconButton(onPressed: (){},
                                      icon: Icon(Icons.border_color_outlined ,
                                        color: Color(0xFFFFFFFF),
                                      )
                                  )
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Level",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 16
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.delete_outline,
                                            color: Color(0xFFFFFFFF),
                                          )
                                      ),
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.comment_bank_outlined,
                                            color: Color(0xFFFFFFFF),
                                          )
                                      )


                                    ],
                                  )

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:Color(0xFF18185C),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(padding:  EdgeInsets.fromLTRB(5, 5, 2, 0),
                                    child:Text("Title.......",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),
                                    ),),
                                  IconButton(onPressed: (){},
                                      icon: Icon(Icons.border_color_outlined ,
                                        color: Color(0xFFFFFFFF),
                                      )
                                  )
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Level",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 16
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.delete_outline,
                                            color: Color(0xFFFFFFFF),
                                          )
                                      ),
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.comment_bank_outlined,
                                            color: Color(0xFFFFFFFF),
                                          )
                                      )


                                    ],
                                  )

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:Color(0xFF18185C) ,
                            width: 2.0,
                          ),
                        ),
                        child:Center(child:Column(
                          children: [
                            Padding(padding:EdgeInsets.all(8) ,child:  Icon(Icons.add_circle_outline ,
                              color: Color(0xFF18185C),
                              size: 40, ),),
                            Text("add a new class",
                              style: TextStyle(
                                  color: Color(0xFF18185C),
                                fontWeight: FontWeight.bold
                              ),)
                          ],
                        ) ,)
                      )
                    ],
                  ),
                )),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "My Groups",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF18185C),
                    ),
                  ),
                ),
                SizedBox(width: 75),
                InkWell(
                  onTap: () {
                    print("Texte cliqué !");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio:5/2 ,
                    ),
                    itemCount: 14,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF628ECB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'group n: $index',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      );
                    },
                  ),
                )),
      ])
    );
}
}

class classInfo extends StatefulWidget{
  _classInfo createState() =>  _classInfo();
}
class _classInfo extends State<classInfo>{
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [

          ],
        )
    );
  }
}