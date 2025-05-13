import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:excel/excel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';



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
    Timer(Duration(seconds: 1), () {
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
                colors: [Colors.purple.shade900 ,Colors.purple.shade300 ],
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
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 5,
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
                            colors: [Colors.purple.shade300, Colors.blue.shade300],
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
                                        type = value;
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "You must fill level";
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
                                      int.parse(numberController.text),type!
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
                            colors: [Colors.blue.shade300,Colors.pink.shade300 , ],
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
                          builder: (context) {
                            int? selectedGroupId;
                            final numberController = TextEditingController();
                            final fanameController = TextEditingController();
                            final finameController = TextEditingController();
                            final _formKey = GlobalKey<FormState>();

                            return FutureBuilder<List<Map<String, dynamic>>>(
                              future: Dtabase().getGroup(), // 👈 Ta méthode pour récupérer les groupes
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }

                                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return AlertDialog(
                                    title: Text("Aucun groupe trouvé"),
                                    content: Text("Veuillez d'abord créer un groupe."),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Fermer"),
                                      ),
                                    ],
                                  );
                                }

                                final groups = snapshot.data!;

                                return AlertDialog(
                                  backgroundColor: Color(0xFFD5DEEF),
                                  title: Text("Ajouter un étudiant", style: TextStyle(color: Color(0xFF18185C))),
                                  content: StatefulBuilder(
                                    builder: (context, setState) {
                                      return SingleChildScrollView(
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                controller: numberController,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: 'Student Number*',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return "Please enter the student number";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 8),
                                              TextFormField(
                                                controller: fanameController,
                                                decoration: InputDecoration(
                                                  labelText: 'Family Name*',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return "Please enter the family name";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 8),
                                              TextFormField(
                                                controller: finameController,
                                                decoration: InputDecoration(
                                                  labelText: 'First Name*',
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return "Please enter the first name";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 8),
                                              DropdownButtonFormField<int>(
                                                value: selectedGroupId,
                                                isExpanded: true,
                                                decoration: InputDecoration(
                                                  labelText: 'Select Group*',
                                                  border: OutlineInputBorder(),
                                                ),
                                                items: groups.map((group) {
                                                  return DropdownMenuItem<int>(
                                                    value: group['gid'], // ou 'id' selon ta colonne
                                                    child: Text("Groupe ${group['number']} - ${group['speciality']} - n:${group['level']} -${group['type']}"),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedGroupId = value;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value == null) {
                                                    return "Please select a group";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
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
                                        if (_formKey.currentState!.validate()) {
                                          bool success = await Dtabase().insertStudent(
                                            int.parse(numberController.text),
                                            finameController.text,
                                            fanameController.text,
                                            selectedGroupId !,
                                          );
                                          if (success) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("Étudiant ajouté avec succès")),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("Erreur lors de l’ajout")),
                                            );
                                          }
                                        }
                                      },
                                      child: Text("Valider"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFB1C9EF),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );



                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.pink.shade200 ,Colors.purple.shade600],
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
                            colors: [Colors.purple.shade400,Colors.blue.shade400],
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
                            colors: [Colors.blue.shade300,Colors.purple.shade600, ],
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return FutureBuilder<List<Map<String, dynamic>>>(
                              future: Dtabase().getGroup(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }

                                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return AlertDialog(
                                    title: Text("Aucun groupe trouvé"),
                                    content: Text("Veuillez d'abord créer un groupe."),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Fermer"),
                                      ),
                                    ],
                                  );
                                }

                                final groups = snapshot.data!;
                                int? selectedGroupId;

                                return AlertDialog(
                                  backgroundColor: Color(0xFFD5DEEF),
                                  title: Text(" Enter student from file excel", style: TextStyle(color: Color(0xFF18185C))),
                                  content: StatefulBuilder(
                                    builder: (context, setState) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DropdownButtonFormField<int>(
                                              isExpanded: true,
                                              decoration: InputDecoration(
                                                labelText: 'Liste des groupes*',
                                                border: OutlineInputBorder(),
                                              ),
                                              items: groups.map((group) {
                                                return DropdownMenuItem<int>(
                                                  value: group['gid'],
                                                  child: Text("Groupe ${group['number']} - ${group['speciality']} - Niveau:${group['level']} - ${group['type']}"),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGroupId = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Veuillez sélectionner un groupe";
                                                }
                                                return null;
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            ElevatedButton.icon(
                                              onPressed: selectedGroupId == null
                                                  ? null // désactive si aucun groupe choisi
                                                  : () async {
                                                final result = await FilePicker.platform.pickFiles(
                                                  type: FileType.custom,
                                                  allowedExtensions: ['csv', 'pdf', 'xlsx'],
                                                );

                                                if (result != null && result.files.isNotEmpty) {
                                                  String? filePath = result.files.single.path;
                                                  if (filePath != null) {
                                                    var bytes = File(filePath).readAsBytesSync();
                                                    var excel = Excel.decodeBytes(bytes);

                                                    int importedCount = 0;

                                                    for (var table in excel.tables.keys) {
                                                      List<Data?> headers = excel.tables[table]!.rows.first;

                                                      for (int i = 1; i < excel.tables[table]!.rows.length; i++) {
                                                        var row = excel.tables[table]!.rows[i];

                                                        String numStr = row[0]?.value.toString() ?? '';
                                                        String firstName = row[1]?.value.toString() ?? '';
                                                        String familyName = row[2]?.value.toString() ?? '';

                                                        if (numStr.isNotEmpty && firstName.isNotEmpty && familyName.isNotEmpty) {
                                                          int? studentNumber = int.tryParse(numStr);

                                                          if (studentNumber != null) {
                                                            final db = Dtabase();
                                                            bool success = await db.insertStudent(
                                                              studentNumber,
                                                              firstName,
                                                              familyName,
                                                              selectedGroupId!, // utiliser ici la valeur sélectionnée
                                                            );
                                                            if (success) importedCount++;
                                                          } else {
                                                            print("Numéro étudiant invalide à la ligne ${i + 1}");
                                                          }
                                                        } else {
                                                          print("Données manquantes à la ligne ${i + 1}");
                                                        }
                                                      }
                                                    }

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text('$importedCount étudiants importés avec succès.')),
                                                    );
                                                  }
                                                } else {
                                                  print("Aucun fichier sélectionné.");
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Aucun fichier sélectionné.')),
                                                  );
                                                }
                                              },
                                              icon: Icon(Icons.upload_file),
                                              label: Text("Upload list student"),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFFB1C9EF),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),

                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple.shade700, Colors.pink.shade200],
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
                              "enter group From file excel",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    )



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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade900 ,Colors.purple.shade300 ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
class SessionDetailsScreen extends StatefulWidget {
  final String date;
  final String time;

