import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:'/' ,
      routes: {
        '/1h': (context) => firstPage(),
        '/': (context) =>HomePage(),
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
      Navigator.pushNamed(context as BuildContext, '/');
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
  TextEditingController searchcontroller=TextEditingController() ,
      nameContoller=TextEditingController(),
      yearController=TextEditingController();
  String? level ,speciality;
  final _formKey = GlobalKey<FormState>();
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
              Icons.assignment,
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
                        iconSize: 30,
                        icon: Icon(
                          Icons.auto_stories_outlined,
                          color: Color(0xFF18185C),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Color(0xFFD5DEEF ),
                                title: Text('Enter Class Informations ',style: TextStyle(color:Color(0xFF18185C) ),),
                                content: SingleChildScrollView( // Pour éviter le débordement
                                  child: Form(
                                    key:_formKey ,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Class Name*',
                                            border: OutlineInputBorder(),
                                          ),
                                          controller:nameContoller ,
                                          validator: (value){
                                            if(value==null|| value.isEmpty){
                                              return "you must fill class name";
                                            }
                                          },
                                        ),
                                        SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Speciality',
                                            border: OutlineInputBorder(),
                                          ),
                                          items: ['Engineer', 'Licence', 'Master'].
                                          map((String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          )).toList(),
                                          onChanged: (value) {
                                            speciality=value;
                                          },
                                          validator: (value){
                                            if( value==null || value.isEmpty){
                                              return " you must fill level";
                                            }
                                          },
                                        ),
                                        SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Level',
                                            border: OutlineInputBorder(),
                                          ),
                                          items: ['1st ', '2nd', '3rd']
                                              .map((String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          )
                                          ).toList(),
                                          onChanged: (value) {
                                            level=value;
                                          },
                                          validator: (value){
                                            if( value==null || value.isEmpty){
                                              return " you must fill level";
                                            }
                                          },
                                        ),
                                        SizedBox(height: 8),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Year*',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value){
                                            if(value==null|| value.isEmpty){
                                              return "you must fill year";
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Annuler' ,style: TextStyle(color : Color(0xFF18185C))),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if(_formKey.currentState!.validate()){
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('The class was create seccefully!')),
                                        );}
                                    },
                                    child: Text('Valider',style: TextStyle(color : Color(0xFF18185C))),
                                    style: ElevatedButton.styleFrom(
                                       backgroundColor: Color(0xFFB1C9EF),
                                    ),
                                  ),
                                ],
                              )
                          );
                        },
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Create \n Class",
                      style: TextStyle(
                        fontSize: 17,
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Color(0xFFD5DEEF),
                              title: Text(
                                'Enter group Informations',
                                style: TextStyle(color: Color(0xFF18185C)),
                              ),
                              content: SingleChildScrollView(
                                // Pour éviter le débordement
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: 'Speciality',
                                          border: OutlineInputBorder(),
                                        ),
                                        items: ['Engineer', 'Licence', 'Master']
                                            .map((String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                            .toList(),
                                        onChanged: (value) {
                                          speciality = value;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "You must fill speciality";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 8),
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: 'Level',
                                          border: OutlineInputBorder(),
                                        ),
                                        items: ['1st', '2nd', '3rd']
                                            .map((String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                            .toList(),
                                        onChanged: (value) {
                                          level = value;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "You must fill level";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 8),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Number*',
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "You must fill number";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 8),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          try {
                                            // Ouvrir le sélecteur de fichier
                                            final result = await FilePicker.platform.pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: ['csv','pdf'],
                                            );

                                            if (result != null && result.files.isNotEmpty) {
                                              String? filePath = result.files.single.path;
                                              if (filePath != null) {

                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('CSV file uploaded successfully!')),
                                                );
                                              }
                                            } else {
                                              print("Aucun fichier sélectionné.");
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('No file selected.')),
                                              );
                                            }
                                          } catch (e) {
                                            print("Erreur lors de la sélection du fichier : $e");
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Erreur lors du téléchargement du fichier.')),
                                            );
                                          }
                                        },

                                        icon: Icon(Icons.upload_file),
                                          label: Text("Upload list student"),
                                          style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFB1C9EF),
                                    ),
                                  ),
                                      SizedBox(height: 8),

                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Annuler', style: TextStyle(color: Color(0xFF18185C))),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('The group was created successfully!')),
                                      );
                                    }
                                  },
                                  child: Text('Valider', style: TextStyle(color: Color(0xFF18185C))),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFB1C9EF),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Create \n group",
                      style: TextStyle(
                        fontSize: 17,
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
                        iconSize: 30,
                        icon: Icon(
                          Icons.person,
                          color: Color(0xFF18185C),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Color(0xFFD5DEEF ),
                                title: Text('Enter student Informations ',style: TextStyle(color:Color(0xFF18185C) ),),
                                content: SingleChildScrollView(
                                  child: Form(
                                    key:_formKey ,
                                    child: Column(
                                       mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Familly Name*',
                                            border: OutlineInputBorder(),
                                          ),
                                          controller:nameContoller ,
                                          validator: (value){
                                            if(value==null|| value.isEmpty){
                                              return "you must fill student Familly name";
                                            }
                                          },
                                        ),
                                        SizedBox(height: 8),
                                         TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'First Name*',
                                            border: OutlineInputBorder(),
                                          ),
                                          controller:nameContoller ,
                                          validator: (value){
                                            if(value==null|| value.isEmpty){
                                              return "you must fill student first name";
                                            }
                                          },
                                        ),
                                        SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Speciality',
                                            border: OutlineInputBorder(),
                                          ),
                                          items: ['Engineer', 'Licence', 'Master'].
                                          map((String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          )).toList(),
                                          onChanged: (value) {
                                            speciality=value;
                                          },
                                          validator: (value){
                                            if( value==null || value.isEmpty){
                                              return " you must fill speciality";
                                            }
                                          },
                                        ),
                                        SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Level',
                                            border: OutlineInputBorder(),
                                          ),
                                          items: ['1st ', '2nd', '3rd']
                                              .map((String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          )
                                          ).toList(),
                                          onChanged: (value) {
                                            level=value;
                                          },
                                          validator: (value){
                                            if( value==null || value.isEmpty){
                                              return " you must fill level";
                                            }
                                          },
                                        ),
                                        SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Group number',
                                            border: OutlineInputBorder(),
                                          ),
                                          items: ['1 ', '2', '3']
                                              .map((String value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          )
                                          ).toList(),
                                          onChanged: (value) {
                                            level=value;
                                          },
                                          validator: (value){
                                            if( value==null || value.isEmpty){
                                              return " you must fill group number";
                                            }
                                          },
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Annuler' ,style: TextStyle(color : Color(0xFF18185C))),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if(_formKey.currentState!.validate()){
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('The class was create seccefully!')),
                                        );}
                                    },
                                    child: Text('Valider',style: TextStyle(color : Color(0xFF18185C))),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFB1C9EF),
                                    ),
                                  ),
                                ],
                              )
                          );
                        },
                      ),
                    ),
                    Text(
                      "add \nStudents ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
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
                    child: Icon(Icons.last_page , color: Colors.blue,),
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
                            Padding(padding:EdgeInsets.all(8) ,child:  IconButton(icon :Icon(Icons.add_circle_outline ,size: 35, ),
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Color(0xFFD5DEEF ),
                                      title: Text('Enter Class Informations ',style: TextStyle(color:Color(0xFF18185C) ),),
                                      content: SingleChildScrollView( // Pour éviter le débordement
                                        child: Form(
                                          key:_formKey ,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Class Name*',
                                                  border: OutlineInputBorder(),
                                                ),
                                                controller:nameContoller ,
                                                validator: (value){
                                                  if(value==null|| value.isEmpty){
                                                    return "you must fill class name";
                                                  }
                                                },
                                              ),
                                              SizedBox(height: 8),
                                              DropdownButtonFormField<String>(
                                                decoration: InputDecoration(
                                                  labelText: 'Speciality',
                                                  border: OutlineInputBorder(),
                                                ),
                                                items: ['Engineer', 'Licence', 'Master'].
                                                map((String value) => DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                )).toList(),
                                                onChanged: (value) {
                                                  speciality=value;
                                                },
                                                validator: (value){
                                                  if( value==null || value.isEmpty){
                                                    return " you must fill level";
                                                  }
                                                },
                                              ),
                                              SizedBox(height: 8),
                                              DropdownButtonFormField<String>(
                                                decoration: InputDecoration(
                                                  labelText: 'Level',
                                                  border: OutlineInputBorder(),
                                                ),
                                                items: ['1st ', '2nd', '3rd']
                                                    .map((String value) => DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                )
                                                ).toList(),
                                                onChanged: (value) {
                                                  level=value;
                                                },
                                                validator: (value){
                                                  if( value==null || value.isEmpty){
                                                    return " you must fill level";
                                                  }
                                                },
                                              ),
                                              SizedBox(height: 8),
                                              TextFormField(
                                                decoration: InputDecoration(
                                                  labelText: 'Year*',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value){
                                                  if(value==null|| value.isEmpty){
                                                    return "you must fill year";
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Annuler' ,style: TextStyle(color : Color(0xFF18185C))),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if(_formKey.currentState!.validate()){
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('The class was create seccefully!')),
                                              );}
                                          },
                                          child: Text('Valider',style: TextStyle(color : Color(0xFF18185C))),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFB1C9EF),
                                          ),
                                        ),
                                      ],
                                    )
                                );

                              },
                              color: Color(0xFF18185C),
                               ),),
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
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                      childAspectRatio:3/4 ,
                    ),
                    itemCount: 14,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: ((index+1) % 2== 0)? Color(0xFF151567) :((index+1) % 3== 0)?
                          Colors.blueAccent:Color(0xFF628ECB),
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
      appBar: AppBar(
        title: Text("My class"),
      ),
        body:Form(child: Column(
          children: [


          ],
        ))
    );
  }
}
class ClassDatabase{
  static final ClassDatabase _instance = ClassDatabase._internal();
  factory ClassDatabase() => _instance;
  ClassDatabase._internal();
  Database ? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  Future<Database> _initDatabase() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'p.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE class (cid INTEGER PRIMARY KEY AUTOINCREMENT ,'
                  'name TEXT NOT NULL,'
                  'speciality TEXT NOT NULL,'
                  'level TEXT NOT NULL,'
                  'year TEXT NOT NULL,'
              ')'
          );
          await db.execute(
              'CREATE TABLE group (gid INTEGER PRIMARY KEY AUTOINCREMENT ,'
                  'number INTEGER NOT NULL,'
                  'speciality TEXT NOT NULL,'
                  'level TEXT NOT NULL,'
              ')'
          );

        }
    );
  }
}

