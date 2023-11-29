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
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Form(
          key: formKey,
          child: Stack(
            children: [
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:  const BoxDecoration(
                    color: ColorConstant.primaryColorLight,
                    /*gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorConstant.signupBgLight,
                          ColorConstant.loginBgLight,
                        ]),*/
                  ),
                  child:  Padding(
                    padding: EdgeInsets.only(
                        left: width*0.04,
                        right: width*0.04,
                        bottom: height*0.7
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
                              'assets/images/mhilogo.png',
                              fit: BoxFit.cover,
                              // height: height * 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
                                prefixIcon: Icon(Icons.person),
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
                              prefixIcon: Icon(Icons.lock),
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
                                color: ColorConstant.primaryColorLight,
                                borderRadius: BorderRadius.circular(5),),
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                  /*  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                                    );*/
                                    Navigator.pushNamed(context, "/Home");
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
                            SizedBox(height: height * 0.09,),
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
      bottomSheet: Container(
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
      ),
    );
  }
}
