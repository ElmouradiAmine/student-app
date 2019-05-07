import 'package:flutter/material.dart';

//My imports
import 'package:sqlite_app/Models/student.dart';
import 'package:sqlite_app/Utils/databasehelper.dart';
import 'package:sqlite_app/UI/home.dart';

class StudentCreation extends StatefulWidget {
  final String appBarTitle;
  final Student student;
  const StudentCreation({this.appBarTitle, this.student});

  @override
  _StudentCreationState createState() =>
      _StudentCreationState(appBarTitle, student);
}

class _StudentCreationState extends State<StudentCreation> {
  final String appBarTitle;
  final Student student;
  DatabaseHelper databaseHelper = DatabaseHelper();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController imgUrlController = TextEditingController();
  static var _year = ['1st year', '2nd year', '3rd year'];
  static var _cities = [
    'Rabat',
    'Salé',
    'Casablanca',
    'Kenitra',
    'Agadir',
    'Warzazate',
    'Tangier',
    'Ouejda',
    'Alhouceima',
    'Taza',
    'Fes',
    'Marrakech'
  ];

  _StudentCreationState(this.appBarTitle, this.student);

  @override
  Widget build(BuildContext context) {
    firstNameController.text = student.firstName;
    lastNameController.text = student.lastName;
    birthDateController.text = student.birthDate;
    cityController.text = student.city;
    emailController.text = student.email;
    yearController.text = student.year;
    imgUrlController.text = student.imgUrl;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(appBarTitle),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.lightBlue,
                radius: 100,
                child: imgUrlController.text == ''
                    ? Icon(
                        Icons.person,
                        size: 140,
                        color: Colors.white,
                      )
                    : null,
                backgroundImage: imgUrlController.text != ''
                    ? NetworkImage(imgUrlController.text)
                    : null,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15, right: 15),
            child: TextField(
              controller: imgUrlController,
              onChanged: (value) {
                updateImgUrl();
              },
              decoration: InputDecoration(
                  labelText: 'Picture URL',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 15.0, left: 15, right: 15),
            child: TextField(
              controller: firstNameController,
              onChanged: (value) {
                updateFirstname();
              },
              decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 15.0, left: 15, right: 15),
            child: TextField(
              controller: lastNameController,
              onChanged: (value) {
                updateLastName();
              },
              decoration: InputDecoration(
                  labelText: 'Last name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 5.0, bottom: 15.0, left: 15, right: 15),
            child: TextField(
              controller: emailController,
              onChanged: (value) {
                updateEmail();
              },
              decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                height: 60,
                child: Row(children: <Widget>[
                  SizedBox(width: 10),
                  Text(
                    'Birth date ',
                    style:
                        TextStyle(fontSize: 16.0, color: Colors.grey.shade600),
                  ),
                  Expanded(
                      child: Container(
                          child: Center(
                              child: Text(
                    birthDateController.text == ''
                        ? '.. / .. / ....'
                        : birthDateController.text,
                    style: TextStyle(fontSize: 23.0),
                  )))),
                ]),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Expanded(
                child: DropdownButton(
                  isDense: true,
                  hint: Text('Choose a city'),
                  isExpanded: true,
                  iconSize: 50,
                  items: _cities.map((String dropDownStringItem) {
                    return DropdownMenuItem(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  value: student.city == '' ? null : student.city,
                  onChanged: (String value) {
                    updateCity(value);
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: DropdownButton(
                  isDense: true,
                  hint: Text('Choose a year'),
                  isExpanded: true,
                  iconSize: 50,
                  items: _year.map((String dropDownStringItem) {
                    return DropdownMenuItem(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  value: yearController.text == '' ? null : yearController.text,
                  onChanged: (String value) {
                    updateYear(value);
                  },
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      _save();
                    },
                    color: Colors.blue,
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      if (appBarTitle == 'Add student'){
                        Navigator.pop(context);
                      } else {
                        _delete();
                      }
                    },
                    child: Text(
                      appBarTitle != 'Add student' ? 'Delete' : 'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  DateTime selectedDate = DateTime.utc(1998, 1, 1);

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1995, 0),
        lastDate: DateTime(2005));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        student.birthDate = selectedDate.day.toString().padLeft(2, '0') +
            "/" +
            selectedDate.month.toString().padLeft(2, '0') +
            "/" +
            selectedDate.year.toString();
      });
  }

  void updateImgUrl() {
    setState(() {
      student.imgUrl = imgUrlController.text;
    });
  }

  void updateEmail() {
    student.email = emailController.text;
  }

  void updateFirstname() {
    student.firstName = firstNameController.text;
  }

  void updateLastName() {
    student.lastName = lastNameController.text;
  }

  void updateYear(String value) {
    setState(() {
      student.year = value;
    });
  }

  void updateCity(String value) {
    setState(() {
      student.city = value;
    });
  }

  void _save() async {
    moveToLastScreen();
    int result;
    if (student.id != null) {
      result = await databaseHelper.updateStudent(student);
    } else {
      result = await databaseHelper.insertStudent(student);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Student Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Student Saved Successfully');
    }
  }


void _delete() async {
    moveToLastScreen();
    if(student.id == null){
      _showAlertDialog('Status', 'No Student was deleted');
      return;
    }
    int result = await databaseHelper.deleteStudent(student.id);
    if (result != 0){
      _showAlertDialog('Status', 'Student Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Student');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
  void moveToLastScreen() {
    Navigator.pop(context);
    Navigator.pushReplacement(context,MaterialPageRoute(
      builder: (context){
        return MyHomePage();
      }
    ));
  }
}
