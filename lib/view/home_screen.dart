import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mhi_ai_attendance/view/signin_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/constants.dart';
import '../constants/entity_factory.dart';
import '../widgets/cutom_textformfield_dropddownfield.dart';
import 'attendance_report.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? className;
  String? period;
  String? subject;
  List<String> classList = [
    'Class-1',
    'Class-2',
    'Class-3',
    'Class-4',
    'Class-5',
  ];
  /*List<String> periodList = [
    '1st',
    '2nd',
    '3rd',
    '4rd',
    '5rd',
    '6rd',
    '7rd',
    '8rd',];
  List<String> subjectList = [
    'Sub1',
    'Sub2',
    'Sub3',
    'Sub4',
    'Sub5',
    'Sub6',
  ];*/
  String? scanBarcode;
  TextEditingController qrCtrl = TextEditingController();
  Future<void> checkAndRequestCameraPermission() async {
    if (await Permission.camera.isGranted) {
      scanQr();
    } else {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        scanQr();
      } else {
        print("Camera permission is required to scan barcodes.");
      }
    }
  }
  Future scanQr()async{
    String barcodeScanRes;
    try{
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#FC2947', 'Cancel', true , ScanMode.QR);
      if(barcodeScanRes == "-1"){
        showToast("Scan Cancelled");
        setState(() {
          // barcodeScanRes = "Scan Canceled";
          scanBarcode = "";
        });
      }else{
        setState(() {
          scanBarcode = barcodeScanRes;
          if(scanBarcode != null){
            setState(() {
              // Navigator.pushNamed(context, "/AttendanceReport");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    const AttendanceReport(className: "Class-2",)),
              );
            });
          }
          // showToast(scanBarcode.toString());
        });
      }
    }on PlatformException{
      barcodeScanRes = 'Failed to get platform version';
      showToast("Unable to read");
    }
  }
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: ColorConstant.signupBgLight,
      textColor: ColorConstant.whiteColorDark,
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
          title: Text('Logout',
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
            TextButton(
              child: Text('Yes',
                  style: AppStyles.customFontinika(context,
                      color: ColorConstant.aicolor,
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, FontConstant.font15),
                      fontWeight: FontWeight.w400)),
              onPressed: () {
                // Perform the navigation
                // Navigator.pushReplacementNamed(context, "/SignIn");
                // Exit the application
                // Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pop(false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showConfirmationDialog2(BuildContext context) async {
    return showDialog<void>(
      // barrierColor: ColorConstant.whiteColorLight,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit',
              style: AppStyles.customFontinika(context,
                  color: ColorConstant.darkColorLight,
                  fontSize: const AdaptiveTextSize()
                      .getadaptiveTextSize(context, FontConstant.font20),
                  fontWeight: FontWeight.w400)),
          content: Text('Are you sure you want to Exit the app?',
              style: AppStyles.customFontinika(context,
                  color: ColorConstant.darkColorLight,
                  fontSize: const AdaptiveTextSize()
                      .getadaptiveTextSize(context, FontConstant.font15),
                  fontWeight: FontWeight.w400)),
          actions: <Widget>[
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
            TextButton(
              child: Text('Yes',
                  style: AppStyles.customFontinika(context,
                      color: ColorConstant.aicolor,
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, FontConstant.font15),
                      fontWeight: FontWeight.w400)),
              onPressed: () {
                // Exit the application
                // Navigator.of(context).popUntil((route) => route.isFirst);
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        // Show confirmation dialog
        setState(() {
          showConfirmationDialog2(context);
        });
        // Return false to prevent the default back button behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstant.aicolor,
          title: Column(
            children: [
              Text(
                "Will Smith",
                style: AppStyles.customFontinika(context,
                    color: ColorConstant.whiteColorLight,
                    fontSize: const AdaptiveTextSize()
                        .getadaptiveTextSize(context, 18),
                    fontWeight: FontWeight.w600),),
              Text(
                "Professor",
                style: AppStyles.customFontinika(context,
                    color: ColorConstant.whiteColorLight,
                    fontSize: const AdaptiveTextSize()
                        .getadaptiveTextSize(context, 14),
                    fontWeight: FontWeight.w600),),
              // SizedBox(height: height*0.01,),
            ],
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                onPressed: (){
                  showConfirmationDialog();
                },
                icon: const Icon(Icons.logout,
                  color: ColorConstant.whiteColorLight,)),
          ],
        ),
        body: Form(
          key:  formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: width*0.02,
                    left: width*0.02,
                    top: height*0.01,
                ),
                child: Column(
                  children: [
                   /* Text(
                      "Manual",
                      textAlign: TextAlign.center,
                      style: AppStyles.customFontinika(context,
                          color: ColorConstant.aicolor,
                          fontSize: const AdaptiveTextSize()
                              .getadaptiveTextSize(context, 20),
                          fontWeight: FontWeight.w600),),*/
                    SizedBox(height: height*0.02,),
                    CustomDropDownFormField(
                      label: "Select class",
                      items: classList.map((item) =>
                          DropdownMenuItem(
                            value: item,
                            child: Text(item, style: AppStyles.customFontinika(context,
                              color: ColorConstant.signupBgLight,
                              fontSize: const AdaptiveTextSize()
                                  .getadaptiveTextSize(context, 13),),),
                          ),
                      ).toList(),
                      value: className,
                      onChanged: (value){
                        setState(() {
                          className = value.toString();
                        });},
                      validators: (value){
                        if (value == null) {
                          return 'Please select a class';
                        }
                        return null;},
                    ),
                    /*SizedBox(height: height*0.02,),
                    CustomDropDownFormField(
                      label: "Select period",
                      items: periodList.map((item) =>
                          DropdownMenuItem(
                            value: item,
                            child: Text(item, style: AppStyles.customFontinika(context,
                              color: ColorConstant.signupBgLight,
                              fontSize: const AdaptiveTextSize()
                                  .getadaptiveTextSize(context, 13),),),
                          ),
                      ).toList(),
                      value: period,
                      onChanged: (value){
                        setState(() {
                          period = value.toString();
                        });},
                      validators: (value){
                        if (value == null) {
                          return 'Please select a period';
                        }
                        return null;},
                    ),
                    SizedBox(height: height*0.03,),
                    CustomDropDownFormField(
                      label: "Select subject",
                      items: subjectList.map((item) =>
                          DropdownMenuItem(
                            value: item,
                            child: Text(item, style: AppStyles.customFontinika(context,
                              color: ColorConstant.signupBgLight,
                              fontSize: const AdaptiveTextSize()
                                  .getadaptiveTextSize(context, 13),),),
                          ),
                      ).toList(),
                      value: subject,
                      onChanged: (value){
                        setState(() {
                          subject = value.toString();
                        });},
                      validators: (value){
                        if (value == null) {
                          return 'Please select a subject';
                        }
                        return null;},
                    ),*/
                    SizedBox(height: height*0.07,),
                    Text(
                      "OR",
                      textAlign: TextAlign.center,
                      style: AppStyles.customFontinika(context,
                          color: ColorConstant.aicolor,
                          fontSize: const AdaptiveTextSize()
                              .getadaptiveTextSize(context, 20),
                          fontWeight: FontWeight.w600),),
                    SizedBox(height: height*0.05,),
                    IconButton(
                        onPressed: (){
                          checkAndRequestCameraPermission();
                        },
                        icon: Icon(Icons.qr_code_scanner,
                          size: height*0.25,
                        )),
                    SizedBox(height: height*0.03,),
                    Container(
                      width: width*1.0,
                      height: height*0.07,
                      decoration: BoxDecoration(
                        color: ColorConstant.aicolor,
                        borderRadius: BorderRadius.circular(5),),
                      child: TextButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    AttendanceReport(className: className.toString(),)),
                              );
                              // Navigator.pushNamed(context, "/AttendanceReport");
                            });
                          }
                        },
                        child: Text('Submit',
                          style: AppStyles.customFontinika(context,
                            color: ColorConstant.whiteColorDark,
                            fontWeight: FontWeight.w600,
                            fontSize: const AdaptiveTextSize()
                                .getadaptiveTextSize(context, 16),),),
                      ),
                    ),
                    SizedBox(height: height*0.01,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
