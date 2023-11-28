import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/attendance_report_model.dart';

class AttendanceReportController{
  List<AttendanceListModel> studentList = [];
  List<AttendanceListModel> studentAbsentList = [];
  int? totalStudents;
  int presentStudents = 0;
  int absentStudents = 0;

  Future attendanceList() async {
    try{
      var data = json.decode(
          await rootBundle.loadString('assets/lang/student_present_list.json'));
      studentList = List<AttendanceListModel>.from(data.map((item) => AttendanceListModel.fromJson(item)));
      totalStudents = studentList.length;
      for(var student in studentList){
        if(student.status == 'Present'){
          presentStudents++;
          // print("Present count -> $presentStudents");
        }
        else if(student.status == 'Absent'){
          absentStudents++;
          // print("Absent count -> $absentStudents");
        }
      }
      return;
    }catch(e){
      print("nbchbzhb=>$e");
    }
  }

}