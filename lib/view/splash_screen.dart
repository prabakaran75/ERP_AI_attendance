import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/entity_factory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, "/SignIn");
    });
  }
  @override
  Widget build(BuildContext context) {
    /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );*/
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:  const BoxDecoration(
          // color: ColorConstant.primaryColorLight,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorConstant.aicolor,
                ColorConstant.aithemecolor,
                ColorConstant.aithemecolor1,
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/stmarylogo.jpg',
                      // fit: BoxFit.fill,
                      height: height * 0.15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height*0.05,),
            Text("MHI ",
            textAlign: TextAlign.center,
              style: AppStyles.customFontinika(context,
                  color: ColorConstant.whiteColorLight,
                  fontSize: const AdaptiveTextSize()
                      .getadaptiveTextSize(context, 25),
                  fontWeight: FontWeight.w700),),
            SizedBox(height: height*0.01,),
            Text("Attendance Management",
              textAlign: TextAlign.center,
              style: AppStyles.customFontinika(context,
                  color: ColorConstant.whiteColorLight,
                  fontSize: const AdaptiveTextSize()
                      .getadaptiveTextSize(context, 20),
                  fontWeight: FontWeight.w400),),
            /*RichText(
                text: const TextSpan(
                    text: "MHI AI ",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,
                      color: ColorConstant.whiteColorLight),
                  children: [
                    TextSpan(
                      text: "Attendance Management",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,
                          color: ColorConstant.whiteColorLight),
                    ),
                  ]
                ),
            ),*/
          ],
        ),
      ),
      bottomSheet: Container(
        color: ColorConstant.whiteColorLight,
        height: height * 0.04,
        width: width,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Powered by Microhard Infotech L.L.C.,",
                textAlign: TextAlign.center,
                style: AppStyles.customFontinika(context,
                    color: ColorConstant.aicolor,
                    fontSize: const AdaptiveTextSize()
                        .getadaptiveTextSize(context, FontConstant.font16),
                    fontWeight: FontWeight.w400),),
              ClipRRect(
                // borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/mhilogo.jpg',
                  fit: BoxFit.cover,
                  height: height * 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
