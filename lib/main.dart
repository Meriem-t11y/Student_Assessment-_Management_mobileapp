import 'dart:async';
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
          '/3' : (context) =>classInfo(),
          '/4' :(context) =>groupInfo(),
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
      numberController=TextEditingController(),
      nameContoller=TextEditingController(),
      finameContoller=TextEditingController(),
      fanameContoller=TextEditingController(),
      yearController=TextEditingController();
  int? group;
  String? level ,speciality;
  final _formKey = GlobalKey<FormState>();
  final dbc=Dtabase();
  List<Map<String, dynamic>> lclass = [];
  void initState(){
    super.initState();
    _loadClasses();
  }
  Future<void> _loadClasses() async {
    final db = Dtabase();
    final data = await db.getClasses();
    setState(() {
      lclass = data;
    });
  }

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
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: Color(0xFFB1C9EF)), // Icône de menu
              onPressed: () {
                // Action lors de l'appui sur l'icône
              },
            ),
          ],
        ),
        backgroundColor: Color(0xFFFFFFFE) ,
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
                                backgroundColor: Color(0xFFD5DEEF),
                                title: Text(
                                  'Enter Class Informations',
                                  style: TextStyle(color: Color(0xFF18185C)),
                                ),
                                content: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Class Name*',
                                            border: OutlineInputBorder(),
                                          ),
                                          controller: nameContoller,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "You must fill class name";
                                            }
                                            if(RegExp(r'^[a-z][A-Z]').hasMatch(value)){
                                              return "the class name should start with alphabet";
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 8),
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
                                          items: ['1', '2', '3']
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
                                            if(RegExp(r'\D').hasMatch(value)){
                                              return'the level should be a number';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 8),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Year*',
                                            border: OutlineInputBorder(),
                                          ),
                                          controller: yearController, // Utilisation du contrôleur
                                          onChanged: (value) {
                                            if (value == "2") {
                                              yearController.text = "2024-2025";
                                              yearController.selection = TextSelection.fromPosition(
                                                TextPosition(offset: yearController.text.length),
                                              );
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "You must fill year";
                                            }
                                            if(RegExp(r'[^a-z][A-Z]').hasMatch(value)){
                                              return "year not valid";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Annuler',
                                      style: TextStyle(color: Color(0xFF18185C)),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final dbc = Dtabase();
                                        bool success = await dbc.insertClass(
                                            nameContoller.text, speciality!, int.parse(level!), yearController.text);
                                        if (success) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('The class was created successfully!')),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Error: Failed to create class.')),
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Valider',
                                      style: TextStyle(color: Color(0xFF18185C)),
                                    ),
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
                            Icons.group_add_outlined,
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
                                          items: ['1', '2', '3']
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
                                          controller: numberController,
                                          decoration: InputDecoration(
                                            labelText: 'Number*',
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value){
                                            String number=value; },
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
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final dbc = Dtabase();
                                        bool success = await dbc.insertGroup(
                                            speciality!,
                                            int.parse(level!),
                                            int.parse(numberController.text !));
                                        if (success) {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                content: Text('The group was created successfully!')),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Error: Failed to create class.')),
                                          );
                                        }
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
                            Icons.person_add_alt,
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
                                            controller:fanameContoller ,
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
                                            controller:finameContoller ,
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
                                              group=int.parse(value!);
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
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final dbc = Dtabase();
                                          bool success = await dbc.insertStudent(finameContoller.text,
                                              fanameContoller.text,
                                              speciality!,
                                              int.parse(level!),
                                              group!);
                                          if (success) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('The group was created successfully!')),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Error: Failed to create class.')),
                                            );
                                          }
                                        }
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
                    padding: EdgeInsets.all(8.0),
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
                      Navigator.pushNamed(context as BuildContext, '/3');
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
            child: lclass.isEmpty
                ? Center(child: Text('add classe '))
            :GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                childAspectRatio: 1 / 2.5,
              ),
              itemCount: lclass.length,
              itemBuilder: (context, index) {
                final item = lclass[index];
                return Container(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.blueAccent : Color(0xFF18185C),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 2, 0),
                              child: Text(
                                item['title']!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.border_color_outlined,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['level']!,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Other",
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
                      Navigator.pushNamed(context as BuildContext, '/4');
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
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
                              Icons.group_outlined,
                              color: Color(0xFF18185C),
                            ),
                            onPressed: (){

                            },
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "See all group",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF18185C),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ])
    );
  }
}

