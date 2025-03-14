
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
      body:
      Image.asset("img/img3.png"),
    );
  }
}
class HomePage extends StatefulWidget{
  _homePageState createState() => _homePageState();
}
class _homePageState extends State<HomePage>{
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('img/img2.png'),
          Container(
              child:
              ElevatedButton(onPressed: () {}, child: Text("Next"))
          )
        ],
      ),
    );
  }
}