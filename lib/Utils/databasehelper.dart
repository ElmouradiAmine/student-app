import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_app/Models/student.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  
  String studentTable = 'student_table';
  String colId = 'id';
  String colFirstName = 'first_name';
  String colLastName = 'last_name';
  String colYear = 'year';
  String colBirthDate = 'birth_date';
  String colCity = 'city';
  String colEmail = 'email';
  String colImgUrl = 'imgUrl';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'students.db';

    Database notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        '''CREATE TABLE $studentTable(
          $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $colFirstName TEXT NOT NULL,
          $colLastName TEXT NOT NULL,
          $colBirthDate TEXT NOT NULL,
          $colCity TEXT NOT NULL,
          $colEmail TEXT NOT NULL,
          $colYear TEXT NOT NULL,
          $colImgUrl TEXT NOT NULL
          )''');
      await db.execute('''
          INSERT INTO $studentTable
          VALUES 
          (1,"Amine","Elmouradi","19/09/1998","Rabat", "amine_elmouradi@outlook.fr", "1st year",'https://i.pinimg.com/originals/99/26/be/9926bede5d92dd225052b56ae7c5e932.jpg'),
          (2,"Imane","Elmouradi","19/09/1998","Rabat", "imane_elmouradi@outlook.fr", "1st year",'https://m.media-amazon.com/images/M/MV5BMTQwMDQ0NDk1OV5BMl5BanBnXkFtZTcwNDcxOTExNg@@._V1_.jpg'),
          (3,"Ibtissam","Ait Messaoud","19/09/2019","Kenitra", "ibtissam_ait@outlook.fr", "1st year",'https://images.thestar.com/SZ2plkPioBUB4CZWNogtJYfMJcE=/1086x1628/smart/filters:cb(2700061000)/https://www.thestar.com/content/dam/thestar/entertainment/2011/06/20/hobbit_alert_evangeline_lilly_joins_the_cast_of_the_films/evangelinelilly.jpeg'),
          (4,"Mehdi","Ait lhaj lotfi","19/09/2019","Warzazate", "mehdi_lhaj@outlook.fr", "1st year",'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTU1MTM0NzA2NzQ3MTg4NDQw/chris-evans-arrives-at-the-los-angeles-premiere-of-captain-america-the-winter-soldier-held-at-the-el-capitan-theatre-on-march-13-2014-in-hollywood-california-photo-by-michael-tran_filmmagicjpg-square.jpg'),
          (5,"Kaoutar","Al Ayachi","19/09/2019","Taza", "kaoutar_alayachi@outlook.fr", "1st year", 'https://resize-parismatch.ladmedia.fr/rcrop/250,250/img/var/news/storage/images/paris-match/people-a-z/adele/6050340-6-fre-FR/Adele.jpg')
          ''');
  }

  Future<List<Map<String, dynamic>>> getStudentMapList({String text, String text1}) async {
    Database db = await this.database;
    if(text==null || text == ''){
      return await db.rawQuery('SELECT * FROM $studentTable');
    } 
    return await db.rawQuery('SELECT * FROM $studentTable WHERE ($colFirstName LIKE "%$text%" and $colLastName LIKE "%$text1%") or ($colFirstName LIKE "%$text1%" and $colLastName LIKE "%$text%") ');
  }

  Future<int> insertStudent(Student student) async {
    Database db = await this.database;
    var result = await db.insert(studentTable, student.toJson());
    return result;
  }

  Future<int> updateStudent(Student student) async {
    Database db = await this.database;
    var result = await db.update(studentTable, student.toJson(),
        where: '$colId = ?', whereArgs: [student.id]);
    return result;
  }

  Future<int> deleteStudent(int id) async { 
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $studentTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $studentTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Student>> getStudentList({String text, String text1}) async {
    var studentMapList = await getStudentMapList(text: text,text1: text1);
    int count = studentMapList.length;
    List<Student> studentList = List<Student>();
    for (int i = 0 ; i < count ; i++){
      studentList.add(Student.fromJson(studentMapList[i]));
    }
    return studentList;
  }
}