class classInfo extends StatefulWidget{
  _classInfo createState() =>  _classInfo();
}
class _classInfo extends State<classInfo> {
  TextEditingController searchController = TextEditingController();
  final dbc = Dtabase();
  List<Map<String, dynamic>> filteredClasses = [];
  List<Map<String, dynamic>> lclass = [];
  String selectedFilter = 'None'; // Nouveau filtre pour stocker la sélection

  @override
  void initState() {
    super.initState();
    _loadClasses();
    searchController.addListener(_searchClasses); // Appeler uniquement la recherche
  }

  Future<void> _loadClasses() async {
    final db = Dtabase();
    final data = await db.getClasses();
    setState(() {
      lclass = List.from(data);
      filteredClasses = data;
    });
  }

  void _showDeleteDialog(BuildContext context, int cid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Class"),
          content: Text("Are you sure you want to delete this class?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () async {
                try {
                  final db = Dtabase();
                  await db.deleteClass(cid);
                  setState(() {
                    lclass = List.from(lclass)..removeWhere((classe) => classe['cid'] == cid);
                    _filterClasses();  // Reappliquer le filtre après suppression
                  });
                } catch (e) {
                  print("Error: $e");
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(BuildContext context, Map<String, dynamic> classe) {
    TextEditingController nameController = TextEditingController(text: classe['name']);
    TextEditingController specialityController = TextEditingController(text: classe['speciality']);
    TextEditingController levelController = TextEditingController(text: classe['level'].toString());
    TextEditingController yearController = TextEditingController(text: classe['year'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Class"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: specialityController,
                decoration: InputDecoration(labelText: "Speciality"),
              ),
              TextField(
                controller: levelController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Level"),
              ),
              TextField(
                controller: yearController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Year"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Update", style: TextStyle(color: Colors.green)),
              onPressed: () async {
                final db = Dtabase();
                await db.updateClass(
                  classe['cid'],
                  nameController.text,
                  specialityController.text,
                  int.parse(levelController.text),
                  yearController.text,
                );
                _loadClasses(); // Recharger la liste après la mise à jour
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Fonction de recherche (séparée du filtre)
  void _searchClasses() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredClasses = lclass.where((classe) {
        return classe['name'].toLowerCase().contains(query) ||
            classe['speciality'].toLowerCase().contains(query) ||
            classe['level'].toString().contains(query);
      }).toList();
    });
  }

  // Fonction de filtre (séparée de la recherche)
  void _filterClasses() {
    setState(() {
      if (selectedFilter == 'None') {
        filteredClasses = lclass; // Aucun filtre
      } else if (selectedFilter == 'name') {
        filteredClasses = lclass..sort((a, b) => a['name'].compareTo(b['name']));
      } else if (selectedFilter == 'level') {
        filteredClasses = lclass..sort((a, b) => a['level'].compareTo(b['level']));
      } else if (selectedFilter == 'speciality') {
        filteredClasses = lclass..sort((a, b) => a['speciality'].compareTo(b['speciality']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color(0xFF18185C),
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.assignment,
            color: Color(0xFFB1C9EF),
            size: 28,
          ),
        ),
        title: Text(
          "MY CLASSES",
          style: TextStyle(color: Color(0xFFB1C9EF), fontSize: 14),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF2E2E6E),
                    content: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2E2E6E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Color(0xFFB1C9EF)),
                          prefixIcon: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.search),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.filter_list,
              color: Color(0xFFB1C9EF),
            ),
            onSelected: (value) {
              setState(() {
                selectedFilter = value;  // Mise à jour du filtre sélectionné
              });
              _filterClasses();  // Appliquer immédiatement le filtre
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'None',
                child: Text('No Filter'),
              ),
              PopupMenuItem(
                value: 'name',
                child: Text('Filter by Name'),
              ),
              PopupMenuItem(
                value: 'level',
                child: Text('Filter by Level'),
              ),
              PopupMenuItem(
                value: 'speciality',
                child: Text('Filter by Speciality'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 4 / 2,
          ),
          itemCount: filteredClasses.length,
          itemBuilder: (context, index) {
            final classe = filteredClasses[index];
            return Card(
              color: index.isEven ? Colors.blueAccent : Color(0xFF18185C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name: ${classe['name']}',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFB1C9EF)),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Color(0xFFB1C9EF)),
                              onPressed: () {
                                _showUpdateDialog(context, classe);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _showDeleteDialog(context, classe['cid']);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text('Speciality: ${classe['speciality']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Level: ${classe['level']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Year: ${classe['year']}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class groupInfo extends StatefulWidget{
  _groupInfo createState() =>  _groupInfo();
}
class _groupInfo extends State<groupInfo> {
  TextEditingController searchController = TextEditingController();
  final dbc = Dtabase();
  List<Map<String, dynamic>> Lclass = [];
  List<Map<String, dynamic>> filteredClasses = [];

  @override
  void initState() {
    super.initState();
    loadClasses();
    searchController.addListener(_searchClasses); // Ajout du listener pour la recherche
  }

  // Charger les classes depuis la base de données
  Future<void> loadClasses() async {
    final groups = await dbc.getGroup();
    setState(() {
      Lclass = groups;
      filteredClasses = groups; // Initialiser la liste filtrée avec toutes les classes au début
    });
  }

  // Fonction de recherche
  void _searchClasses() {
    String query = searchController.text.toLowerCase();
    setState(() {
      // Filtrer en fonction du texte saisi dans le champ de recherche
      filteredClasses = Lclass.where((classe) {
        return classe['speciality'].toLowerCase().contains(query) ||
            classe['level'].toString().contains(query);
      }).toList();
    });
  }


  void _applyFilter(String filter) {
    setState(() {
      if (filter == 'Speciality') {
        filteredClasses.sort((a, b) => a['speciality'].compareTo(b['speciality']));
      } else if (filter == 'level') {
        filteredClasses.sort((a, b) => a['level'].compareTo(b['level']));
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text("MY GROUPS", style: TextStyle(color: Color(0xFFB1C9EF), fontSize: 16, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF2E2E6E),
                    content: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2E2E6E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search by level or speciality...',
                          hintStyle: TextStyle(color: Color(0xFFB1C9EF)),
                          prefixIcon: Icon(Icons.search, color: Color(0xFFB1C9EF)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: Color(0xFFB1C9EF)),
            onSelected: _applyFilter, // Applique le filtre sélectionné
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Speciality',
                child: Text('Filter by Speciality'),
              ),
              PopupMenuItem(
                value: 'level',
                child: Text('Filter by Level'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.2,
          ),
          itemCount: filteredClasses.length, // Utilisation de filteredClasses pour afficher les éléments filtrés
          itemBuilder: (context, index) {
            final classe = filteredClasses[index];
            return GestureDetector(
                onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) =>student(groupId: filteredClasses[index])));


            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Speciality: ${classe['speciality']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Level: ${classe['level']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Number: ${classe['number']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
class student extends StatefulWidget{
  final Map<String, dynamic> groupId;
  student({Key? key, required this.groupId}) : super(key: key);
  _studentList createState()=> _studentList(groupId: groupId);

}
class _studentList extends State<student> {
  final Map<String, dynamic> groupId;
  _studentList({Key? key, required this.groupId});
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> students = [];
  List<Map<String, dynamic>> filteredStudents = [];

  Future<void> loadStudents() async {
    final db=Dtabase();
    final studentsList = await db.getStudentsByGroup(groupId['gid']);
    setState(() {
      students = studentsList;
      filteredStudents = students;
    });
  }

  // Fonction pour rechercher les étudiants
  void _searchStudents() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredStudents = students.where((student) {
        return student['speciality'].toLowerCase().contains(query) ||
            student['level'].toString().contains(query);
      }).toList();
    });
  }

  // Fonction de filtre pour trier par spécialité ou niveau
  void _applyFilter(String filter) {
    setState(() {
      if (filter == 'Speciality') {
        filteredStudents.sort((a, b) => a['speciality'].compareTo(b['speciality']));
      } else if (filter == 'level') {
        filteredStudents.sort((a, b) => a['level'].compareTo(b['level']));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadStudents();
    searchController.addListener(_searchStudents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color(0xFF18185C),
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.assignment,
            color: Color(0xFFB1C9EF),
            size: 28,
          ),
        ),
        title: Text(
          "MY GROUPS",
          style: TextStyle(color: Color(0xFFB1C9EF), fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF2E2E6E),
                    content: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2E2E6E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search by level or speciality...',
                          hintStyle: TextStyle(color: Color(0xFFB1C9EF)),
                          prefixIcon: Icon(Icons.search, color: Color(0xFFB1C9EF)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: Color(0xFFB1C9EF)),
            onSelected: _applyFilter,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Speciality',
                child: Text('Filter by Speciality'),
              ),
              PopupMenuItem(
                value: 'level',
                child: Text('Filter by Level'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredStudents.length,
        itemBuilder: (context, index) {
          final student = filteredStudents[index];
          return ListTile(
            leading: Icon(Icons.person),
            title: Text('${student['finame']} ${student['famname']}'),
            subtitle: Text('Speciality: ${student['speciality']} | Level: ${student['level']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Code pour mettre à jour l'étudiant
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Code pour supprimer l'étudiant
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Dtabase {
  static final Dtabase _instance = Dtabase._internal();

  factory Dtabase() => _instance;

  Dtabase._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'db3.db');
    return await openDatabase(
      path,
      version: 4,
      onCreate: (Database db, int version) async {
        // Table "class"
        await db.execute(
            'CREATE TABLE class ('
                'cid INTEGER PRIMARY KEY AUTOINCREMENT, '
                'name TEXT NOT NULL, '
                'speciality TEXT NOT NULL, '
                'level INTEGER NOT NULL, '
                'year TEXT NOT NULL ,'
                'commant Text '
                ')'
        );

        await db.execute(
            'CREATE TABLE "group" ('
                'gid INTEGER PRIMARY KEY AUTOINCREMENT, '
                'number INTEGER, '
                'speciality TEXT NOT NULL, '
                'level INTEGER NOT NULL'
                ')'
        );


        await db.execute(
            'CREATE TABLE student ('
                'sid INTEGER PRIMARY KEY AUTOINCREMENT, '
                'finame TEXT NOT NULL, '
                'famname TEXT NOT NULL, '
                'speciality TEXT NOT NULL, '
                'level INTEGER NOT NULL, '
                'group_id INTEGER NOT NULL, '
                'FOREIGN KEY(group_id) REFERENCES "group"(gid)'
                ')'
        );

      },
    );
  }

  Future<bool> insertClass(String name, String speciality, int level,
      String year) async {
    try {
      final db = await database;
      await db.insert(
        'class',
        {
          'name': name,
          'speciality': speciality,
          'level': level,
          'year': year,
        },
       );
      return true;
    } catch (e) {
      print('Erreur lors dinsertion de la classe : $e');
      return false;
    }
  }

  // Insert group
  Future<bool> insertGroup(String speciality, int level, int number) async {
    try {
      final db = await database;
      await db.insert(
        'group',
        {
          'number': number,
          'speciality': speciality,
          'level': level ,
        },
      );
      return true;
    } catch (e) {
      print('Erreur lors de l\'insertion du groupe : $e');
      return false;
    }
  }

  // Insert student
  Future<bool> insertStudent(String finame,
      String famname, String speciality,
      int level, int group) async {
    try {
      final db = await database;
      await db.insert(
        'student',
        {
          'finame': finame,
          'famname': famname,
          'speciality': speciality,
          'level': level,
          'group_id': group,
        },
      );
      return true;
    } catch (e) {
      print('Erreur lors de l\'insertion de l\'étudiant : $e');
      return false;
    }
  }

  // Get classes
  Future<List<Map<String, dynamic>>> getClasses() async {
    final db = await database;
    return await db.query('class');
  }

  // Get groups
  Future<List<Map<String, dynamic>>> getGroup() async {
    final db = await database;
    return await db.query('group');
  }


  // Delete class
  Future<void> deleteClass(int cid) async {
    final db = await database;
    await db.delete(
      'class',
      where: 'cid = ?',
      whereArgs: [cid],
    );
  }

  // Delete group
  Future<void> deleteGroup(int gid, String speciality, int level) async {
    final db = await database;
    await db.delete(
      'group_table',
      where: 'gid = ? AND speciality = ? AND level = ?',
      whereArgs: [gid, speciality, level],
    );
  }

  // Delete student
  Future<void> deleteStudent(String finame, String famname, int groupId,
      String speciality) async {
    final db = await database;
    await db.delete(
      'student',
      where: 'finame = ? AND famname = ? AND group_id = ? AND speciality = ?',
      whereArgs: [finame, famname, groupId, speciality],
    );
  }

  Future<void> updateClass(int cid, String name, String speciality, int level,
      String year) async {
    final db = await database;
    await db.update(
      'class',
      {
        'name': name,
        'speciality': speciality,
        'level': level,
        'year': year,
      },
      where: 'cid = ?',
      whereArgs: [cid],
    );
  }

  Future<List<Map<String, dynamic>>> getStudentsByGroup(int groupId) async {
    final db = await database;
    return await db.query(
      'student',
      where: 'group_id = ?',
      whereArgs: [groupId],
    );
  }

}