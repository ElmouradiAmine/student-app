import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

//My imports
import 'package:sqlite_app/Utils/databasehelper.dart';
import 'package:sqlite_app/Models/student.dart';
import 'package:sqlite_app/UI/chat.dart';
import 'package:sqlite_app/UI/student_details.dart';
import 'package:sqlite_app/UI/student_creation.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Student> studentsList;
  TextEditingController searchController = TextEditingController();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (studentsList == null) {
      studentsList = List<Student>();
      updateGridView();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            pushToStudentCreation();
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 300,
              ),
              Container(
                height: 250,
                color: Colors.lightBlue,
              ),
              Positioned(
                left: -50,
                top: -130,
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightBlueAccent.withOpacity(0.3)),
                ),
              ),
              Positioned(
                right: -40,
                top: -90,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.lightBlueAccent.withOpacity(0.3)),
                ),
              ),
              Positioned(
                left: 20,
                top: 20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'))),
                ),
              ),
              Positioned(
                right: 0,
                top: 45,
                child: customMenuButton(),
              ),
              Positioned(
                  top: 120,
                  left: 20,
                  child: Text(
                    'Hello, Tom',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 30.0),
                  )),
              Positioned(
                  top: 165,
                  left: 20,
                  child: Text(
                    'Check on your students !',
                    style: TextStyle(color: Colors.white, fontSize: 23.0),
                  )),
              Positioned(top: 220, left: 30, child: searchbar()),
            ],
          ),
          getStudentsGridView(),
        ],
      ),
    );
  }

  Widget _buildCard(String firstName, String lastName, String url, String year,
      int cardIndex) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Stack(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context){
                      return StudentDetails(
                        context: context,
                        student: studentsList[cardIndex],
                      );
                    }

                  );
                },
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.green,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(url),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            (firstName + lastName).length < 16
                ? (firstName + " " + lastName)
                : (firstName + " " + lastName).substring(0, 13) + "...",
            softWrap: true,
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 16.0, color: Colors.black),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(year,
              style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey)),
          SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: Container(
              width: 175.0,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                          )),
                      child: Center(
                        child: Icon(
                          Icons.email,
                          size: 30,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.green,
                      child: Center(
                        child: Icon(
                          Icons.call,
                          size: 30,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          pushToChatPage(firstName, lastName, url, year);
                        },
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.send,
                              size: 30,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.0),
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      margin: cardIndex.isEven
          ? EdgeInsets.fromLTRB(25.0, 0.0, 10.0, 10.0)
          : EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0),
    );
  }

  Widget searchbar() {
    return Material(
      borderRadius: BorderRadius.circular(5.0),
      elevation: 2.0,
      child: Container(
        width: 350,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
        child: Center(
          child: TextField(
            controller: searchController,
            style: TextStyle(
              fontSize: 21,
            ),
            onChanged: (value){
              if(!value.startsWith(' ')){
                  var split = searchController.text.split(' ');
                  updateGridView(text:split[0],text1: split.length<2 ? '':split[1]);
              }
              else {
                searchController.text ='';
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search,color: Colors.blue,),
              hintText: 'Search',
              
              hintStyle: TextStyle(
              fontSize: 21,
            ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customMenuButton() {
    return Stack(
      children: <Widget>[
        Container(
          height: 50,
          width: 60,
        ),
        Positioned(
          right: 33,
          child: Container(
            width: 15,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
          ),
        ),
        Positioned(
          top: 8,
          right: 25,
          child: Container(
            width: 30,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
          ),
        ),
        Positioned(
          top: 16,
          right: 32,
          child: Container(
            width: 15,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50.0)),
          ),
        ),
      ],
    );
  }

  GridView getStudentsGridView() {
    return GridView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _buildCard(
            studentsList[index].firstName,
            studentsList[index].lastName,
            studentsList[index].imgUrl,
            studentsList[index].year,
            index);
      },
      itemCount: count,
      shrinkWrap: true,
      primary: false,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }

  void updateGridView({String text,String text1}) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Student>> studentsListFuture =
          databaseHelper.getStudentList(text: text,text1: text1);
      studentsListFuture.then((studentsList) {
        setState(() {
          this.studentsList = studentsList;
          this.count = studentsList.length;
        });
      });
    });
  }

  void pushToChatPage(
      String firstName, String lastName, String imgUrl, String year) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChatPage(
        imgUrl: imgUrl,
        firstName: firstName,
        lastName: lastName,
        year: year,
      );
    }));
  }

  void pushToStudentCreation(){
    Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return StudentCreation(
                  appBarTitle: 'Add student',
                  student: Student(
                    id: null,
                  firstName: '',
                  lastName: '',
                  birthDate: '',
                  email: '',
                  year: '',
                  city: '',
                  imgUrl: '',
                ),);
              }
            ));   
  }
}
