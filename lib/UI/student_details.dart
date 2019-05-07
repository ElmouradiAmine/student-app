import 'package:flutter/material.dart';

//My imports
import 'package:sqlite_app/UI/student_creation.dart';
import 'package:sqlite_app/Models/student.dart';

class StudentDetails extends StatelessWidget {
  final BuildContext context;
  final Student student;

  const StudentDetails(
      {Key key,
      this.context,
      this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        '#${student.id}',
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      content: Container(
        height: 255,
        child: Column(
          children: <Widget>[
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.green,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(student.imgUrl),
                  )),
            ),
            SizedBox(height: 10),
            infoButton(student.firstName + " " + student.lastName),
            SizedBox(height: 10),
            infoButton(student.year),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                infoButton(student.city),
                SizedBox(
                  width: 10,
                ),
                infoButton(student.birthDate),
              ],
            ),
            SizedBox(height: 10),
            infoButton(student.email),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Material(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30.0),
              child: InkWell(
                onTap: (){
                  
                  pushToStudentCreation(student,student.firstName + " " + student.lastName);

                },
                borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.edit, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 150,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        )
      ],
    );
  }

  Widget infoButton(String text) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(20.0)),
    );
  }

void pushToStudentCreation(Student student, String appBarTitle) {
    Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return StudentCreation(
                  appBarTitle: appBarTitle,
                  student: Student(
                    id: student.id,
                  firstName: student.firstName,
                  lastName: student.lastName,
                  birthDate: student.birthDate,
                  email: student.email,
                  year: student.year,
                  city: student.city,
                  imgUrl: student.imgUrl,
                ),);
              }
            ));
  }

  
}
