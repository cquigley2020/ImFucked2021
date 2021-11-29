// ignore_for_file: unnecessary_string_escapes

class Students {
  final String id;
  final String fname;
  final String lname;
  final String studentID;

  Students._(this.id, this.fname, this.lname, this.studentID);

  factory Students.fromJson(Map json) {
    final id = json[""].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final fname = json['fname'];
    final lname = json['lname'];
    final studentID = json['studentID'];

    return Students._(id, fname, lname, studentID);
  }
}
