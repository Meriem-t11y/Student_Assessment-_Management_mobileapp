import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:excel/excel.dart';


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
      String ?type;
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
          elevation: 6,
          backgroundColor: Color(0xFF18185C),
          titleSpacing: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.class_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF18185C), Color(0xFF3E4DB5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFFFFFFFE) ,
        body :Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 4/2,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    InkWell(
                      onTap: () {
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
                                  child: Text('Valider',
                                    style: TextStyle(color: Color(0xFF18185C)),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFB1C9EF),
                                  ),
                                ),
                              ],
                            )
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple.shade300, Colors.blue.shade600],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 15.0,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.chalkboardTeacher, size: 40.0, color: Colors.white),
                            SizedBox(height: 10.0),
                            Text(
                              "Create Class",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Color(0xFFD5DEEF),
                            title: Text(
                              'Enter group Informations',
                              style: TextStyle(color: Color(0xFF18185C)),
                            ),
                            content: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Speciality Dropdown
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

                                    // Level Dropdown
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

                                    // Number Field
                                    TextFormField(
                                      controller: numberController,
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
                                      int.parse(numberController.text),'td'
                                    );
                                    if (success) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('The group was created successfully!')),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error: Failed to create group.')),
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
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.teal.shade300, Colors.green.shade600],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 15.0,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.users, size: 40.0, color: Colors.white),
                            SizedBox(height: 10.0),
                            Text(
                              "Create Group",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Color(0xFFD5DEEF ),
                              title: Text('Enter student Informations ',style: TextStyle(color:Color(0xFF18185C) ),),
                              content: SingleChildScrollView(
                                child: Form(
                                  key:_formKey ,
                                  child: Column(
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
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange.shade300, Colors.red.shade600],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 15.0,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.userGraduate, size: 40.0, color: Colors.white),
                            SizedBox(height: 10.0),
                            Text(
                              "Add Student",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context as BuildContext, '/3');
                        print("Texte cliqué !");
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue.shade400, Colors.cyan.shade700],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 15.0,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.bookOpen, size: 40.0, color: Colors.white),
                            SizedBox(height: 10.0),
                            Text(
                              "See All Classes",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context as BuildContext, '/4');
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.green.shade300, Colors.green.shade700],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 15.0,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.peopleGroup, size: 40.0, color: Colors.white),
                            SizedBox(height: 10.0),
                            Text(
                              "See All Groups",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(

                      onTap: () async {
                          try{
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

                            final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['csv', 'pdf', 'xlsx'],
                            );

                            if (result != null && result.files.isNotEmpty) {
                            String? filePath = result.files.single.path;
                            if (filePath != null) {
                            var bytes = File(filePath).readAsBytesSync();
                            var excel = Excel.decodeBytes(bytes);

                            List<Map<String, String>> students = [];

                            for (var table in excel.tables.keys) {
                            List<Data?> headers = excel.tables[table]!.rows.first;

                            for (int i = 1; i < excel.tables[table]!.rows.length; i++) {
                            var row = excel.tables[table]!.rows[i];


                            String num= row[0]?.value.toString() ?? '';
                            String nom= row[1]?.value.toString() ?? '';
                            String prenom= row[2]?.value.toString() ?? '';
                            final db=Dtabase();

                            }
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${students.length} étudiants importés avec succès.')),
                            );
                            print(students);
                            }
                            } else {
                            print("Aucun fichier sélectionné.");
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Aucun fichier sélectionné.')),
                            );
                            }


                            }

                            ,icon: Icon(Icons.upload_file),
                          label: Text("Upload list student"),
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB1C9EF),
                          ),
                          ),
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                          labelText: 'Level',
                          border: OutlineInputBorder(),
                          ),
                          items: ['tp', 'td']
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
                          int.parse(numberController.text !),'td');
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
                          }catch(e) {print("sd");}
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.green.shade300, Colors.green.shade700],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 15.0,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.peopleGroup, size: 40.0, color: Colors.white),
                            SizedBox(height: 10.0),
                            Text(
                              "Add student from file",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
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
  String selectedFilter = 'None';

  @override
  void initState() {
    super.initState();
    _loadClasses();
    searchController.addListener(_searchClasses);
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
          title: Text("Delete Class", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Text("Are you sure you want to delete this class?", style: TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () async {
                final db = Dtabase();
                await db.deleteClass(cid);
                setState(() {
                  lclass = List.from(lclass)..removeWhere((classe) => classe['cid'] == cid);
                  _filterClasses();
                });
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
          title: Text("Update Class", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name", labelStyle: TextStyle(fontSize: 16)),
              ),
              TextField(
                controller: specialityController,
                decoration: InputDecoration(labelText: "Speciality", labelStyle: TextStyle(fontSize: 16)),
              ),
              TextField(
                controller: levelController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Level", labelStyle: TextStyle(fontSize: 16)),
              ),
              TextField(
                controller: yearController,
                decoration: InputDecoration(labelText: "Year", labelStyle: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.blue)),
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
                _loadClasses();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Recherche par nom, spécialité, niveau ou année
  void _searchClasses() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredClasses = lclass.where((classe) {
        return classe['name'].toLowerCase().contains(query) ||
            classe['speciality'].toLowerCase().contains(query) ||
            classe['level'].toString().contains(query) ||
            classe['year'].toString().contains(query);  // Recherche par année
      }).toList();
    });
  }

  void _filterClasses() {
    setState(() {
      if (selectedFilter == 'None') {
        filteredClasses = lclass;
      } else if (selectedFilter == 'name') {
        filteredClasses = lclass..sort((a, b) => a['name'].compareTo(b['name']));
      } else if (selectedFilter == 'level') {
        filteredClasses = lclass..sort((a, b) => a['level'].compareTo(b['level']));
      } else if (selectedFilter == 'speciality') {
        filteredClasses = lclass..sort((a, b) => a['speciality'].compareTo(b['speciality']));
      } else if (selectedFilter == 'year') {  // Tri par année
        filteredClasses = lclass..sort((a, b) => a['year'].compareTo(b['year']));
      }
    });
  }
  void _associateGroupToClass(BuildContext context, Map<String, dynamic> classe) async {
    // Récupère les groupes disponibles dans la base de données
    final groups = await Dtabase().getGroup(); // Récupère la liste des groupes
    int? selectedGroupId;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Associer la classe '${classe['name']}' à un groupe"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<int>(
                    isExpanded: true,
                    hint: Text("Choisir un groupe"),
                    value: selectedGroupId,
                    items: groups.map<DropdownMenuItem<int>>((group) {
                      return DropdownMenuItem<int>(
                        value: group['gid'],
                        child: Text("Groupe ${group['number']} - ${group['speciality']} - L${group['level']}"),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        selectedGroupId = value;
                      });
                    },
                  ),
                  // Affiche le groupe sélectionné, si présent
                  if (selectedGroupId != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("Groupe sélectionné: ${selectedGroupId!}"),
                    ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedGroupId != null) {
                  // Associe le groupe à la classe dans la base de données
                  await Dtabase().associateGroupToClass(classe['cid'], selectedGroupId!);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Classe associée au groupe avec succès")),
                  );
                } else {
                  // Affiche un message si aucun groupe n'est sélectionné
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Veuillez sélectionner un groupe")),
                  );
                }
              },
              child: Text("Associer"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        backgroundColor: Color(0xFF303F9F),
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.assignment, color: Colors.white, size: 28),
        ),
        title: Text("MY CLASSES", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                          hintStyle: TextStyle(color: Colors.white),
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
            icon: Icon(Icons.filter_list, color: Colors.white),
            onSelected: (value) {
              setState(() {
                selectedFilter = value;
              });
              _filterClasses();
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 'None', child: Text('No Filter')),
              PopupMenuItem(value: 'name', child: Text('Filter by Name')),
              PopupMenuItem(value: 'level', child: Text('Filter by Level')),
              PopupMenuItem(value: 'speciality', child: Text('Filter by Speciality')),
              PopupMenuItem(value: 'year', child: Text('Filter by Year')),  // Filtrage par année
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 4 / 2,
          ),
          itemCount: filteredClasses.length,
          itemBuilder: (context, index) {
            final classe = filteredClasses[index];
            return Card(
              color: index.isEven ? Color(0xFF3E4A8C) : Color(0xFF5F63A4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name: ${classe['name']}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
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
                            IconButton(
                              icon: Icon(Icons.link, color: Colors.lightGreenAccent),
                              tooltip: 'Associate group to class',
                              onPressed: () {
                                _associateGroupToClass(context,classe);
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text('Speciality: ${classe['speciality']}', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Level: ${classe['level']}', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Year: ${classe['year']}', style: TextStyle(color: Colors.white)),
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
    searchController.addListener(_searchClasses);
  }

  Future<void> loadClasses() async {
    final groups = await dbc.getGroup();
    setState(() {
      Lclass = groups;
      filteredClasses = groups;
    });
  }

  void _searchClasses() {
    String query = searchController.text.toLowerCase();
    setState(() {
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


  void _confirmDelete(int id) {
    showDialog(
      context: context as BuildContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF2E2E6E),
          title: Text('Confirm Deletion', style: TextStyle(color: Colors.white)),
          content: Text('Are you sure you want to delete this group?',
              style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () async {
                await dbc.deleteGroup(id);
                Navigator.pop(context);
                await loadClasses();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        backgroundColor: Color(0xFF303F9F),
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.group,
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
              PopupMenuItem(value: 'Speciality', child: Text('Filter by Speciality')),
              PopupMenuItem(value: 'level', child: Text('Filter by Level')),
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
            childAspectRatio: 1 ,
          ),
          itemCount: filteredClasses.length,
          itemBuilder: (context, index) {
            final classe = filteredClasses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => student(groupId: filteredClasses[index]),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 6,
                color: index.isEven ? Color(0xFF3E4A8C) : Color(0xFF5F63A4),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Speciality: ${classe['speciality']}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Level: ${classe['level']}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Number: ${classe['number']}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () {
                              TextEditingController specialityController =
                              TextEditingController(text: classe['speciality']);
                              TextEditingController levelController =
                              TextEditingController(text: classe['level'].toString());
                              TextEditingController numberController =
                              TextEditingController(text: classe['number'].toString());
                              showDialog(
                                context: context as BuildContext,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Color(0xFF2E2E6E),
                                    title: Text('Edit Group', style: TextStyle(color: Colors.white)),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: specialityController,
                                          decoration: InputDecoration(labelText: 'Speciality'),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        TextField(
                                          controller: levelController,
                                          decoration: InputDecoration(labelText: 'Level'),
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        TextField(
                                          controller: numberController,
                                          decoration: InputDecoration(labelText: 'Number'),
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('Cancel', style: TextStyle(color: Colors.grey)),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      ElevatedButton(
                                        child: Text('Update'),
                                        onPressed: () async {
                                          final dbc=Dtabase();

                                          await dbc.updateGroup(
                                            classe['id'],
                                            specialityController.text.trim(),
                                            int.tryParse(levelController.text) ?? 0,
                                            int.tryParse(numberController.text) ?? 0,
                                          );

                                          Navigator.pop(context);
                                          await loadClasses();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red[200]),
                            onPressed: () => _confirmDelete(classe['id']),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
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
                    final dbc=Dtabase();
                    dbc.updateStudent(3, 'Ahmed Ben Ali', 'ahmed@example.com', 1);

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
    String path = join(databasesPath, 'd7.db');
    return await openDatabase(
      path,
      version: 4,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE class ('
                'cid INTEGER PRIMARY KEY AUTOINCREMENT, '
                'name TEXT NOT NULL, '
                'speciality TEXT NOT NULL, '
                'level INTEGER NOT NULL, '
                'year TEXT NOT NULL, '
                'commant TEXT, '
                'group_id INTEGER, '
                'FOREIGN KEY(group_id) REFERENCES "group"(gid)'
                ')'
        );

        await db.execute(
            'CREATE TABLE "group" ('
                'gid INTEGER PRIMARY KEY AUTOINCREMENT, '
                'number INTEGER, '
                'speciality TEXT NOT NULL, '
                'level INTEGER NOT NULL, '
                'type TEXT NOT NULL, '
                'UNIQUE(number, speciality, level)'
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

  Future<bool> insertClass(String name, String speciality, int level, String year) async {
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
      print('Erreur lors dinsertion de la classe : \$e');
      return false;
    }
  }

  Future<bool> insertGroup(String speciality, int level, int number, String type) async {
    try {
      final db = await database;

      List<Map<String, dynamic>> existingGroups = await db.query(
        'group',
        where: 'speciality = ? AND level = ? AND number = ?',
        whereArgs: [speciality, level, number],
      );

      if (existingGroups.isNotEmpty) {
        print('Ce groupe existe déjà.');
        return false;
      }

      await db.insert(
        'group',
        {
          'number': number,
          'speciality': speciality,
          'level': level,
          'type': type,
        },
      );
      return true;
    } catch (e) {
      print('Erreur lors de l\'insertion du groupe : \$e');
      return false;
    }
  }

  Future<bool> insertStudent(String finame, String famname, String speciality, int level, int group) async {
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
      print('Erreur lors de l\'insertion de l\'étudiant : \$e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getClasses() async {
    final db = await database;
    return await db.query('class');
  }
  Future<void> updateGroup(int id, String speciality, int level, int number) async {
    final db = await database;
    await db.update(
      'groups',
      {
        'speciality': speciality,
        'level': level,
        'number': number,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<void> deleteGroup(int id) async {
    final db = await database;
    await db.delete('groups', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getGroup() async {
    final db = await database;
    return await db.query('group');
  }

  Future<void> deleteClass(int cid) async {
    final db = await database;
    await db.delete(
      'class',
      where: 'cid = ?',
      whereArgs: [cid],
    );
  }



  Future<void> deleteStudent(String finame, String famname, int groupId, String speciality) async {
    final db = await database;
    await db.delete(
      'student',
      where: 'finame = ? AND famname = ? AND group_id = ? AND speciality = ?',
      whereArgs: [finame, famname, groupId, speciality],
    );
  }

  Future<void> updateClass(int cid, String name, String speciality, int level, String year) async {
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
      'student', // Assure-toi que le nom de la table est correct
      where: 'group_id = ?',
      whereArgs: [groupId],
    );
  }

  Future<void> updateStudent(int id, String name, String email, int groupId) async {
    final db = await database;

    await db.update(
      'students',
      {
        'name': name,
        'email': email,
        'group_id': groupId,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<void> associateGroupToClass(int classId, int groupId) async {
    final db = await database;
    await db.update(
      'class',
      {'group_id': groupId},
      where: 'cid = ?',
      whereArgs: [classId],
    );
  }

}

