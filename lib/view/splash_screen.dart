import 'package:flutter/material.dart';
import 'package:mhi_ai_attendance/view/signin_screen.dart';

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
    /*  Navigator.push(
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
          color: ColorConstant.primaryColorLight,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: height*0.30,
                  decoration: const BoxDecoration(
                      color: ColorConstant.primaryColor2,
                      shape: BoxShape.circle),
                  child: Center(
                    child: Container(
                      height: height*0.26,
                      decoration: const BoxDecoration(
                          color: ColorConstant.primaryColor3,
                          shape: BoxShape.circle),
                      child: Center(
                        child: Container(
                          height: height*0.22,
                          decoration: const BoxDecoration(
                              color: ColorConstant.primaryColor4,
                              shape: BoxShape.circle),
                          child: Center(
                            child: Container(
                              height: height*0.18,
                              decoration: const BoxDecoration(
                                color: ColorConstant.whiteColorLight,
                                shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/mhilogo.png',
                                    // fit: BoxFit.fill,
                                    // height: height * 0.05,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height*0.05,),
            Text("MHI AI",
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
          child: Text("Provided by @Microhard Infotech L.L.C.,",
            textAlign: TextAlign.center,
            style: AppStyles.customFontinika(context,
                color: ColorConstant.primaryColorLight,
                fontSize: const AdaptiveTextSize()
                    .getadaptiveTextSize(context, FontConstant.font15),
                fontWeight: FontWeight.w400),),
        ),
      ),
    );
  }
}