  const SessionDetailsScreen({Key? key, required this.date, required this.time})
      : super(key: key);

  @override
  _SessionDetailsScreenState createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Date: ${widget.date}'),
            SizedBox(height: 8),
            Text('Time: ${widget.time}'),
          ],
        ),
      ),
    );
  }
}

class SessionFormScreen extends StatefulWidget {
  final int groupId;

  const SessionFormScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  _SessionFormScreenState createState() => _SessionFormScreenState();
}



class _SessionFormScreenState extends State<SessionFormScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dt);
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => _pickDate(context),
              child: Text('Choisir une date'),
            ),
            SizedBox(height: 10),
            Text(
              selectedDate == null
                  ? 'Aucune date sélectionnée'
                  : 'Date: ${selectedDate!.toLocal()}'.split(' ')[0],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickTime(context),
              child: Text('Choisir une heure'),
            ),
            SizedBox(height: 10),
            Text(
              selectedTime == null
                  ? 'Aucune heure sélectionnée'
                  : 'Heure: ${selectedTime!.format(context)}',
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (selectedDate != null && selectedTime != null) {

                  await Dtabase().insertSession(widget.groupId, selectedDate!, selectedTime!);
                  print('Session inserted successfully');


                  final formattedDate = formatDate(selectedDate!);
                  final formattedTime = formatTime(selectedTime!);

                  // Navigate to a new screen or update the UI to display the date and time
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionDetailsScreen(
                        date: formattedDate,
                        time: formattedTime,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Veuillez choisir une date et une heure')),
                  );
                }
              },
              child: Text('Enregistrer la session'),
            ),

          ],
        ),
      ),
    );
  }
}
class groupInfo extends StatefulWidget{
  _groupInfo createState() =>  _groupInfo();
}
class _groupInfo extends State<groupInfo>with SingleTickerProviderStateMixin  {
  TextEditingController searchController = TextEditingController();
  final dbc = Dtabase();
  List<Map<String, dynamic>> Lclass = [];
  List<Map<String, dynamic>> filteredClasses = [];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    loadClasses();
    searchController.addListener(_searchClasses);
  }
  Future<void> loadClasses({String? type}) async {
    final groups = await dbc.getGroup();
    setState(() {
      if (type != null) {
        filteredClasses = groups.where((classe) => classe['type'] == type).toList();
        Lclass=groups.where((classe) => classe['type'] == type).toList();
      } else {
        filteredClasses = groups;
        Lclass=groups;
      }
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
  int ?i;
  void _showGroupOptionsDialog(BuildContext context, int groupId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Choisissez une option"),
        content: Text("Que voulez-vous faire ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Ferme le dialogue
            child: Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => student(groupId: filteredClasses[i!]),
                ),
              );
            },
            child: Text("Voir la liste des étudiants"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Ferme le dialogue
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassesListScreen(groupId: groupId), // Écran des classes associées
                ),
              );
            },
            child: Text("Voir les classes"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Ferme le dialogue
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassesListScreen(groupId: groupId), // À toi de créer ce screen si nécessaire
                ),
              );
            },
            child: Text("Voir toutes les sessions"),
          ),
        ],
      ),
    );
  }
  Future<void> _confirmDelete2(context, int groupId) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF2E2E6E),
        title: Text("Confirm Deletion", style: TextStyle(color: Colors.white)),
        content: Text("Do you want to delete this group, its students, and its class associations?", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Delete", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final db = Dtabase();

      await db.deleteStudentsByGroupId(groupId);            // Supprime les étudiants du groupe
      await db.deleteGroupClassAssociations(groupId);       // Supprime les associations avec les classes
      await db.deleteGroup(groupId);                        // Supprime le groupe

      await loadClasses(); // Recharge les groupes à l'écran

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Group, students, and associations deleted")),
      );
    }
  }
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade900 ,Colors.purple.shade300 ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
                i=index;
                _showGroupOptionsDialog(context, classe['gid']);

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
                          IconButton(icon: Icon(Icons.add_circle_outline),
                              onPressed: () {

                                 }
                          ),
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
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xFF2E2E6E),
                                      title: Text('Modifier le groupe', style: TextStyle(color: Colors.white)),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: specialityController,
                                            decoration: InputDecoration(labelText: 'Spécialité'),
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          TextField(
                                            controller: levelController,
                                            decoration: InputDecoration(labelText: 'Niveau'),
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          TextField(
                                            controller: numberController,
                                            decoration: InputDecoration(labelText: 'Numéro'),
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Annuler', style: TextStyle(color: Colors.grey)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final db = Dtabase(); // instancier ta classe de base de données
                                            await db.updateGroup(
                                              classe['gid'],
                                              specialityController.text.trim(),
                                              int.tryParse(levelController.text.trim()) ?? 0,
                                              int.tryParse(numberController.text.trim()) ?? 0,
                                            );

                                            Navigator.pop(context);
                                            await loadClasses(); // Recharge la liste après mise à jour
                                          },
                                          child: Text('Modifier'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },

                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red[200]),
                            onPressed:() => _confirmDelete2(context,classe['gid']),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.shade900,
              Colors.purple.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Transparent pour voir le gradient
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[300],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              if (index == 0) {
                loadClasses();
              } else if (index == 1) {
                loadClasses(type: 'td');
              } else if (index == 2) {
                loadClasses(type: 'tp');
              }
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.class_),
              label: 'TD',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.computer),
              label: 'TP',
            ),
          ],
        ),
      ),


    );
  }
}
class ClassesListScreen extends StatefulWidget {
  final int groupId;

