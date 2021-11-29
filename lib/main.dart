// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, annotate_overrides

import './Models/courses.dart';
import 'package:flutter/material.dart';
import './CoursesAPI.dart';
import './editCourse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'School App',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final CoursesAPI api = CoursesAPI();
  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _dbLoaded = false;
  List courses = [];

  void initState() {
    super.initState();

    widget.api.getAllCourses().then((data) {
      setState(() {
        courses = data;
        _dbLoaded = true;
      });
      return (Courses);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("School App"),
      ),
      body: Center(
          child: _dbLoaded
              ? Column(
                  children: [
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: [
                            ...courses.map<Widget>(
                              (courses) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 30),
                                child: TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => editCourse(
                                                courses['_id'],
                                                courses['courseName'],
                                                courses['courseInstructor'],
                                                courses['courseCredits']))),
                                  },
                                  child: Card(
                                    child: ListTile(
                                      leading: FlutterLogo(size: 72.0),
                                      title: Text(
                                        courses['courseName'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        (courses['courseInstructor'] +
                                            '\n' +
                                            courses['courseCredits']
                                                .toString() +
                                            ' credits'),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                      trailing: Icon(Icons.more_vert),
                                      isThreeLine: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Database Loading",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    CircularProgressIndicator()
                  ],
                )),
    );
  }
}
