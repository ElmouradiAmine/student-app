import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

//My imports
import 'package:sqlite_app/UI/home.dart';

void main() async{
  try {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.lightBlue);
  }  catch (e) {
    print(e);
  }
  return runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQlite App',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}


