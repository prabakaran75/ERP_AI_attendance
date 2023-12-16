import 'dart:io';

import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/entity_factory.dart';
import '../widgets/cutom_textformfield_dropddownfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  bool visible = false;

  Future<void> showConfirmationDialog(BuildContext context) async {
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
        showConfirmationDialog(context);

        // Return false to prevent the default back button behavior
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
          body: Form(
            key: formKey,
            child: Stack(
              children: [
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration:  const BoxDecoration(
                      // color: ColorConstant.signupBgLight2,
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorConstant.aicolor,
                            ColorConstant.aithemecolor,
                            ColorConstant.aithemecolor1,
                          ]),
                    ),
                    child:  ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width*0.04,
                              right: width*0.04,
                              top: height*0.04
                              // bottom: height*0.4
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // "Hello!\nSign In",
                                "Sign In",
                                style: AppStyles.customFontinika(context,
                                    color: ColorConstant.whiteColorLight,
                                    fontSize: const AdaptiveTextSize()
                                        .getadaptiveTextSize(context, 30),
                                    fontWeight: FontWeight.w600),),
                              Container(
                                height: height*0.12,
                                decoration: BoxDecoration(
                                  color: ColorConstant.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  /*boxShadow: const [
                                    BoxShadow(
                                      spreadRadius: 3.5,
                                      blurRadius: 2,
                                      color: ColorConstant.whiteColorLight,
                                    )
                                  ]*/
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/stmarylogo.jpg',
                                    fit: BoxFit.cover,
                                    // height: height * 0.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height*0.3),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: ColorConstant.whiteColorLight,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width*0.04,
                              right: width*0.04,
                              top: height*0.08),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextFormField(
                                  controller: userName,
                                  focusNode: usernameFocusNode,
                                  onChanged: (value){
                                    setState(() {
                                      userName.selection = TextSelection.fromPosition(
                                          TextPosition(offset: userName.text.length));
                                    });},
                                  prefixIcon: const Icon(Icons.person),
                                  label: "User Name"),
                              SizedBox(height: height * 0.04,),
                              CustomTextFormField(
                                obsureText: !visible,
                                controller: password,
                                focusNode: passwordFocusNode,
                                onChanged: (value){
                                  setState(() {
                                    password.selection = TextSelection.fromPosition(
                                        TextPosition(offset: password.text.length));
                                  });},
                                label: "Password",
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      visible = !visible;
                                    });
                                  },
                                  icon: Icon(
                                    visible ? Icons.visibility : Icons.visibility_off,
                                    size: height*0.04,color: Colors.blueGrey,
                                  ),),
                              ),
                              /*SizedBox(height: height * 0.02,),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SplashScreen()),
                                  );
                                },
                                    child: Text('Forgot Password?',
                                      style: AppStyles.customFontinika(context,
                                        color: ColorConstant.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: const AdaptiveTextSize()
                                            .getadaptiveTextSize(context, 16),
                                      ),)),
                              ),*/
                              SizedBox(height: height * 0.05,),
                              Container(
                                width: width*1.0,
                                height: height*0.07,
                                decoration: BoxDecoration(
                                  color: ColorConstant.aicolor,
                                  borderRadius: BorderRadius.circular(5),),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                    /*  Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                                      );*/
                                      Navigator.pushReplacementNamed(context, "/Home");
                                    });
                                  },
                                  child: Text('Sign In',
                                    style: AppStyles.customFontinika(context,
                                      color: ColorConstant.whiteColorDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: const AdaptiveTextSize()
                                          .getadaptiveTextSize(context, 16),),),
                                ),
                              ),
                              SizedBox(height: height * 0.12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex:9,
                                    child: Text("Powered by Microhard Infotech L.L.C.",
                                      textAlign: TextAlign.center,
                                      style: AppStyles.customFontinika(context,
                                          color: ColorConstant.aicolor,
                                          fontSize: const AdaptiveTextSize()
                                              .getadaptiveTextSize(context, FontConstant.font14),
                                          fontWeight: FontWeight.w400),),
                                  ),
                                  Expanded(
                                    flex:1,
                                    child: ClipRRect(
                                      child: Image.asset(
                                        'assets/images/mhilogo.jpg',
                                        // fit: BoxFit.cover,
                                        height: height * 0.025,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.01,),
                              /*Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Don't have account?",
                                      style: AppStyles.customFontinika(context,
                                        color: ColorConstant.dullColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: const AdaptiveTextSize()
                                            .getadaptiveTextSize(context, 13),),),
                                    SizedBox(height: height * 0.01,),
                                    GestureDetector(
                                      onTap: (){
                                       */
                              /* Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => const SignUp()),);
                                          */
                              /*
                                      },
                                      child: Text("Sign Up",
                                        style: AppStyles.customFontinika(context,
                                          color: ColorConstant.primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: const AdaptiveTextSize()
                                              .getadaptiveTextSize(context, 20),),),
                                    ),
                                  ],
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        /*bottomSheet: Container(
          color: Colors.transparent,
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
        ),*/
      ),
    );
  }
}
