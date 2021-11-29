// ignore_for_file: file_names, unused_import

import 'package:dio/dio.dart';
import './Models/courses.dart';
import './Models/students.dart';

const String localhost = "http://10.0.2.2:1200/";

class CoursesAPI {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getAllCourses() async {
    final response = await _dio.get('/getAllCourses');

    return response.data['courses'];
  }

  Future getAllStudents() async {
    final response = await _dio.post('/getAllStudents');
    return response.data['students'];
  }

  Future deleteCourseById(String id) async {
    await _dio.post('deleteCourseById', data: {'_id': id});
  }

  Future editStudentByFname(String id, String fname) async {
    await _dio.post('editStudentByFname', data: {'_id': id, 'fname': fname});
  }
}
