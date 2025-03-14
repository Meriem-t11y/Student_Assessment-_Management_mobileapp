
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:'/' ,
      routes: {
        '/': (context) => firstPage(),
      },
    )
  );
}

class firstPage extends StatelessWidget{
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Image.asset('img/img2.png' ),
            Container(
              child:
                ElevatedButton(onPressed: (){}, child: Text("Next"))
            )
          ],
        ),
    );
    }
  }