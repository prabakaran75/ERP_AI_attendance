import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/constants.dart';
import '../constants/entity_factory.dart';
import 'package:intl/intl.dart';

import '../controller/attendance_report_controller.dart';
import '../model/attendance_report_model.dart';

class AttendanceReport extends StatefulWidget {
  final String className;
  const AttendanceReport({super.key, required this.className,});

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {

  late DateTime _currentTime;
  late Timer _timer;
  int? totalStd;
  int presentStd = 0;
  int absentStd = 0;

  String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentTime = DateTime.now();
    attendanceReportController = AttendanceReportController();
    _startTimer();
    fetchData();
  }


  AttendanceReportController attendanceReportController = AttendanceReportController();
  List<AttendanceListModel> studentAbsentList = [];
  List<AttendanceListModel> selectedStudentList = [];
  List<AttendanceListModel> studentPresentList = [];
  Future<void> fetchData() async {
    try {
      await attendanceReportController.attendanceList();
      setState(() {

        totalStd = attendanceReportController.totalStudents;
        presentStd = attendanceReportController.presentStudents;
        absentStd = attendanceReportController.absentStudents;

        studentPresentList = attendanceReportController.studentList
            .where((student) => student.status=='Present').toList();
        // studentPresentList.sort((a,b)=>a.title!.compareTo(b.title!));
        studentAbsentList = attendanceReportController.studentList
            .where((absent) => absent.status=='Absent').toList();
        // studentAbsentList.sort((a,b)=>a.title!.compareTo(b.title!));

      });
    } catch (e) {
      print("Error occurred: $e");
    }
  }
  void updateStudentStatus(String studentTitle, bool newValue) {
    setState(() {
      for (var student in attendanceReportController.studentList) {
        if (student.title == studentTitle) {
          student.isSelected = newValue;
          if (newValue) {
            selectedStudentList.add(student);
          }else {
            selectedStudentList.remove(student);
          }
          break;
        }
      }
    });
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: ColorConstant.aicolor,
      textColor: ColorConstant.whiteColorLight,
      fontSize: const AdaptiveTextSize()
          .getadaptiveTextSize(context, FontConstant.font15),
      webPosition: "center",
    );
  }

  Future<void> showConfirmationDialog() async {
    return showDialog<void>(
      // barrierColor: ColorConstant.whiteColorLight,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Attendance',
              style: AppStyles.customFontinika(context,
                  color: ColorConstant.darkColorLight,
                  fontSize: const AdaptiveTextSize()
                      .getadaptiveTextSize(context, FontConstant.font20),
                  fontWeight: FontWeight.w400)),
          content: Text('Are you sure you want to proceed?',
              style: AppStyles.customFontinika(context,
                  color: ColorConstant.darkColorLight,
                  fontSize: const AdaptiveTextSize()
                      .getadaptiveTextSize(context, FontConstant.font15),
                  fontWeight: FontWeight.w400)),
          actions: <Widget>[
            TextButton(
              child: Text('Yes',
                  style: AppStyles.customFontinika(context,
                      color: ColorConstant.aicolor,
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, FontConstant.font15),
                      fontWeight: FontWeight.w400)),
              onPressed: () {
                print("Yes pressed");
                bool studentsMoved = false;
                setState(() {
                  for (var student in selectedStudentList) {
                    if (studentAbsentList.contains(student)) {
                      studentAbsentList.remove(student);
                      studentPresentList.add(student);
                      student.isSelected = true;
                      studentsMoved = true;
                      absentStd--;
                      presentStd++;
                    }
                  }
                  selectedStudentList.clear(); // Clear the list after moving students
                  Navigator.pushReplacementNamed(context, "/Home");
                  print("Navigation executed");
                  // Navigator.of(context).pop(false);
                });
                if(studentsMoved){
                  showToast('Submitted successfully');
                }
              },
            ),
            TextButton(
              child: Text('No',
                  style: AppStyles.customFontinika(context,
                      color: ColorConstant.aicolor,
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, FontConstant.font15),
                      fontWeight: FontWeight.w400)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      /*bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width*0.02,
          vertical: height*0.01,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Date : ",
                  style: AppStyles.customFontinika(context,
                      color: ColorConstant.darkColorLight,
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, FontConstant.font15),
                      fontWeight: FontWeight.w400),),
                Text(getCurrentDate(),
                  style: AppStyles.customFontinika(context,
                      color: ColorConstant.darkColorLight,
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, FontConstant.font15),
                      fontWeight: FontWeight.w400),),
              ],
            ),
            Row(
              children: [
                Text("Time : ",
                  style: AppStyles.customFontinika(context,
                      color: ColorConstant.darkColorLight,
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, FontConstant.font15),
                      fontWeight: FontWeight.w400),),
                Text(_formatTime(_currentTime),
                  style: AppStyles.customFontinika(context,
                      color: ColorConstant.darkColorLight,
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, FontConstant.font15),
                      fontWeight: FontWeight.w400),),
              ],
            ),
          ],
        ),
      ),*/
      bottomNavigationBar: Container(
        height: height*0.15,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ColorConstant.whiteColorLight,),
        child: Padding(
          padding: EdgeInsets.only(
            top: height*0.01,
            right: width*0.02,
            left: width*0.02),
          child: Column(
            children: [
              Container(
                width: width*1.0,
                height: height*0.07,
                decoration: BoxDecoration(
                  color: ColorConstant.aicolor,
                  borderRadius: BorderRadius.circular(5),),
                child: TextButton(
                  onPressed: () {
                    /*bool studentsMoved = false;
                    setState(() {
                      for (var student in selectedStudentList) {
                        if (studentAbsentList.contains(student)) {
                          studentAbsentList.remove(student);
                          studentPresentList.add(student);
                          student.isSelected = true;
                          studentsMoved = true;
                          absentStd--;
                          presentStd++;
                        }
                      }
                      selectedStudentList.clear(); // Clear the list after moving students
                    });
                    if(studentsMoved){
                      showToast('Submitted successfully');
                    }*/
                    showConfirmationDialog();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: ColorConstant.aicolor, // Text color
                    padding: EdgeInsets.symmetric(
                      horizontal: width*0.035,
                      vertical: height*0.02,),),
                  child: Text('Submit',
                    style: AppStyles.customFontinika(context,
                        color: ColorConstant.whiteColorLight,
                        fontSize: const AdaptiveTextSize()
                            .getadaptiveTextSize(context, FontConstant.font15),
                        fontWeight: FontWeight.w400),),
                ),
              ),
              SizedBox(height: height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Date : ",
                        style: AppStyles.customFontinika(context,
                            color: ColorConstant.darkColorLight,
                            fontSize: const AdaptiveTextSize()
                                .getadaptiveTextSize(context, FontConstant.font15),
                            fontWeight: FontWeight.w400),),
                      Text(getCurrentDate(),
                        style: AppStyles.customFontinika(context,
                            color: ColorConstant.aicolor,
                            fontSize: const AdaptiveTextSize()
                                .getadaptiveTextSize(context, FontConstant.font15),
                            fontWeight: FontWeight.w400),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Time : ",
                        style: AppStyles.customFontinika(context,
                            color: ColorConstant.darkColorLight,
                            fontSize: const AdaptiveTextSize()
                                .getadaptiveTextSize(context, FontConstant.font15),
                            fontWeight: FontWeight.w400),),
                      Text(_formatTime(_currentTime),
                        style: AppStyles.customFontinika(context,
                            color: ColorConstant.aicolor,
                            fontSize: const AdaptiveTextSize()
                                .getadaptiveTextSize(context, FontConstant.font15),
                            fontWeight: FontWeight.w400),),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: ColorConstant.aicolor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Attendance Confirm",
              style: AppStyles.customFontinika(context,
                  color: ColorConstant.whiteColorLight,
                  fontSize: const AdaptiveTextSize()
                      .getadaptiveTextSize(context, 20),
                  fontWeight: FontWeight.w600),),
            Text(
              widget.className,
              style: AppStyles.customFontinika(context,
                  color: ColorConstant.whiteColorLight,
                  fontSize: const AdaptiveTextSize()
                      .getadaptiveTextSize(context, 20),
                  fontWeight: FontWeight.w600),),
          ],
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        height: height*0.8,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height*0.01,),
          child: ListView(
            shrinkWrap: true,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: studentAbsentList.isNotEmpty ? studentAbsentList.length : 0,
                itemBuilder: (context, index) {
                  var absent = studentAbsentList[index];
                  return CheckboxListTile(
                    activeColor: Colors.green,
                    title: Row(
                      children: [
                        const CircleAvatar(
                          radius: 15,
                          child: Icon(Icons.person,
                          color: ColorConstant.aicolor,size: 20,),),
                        SizedBox(width: width*0.02),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(absent.title ?? '',
                              style: AppStyles.customFontinika(context,
                                  color: absent.isSelected==true?
                                  Colors.green:ColorConstant.primaryColor,
                                  fontSize: const AdaptiveTextSize()
                                      .getadaptiveTextSize(context, 13.5),
                                  fontWeight: FontWeight.w400),),
                            Text(absent.subTitle ?? '',
                              style: AppStyles.customFontinika(context,
                                  color: absent.isSelected==true?
                                  Colors.green:ColorConstant.primaryColor,
                                  fontSize: const AdaptiveTextSize()
                                      .getadaptiveTextSize(context, 12),
                                  fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ],
                    ),
                    value: absent.isSelected,
                    onChanged: (newValue) {
                      setState(() {
                        updateStudentStatus(absent.title ?? '', newValue ?? false);
                      });
                    },
                  );
                },
              ),
              const Divider(thickness: 1,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: studentPresentList.isNotEmpty ?
                    studentPresentList.length : 0,
                    itemBuilder: (context, index) {
                      var student = studentPresentList[index];
                      return ListTile(
                        title: Row(
                          children: [
                            const CircleAvatar(
                              radius: 15,
                              child: Icon(Icons.person,
                                color: ColorConstant.aicolor,size: 20,),),
                            SizedBox(width: width*0.02),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(student.title.toString(),
                                  style: AppStyles.customFontinika(context,
                                    color: Colors.green,
                                    fontSize: const AdaptiveTextSize()
                                        .getadaptiveTextSize(context, FontConstant.font14),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(student.subTitle.toString(),
                                  style: AppStyles.customFontinika(context,
                                    color: Colors.green,
                                    fontSize: const AdaptiveTextSize()
                                        .getadaptiveTextSize(context, FontConstant.font13),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              /*Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.02),
                child: Container(
                  width: width*1.0,
                  height: height*0.07,
                  decoration: BoxDecoration(
                    color: ColorConstant.primaryColorLight,
                    borderRadius: BorderRadius.circular(5),),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        for (var student in selectedStudentList) {
                          if (studentAbsentList.contains(student)) {
                            studentAbsentList.remove(student);
                            studentPresentList.add(student);
                            student.isSelected = true;

                            showToast('Submitted successfully');

                            absentStd--;
                            presentStd++;
                          }
                        }
                        selectedStudentList.clear(); // Clear the list after moving students
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColorLight, // Text color
                      padding: EdgeInsets.symmetric(
                        horizontal: width*0.035,
                        vertical: height*0.02,),),
                    child: Text('Submit',
                      style: AppStyles.customFontinika(context,
                          color: ColorConstant.whiteColorLight,
                          fontSize: const AdaptiveTextSize()
                              .getadaptiveTextSize(context, FontConstant.font15),
                          fontWeight: FontWeight.w400),),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
