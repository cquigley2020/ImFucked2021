class Courses {
  final String id;
  final String courseName;
  final String courseInstrutor;
  final String courseCredits;

  Courses(this.id, this.courseName, this.courseInstrutor, this.courseCredits);

  factory Courses.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId("', '').replaceAll('"', '');
    final courseName = json['courseName'];
    final courseInstructor = json['courseInstructor'];
    final courseCredits = json['courseCredits'];

    return Courses(id, courseName, courseInstructor, courseCredits);
  }
}