  ClassesListScreen({required this.groupId});

  @override
  _ClassesListScreenState createState() => _ClassesListScreenState();
}


class _ClassesListScreenState extends State<ClassesListScreen> {
  late Future<List<Map<String, dynamic>>> _classesFuture;

  @override
  void initState() {
    super.initState();
    _classesFuture = Dtabase().getClassesByGroup(widget.groupId);
  }

  Future<void> loadClasses() async {
    setState(() {
      _classesFuture = Dtabase().getClassesByGroup(widget.groupId);
    });
  }

  // Fonction pour afficher la boîte de dialogue de confirmation
  Future<void> _showDeleteConfirmationDialog(BuildContext context, int groupId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation de suppression'),
          content: Text('Êtes-vous sûr de vouloir supprimer cette association de groupe ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                final dbc = Dtabase();
                await dbc.removeAllClassesFromGroup(groupId);

                await loadClasses(); // Recharge les classes après la suppression

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Association supprimée avec succès")),
                );
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text('Supprimer', style: TextStyle(color: Colors.red)),
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade900 ,Colors.purple.shade300 ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("Classes Associées"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>( // FutureBuilder qui attend les classes associées
        future: _classesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucune classe associée à ce groupe"));
          }

          final classes = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 3,
            ),
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final classe = classes[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 6,
                color: index.isEven ? Color(0xFF3E4A8C) : Color(0xFF5F63A4),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Class Name: ${classe['name']}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // Affiche la boîte de dialogue de confirmation avant de supprimer
                          await _showDeleteConfirmationDialog(context, widget.groupId);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: Text("Supprimer l'association"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class student extends StatefulWidget {
  final Map<String, dynamic> groupId;
  student({Key? key, required this.groupId}) : super(key: key);

  @override
  _StudentList createState() => _StudentList(groupId: groupId);
}

class _StudentList extends State<student> {
  final Map<String, dynamic> groupId;
  _StudentList({Key? key, required this.groupId});

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> students = [];
  List<Map<String, dynamic>> filteredStudents = [];

  Future<void> loadStudents() async {
    final db = Dtabase();
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
        return  student['number'].toString().contains(query)||
            student['finame'].toLowerCase().contains(query) ||
            student['famname'].toLowerCase().contains(query);
      }).toList();
    });
  }

