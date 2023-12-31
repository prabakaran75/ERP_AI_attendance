import 'package:flutter/material.dart';
import 'package:mhi_ai_attendance/view/attendance_report.dart';
import 'package:mhi_ai_attendance/view/home_screen.dart';
import 'package:mhi_ai_attendance/view/signin_screen.dart';
import 'package:mhi_ai_attendance/view/splash_screen.dart';

void main() {
  runApp(
    /*DevicePreview(
                enabled: !kReleaseMode,
                builder: (context) => MyApp(),),*/
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MHI Attendance',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,),
      // home: const SplashScreen(),
      initialRoute: "/",
      routes: {
        "/": (context) =>  const SplashScreen(),
        "/SignIn": (context) =>  const SignInScreen(),
        "/Home": (context) =>  const HomeScreen(),
        // "/AttendanceReport": (context) =>  const AttendanceReport(),
      },
    );
  }
}

