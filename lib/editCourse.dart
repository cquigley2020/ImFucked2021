// ignore_for_file: no_logic_in_create_state, file_names, use_key_in_widget_constructors, camel_case_types, prefer_const_constructors, annotate_overrides

import 'package:flutter/material.dart';
import './CoursesAPI.dart';
import './main.dart';
import './editStudent.dart';

class editCourse extends StatefulWidget {
  final String id, courseName, courseInstructor, courseCredits;
  final CoursesAPI api = CoursesAPI();

  editCourse(
      this.id, this.courseName, this.courseInstructor, this.courseCredits);

  @override
  _editCourseState createState() =>
      _editCourseState(id, courseName, courseInstructor, courseCredits);
}

class _editCourseState extends State<editCourse> {
  final String id, courseName, courseInstructor, courseCredits;

  _editCourseState(
      this.id, this.courseName, this.courseInstructor, this.courseCredits);

  List students = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllStudents().then((data) {
      setState(() {
        students = data;
        _dbLoaded = true;
      });
    });
  }

  void deleteCourseById(id) {
    setState(() {
      widget.api.editStudentByFname(id, courseName);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    title: 'School App',
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () => {
                            deleteCourseById(id),
                          },
                      child: Text("Delete Course")),
                ],
              ),
            ),
            Center(
                child: _dbLoaded
                    ? Column(
                        children: [
                          SizedBox(
                              height: 1000,
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(11.0),
                                children: [
                                  ...students
                                      .map<Widget>(
                                        (students) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: TextButton(
                                            onPressed: () => {
                                              Navigator.pop(context),
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditStudent(
                                                              students['id'],
                                                              students['fname'],
                                                              students['lname'],
                                                              students[
                                                                  'studentID']))),
                                            },
                                            child: ListTile(
                                              title: Text(
                                                students['studentID'] +
                                                    " - " +
                                                    students['fname'] +
                                                    "  " +
                                                    students['lname'],
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ],
                              )),
                        ],
                      )
                    : Column()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {
                Navigator.pop(context),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(
                              title: 'School App',
                            ))),
              }),
    );
  }
}