  // Fonction de filtre pour trier par spécialité ou niveau
  void _applyFilter(String filter) {
    setState(() {
      if (filter == 'number') {
        filteredStudents.sort((a, b) => a['number'].compareTo(b['number']));
      }

    });
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, int studentId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation de suppression'),
          content: Text('Êtes-vous sûr de vouloir supprimer cet étudiant ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                final db = Dtabase();
                await db.deleteStudent(studentId ); // Code pour supprimer l'étudiant
                await loadStudents(); // Recharge les étudiants après la suppression
                Navigator.of(context).pop(); // Ferme la boîte de dialogue

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Étudiant supprimé avec succès")),
                );
              },
              child: Text('Supprimer', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
  void _showEditStudentDialog(BuildContext context,Map<String, dynamic> student) {
    TextEditingController nameController = TextEditingController(text: student['finame']);
    TextEditingController surnameController = TextEditingController(text: student['famname']);
    TextEditingController numberController = TextEditingController(text: student['number'].toString());

    showDialog(
      context:context,
      builder: (context) {
        return AlertDialog(
          title: Text("Modifier l'étudiant"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Prénom')),
              TextField(controller: surnameController, decoration: InputDecoration(labelText: 'Nom de famille')),
              TextField(controller: numberController, decoration: InputDecoration(labelText: 'Numéro')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () async {
                final db = Dtabase();
                await db.updateStudent(
                  student['sid'],
                  nameController.text,
                  surnameController.text,
                  int.parse(numberController.text!),
                );
                await loadStudents(); // Recharger les étudiants
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Étudiant modifié avec succès")));
              },
              child: Text("Modifier"),
            ),
          ],
        );
      },
    );
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade900 ,Colors.purple.shade300 ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
          "MY GROUP",
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
                          hintText: 'Search by number , name  ...',
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
            icon: Icon(Icons.search ,  color: Color(0xFFB1C9EF)),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: Color(0xFFB1C9EF)),
            onSelected: _applyFilter,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'number',
                child: Text('Filter by number'),
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
            title: Text('${student['number']} | ${student['finame']} ${student['famname']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _showEditStudentDialog(context,student);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Affiche la boîte de dialogue de confirmation avant de supprimer
                    _showDeleteConfirmationDialog(context, student['sid']); // Assurez-vous que l'ID de l'étudiant est accessible
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
    String path = join(databasesPath, 'ab7.db');
    return await openDatabase(
      path,
      version: 4,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE class (
            cid INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            speciality TEXT NOT NULL,
            level INTEGER NOT NULL,
            year TEXT NOT NULL,
            commant TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE "group" (
            gid INTEGER PRIMARY KEY AUTOINCREMENT,
            number INTEGER,
            speciality TEXT NOT NULL,
            level INTEGER NOT NULL,
            type TEXT NOT NULL,
            UNIQUE(number, speciality, level,type)
          )
        ''');

        await db.execute('''
          CREATE TABLE student (
            sid INTEGER PRIMARY KEY AUTOINCREMENT,
            number int ,
            finame TEXT NOT NULL,
            famname TEXT NOT NULL,
            group_id INTEGER NOT NULL,
            FOREIGN KEY(group_id) REFERENCES "group"(gid)
             UNIQUE(number)
          )
        ''');
        await db.execute('''
        CREATE TABLE sessions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        groupId INTEGER,
        date TEXT,
        time TEXT,
        FOREIGN KEY(group_id) REFERENCES "group"(gid)
      )
    ''');
        await db.execute('''
          CREATE TABLE class_group (
            class_id INTEGER,
            group_id INTEGER,
            FOREIGN KEY(class_id) REFERENCES class(cid),
            FOREIGN KEY(group_id) REFERENCES "group"(gid),
            PRIMARY KEY (class_id, group_id)
          )
        ''');
      },
    );
  }

  // --- Classes ---
  Future<bool> insertClass(String name, String speciality, int level, String year) async {
    try {
      final db = await database;
      await db.insert('class', {
        'name': name,
        'speciality': speciality,
        'level': level,
        'year': year,
      });
      return true;
    } catch (e) {
      print('Erreur lors de l\'insertion de la classe : $e');
      return false;
    }
  }
  Future<bool> updateSession(int sessionId, DateTime newDate, TimeOfDay newTime) async {
    try {
      final db = await database;

      final String formattedDate =
          "${newDate.year.toString().padLeft(4, '0')}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}";
      final String formattedTime =
          "${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}";

      int count = await db.update(
        'sessions',
        {
          'date': formattedDate,
          'time': formattedTime,
        },
        where: 'id = ?',
        whereArgs: [sessionId],
      );

      return count > 0;
    } catch (e) {
      print('Erreur lors de la mise à jour de la session : $e');
      return false;
    }
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

  Future<void> deleteClass(int cid) async {
    final db = await database;
    await db.delete('class', where: 'cid = ?', whereArgs: [cid]);
    await db.delete('class_group', where: 'class_id = ?', whereArgs: [cid]);
  }

  Future<List<Map<String, dynamic>>> getClasses() async {
    final db = await database;
    return await db.query('class');
  }

  // --- Groups ---
  Future<bool> insertGroup(String speciality, int level, int number, String type) async {
    try {
      final db = await database;

      // Vérifie s'il existe déjà un groupe avec la même spécialité, niveau et numéro, quel que soit le type
      List<Map<String, dynamic>> existingGroups = await db.query(
        'group',
        where: 'speciality = ? AND level = ? AND number = ?',
        whereArgs: [speciality, level, number],
      );

      // Si un groupe existe avec la même spécialité, niveau et numéro
      if (existingGroups.isNotEmpty) {
        // Vérifie si ce groupe a déjà le même type
        for (var group in existingGroups) {
          if (group['type'] == type) {
            print('Ce groupe avec ce type existe déjà.');
            return false; // Empêche l'insertion si le type est déjà pris
          }
        }
      }

      // Si aucun groupe avec le même type n'existe, insère le nouveau groupe
      await db.insert('group', {
        'number': number,
        'speciality': speciality,
        'level': level,
        'type': type,
      });

      return true;
    } catch (e) {
      print('Erreur lors de l\'insertion du groupe : $e');
      return false;
    }
  }

  Future<void> updateGroup(int id, String speciality, int level, int number) async {
    final db = await database;
    await db.update(
      'group',
      {
        'speciality': speciality,
        'level': level,
        'number': number,
      },
      where: 'gid = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteGroup(int id) async {
    final db = await database;
    await db.delete('group', where: 'gid = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getGroup() async {
    final db = await database;
    return await db.query('group');
  }

  // --- Students ---
  Future<bool> insertStudent(
      int studentNumber,
      String firstName,
      String familyName,
      int groupId,
      ) async {
    final db = await database;

    try {
      await db.insert(
        'student',
        {
          'number': studentNumber,
          'finame': firstName,
          'famname': familyName,
          'group_id': groupId,
        },
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
      return true;
    } catch (e) {
      print("Erreur : Numéro d'étudiant déjà utilisé → $e");
      return false;
    }
  }



  Future<void> updateStudent(int id, String finame, String famname, int number) async {
    final db = await database;

    await db.update(
      'student',
      {
        'finame': finame,
        'famname': famname,
        'number': number,
      },
      where: 'sid = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteStudent(int studentId) async {
    final db = await database;
    await db.delete(
      'student',
      where: 'sid = ?',
      whereArgs: [studentId],
    );
  }


  Future<List<Map<String, dynamic>>> getStudentsByGroup(int groupId) async {
    final db = await database;
    return await db.query('student', where: 'group_id = ?', whereArgs: [groupId]);
  }

  // --- Classe & Groupe relation ---
  Future<void> associateGroupToClass(int classId, int groupId) async {
    final db = await database;
    await db.insert(
      'class_group',
      {
        'class_id': classId,
        'group_id': groupId,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> removeGroupFromClass(int classId, int groupId) async {
    final db = await database;
    await db.delete(
      'class_group',
      where: 'class_id = ? AND group_id = ?',
      whereArgs: [classId, groupId],
    );
  }

  Future<List<Map<String, dynamic>>> getGroupsByClass(int classId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT "group".* FROM "group"
      INNER JOIN class_group ON class_group.group_id = "group".gid
      WHERE class_group.class_id = ?
    ''', [classId]);
  }

  Future<List<Map<String, dynamic>>> getClassesByGroup(int groupId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT class.* FROM class
      INNER JOIN class_group ON class_group.class_id = class.cid
      WHERE class_group.group_id = ?
    ''', [groupId]);
  }

  Future<void> removeAllGroupsFromClass(int classId) async {
    final db = await database;
    await db.delete('class_group', where: 'class_id = ?', whereArgs: [classId]);
  }

  Future<void> removeAllClassesFromGroup(int groupId) async {
    final db = await database;
    await db.delete('class_group', where: 'group_id = ?', whereArgs: [groupId]);
  }

  Future<void> deleteStudentsByGroupId(int groupId) async {
    final db = await database;
    await db.delete('student', where: 'group_id = ?', whereArgs: [groupId]);
  }

  Future<void> deleteGroupClassAssociations(int groupId) async {
    final db = await database;
    await db.delete('class_group', where: 'group_id = ?', whereArgs: [groupId]);
  }
  //new
  Future<bool> insertSession(int groupId, DateTime date, TimeOfDay time) async {
    try {
      final db = await database; // Use the singleton database instance.

      final String formattedDate =
          "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      final String formattedTime =
          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

      await db.insert(
        'sessions',
        {
          'groupId': groupId,
          'date': formattedDate,
          'time': formattedTime,
        },
        // conflictAlgorithm: ConflictAlgorithm.replace, ← نحذفها
      );
      return true;
    } catch (e) {
      print('Erreur lors de l\'insertion de session : $e');
      return false;
    }
  }

}

