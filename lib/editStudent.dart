// ignore_for_file: no_logic_in_create_state, file_names, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import './CoursesAPI.dart';
import './main.dart';

class EditStudent extends StatefulWidget {
  final String id, fname, lname, studentID;

  final CoursesAPI api = CoursesAPI();

  EditStudent(this.id, this.fname, this.lname, this.studentID);

  //const EditCourse({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  _EditStudentState createState() =>
      _EditStudentState(id, fname, lname, studentID);
}

class _EditStudentState extends State<EditStudent> {
  final String id, fname, lname, studentID;

  _EditStudentState(this.id, this.fname, this.lname, this.studentID);

  void editStudentByFname(id, fname) {
    widget.api.editStudentByFname(id, fname);
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  title: 'School App',
                )));
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fname),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            editStudentByFname(
                                widget.fname, nameController.text),
                          },
                      child: const Text("Change first name")),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.home),
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
