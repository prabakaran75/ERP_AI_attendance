import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/bloc_listener_notifier/mhi_bloc.dart';
import 'constants.dart';


abstract class Gaps {
  static Widget empty = const SizedBox();
  static Widget divider = const Divider();

  static Widget vGap(double height) {
    return SizedBox(height: height);
  }

  static Widget hGap(double width) {
    return SizedBox(width: width);
  }
}

abstract class AppUtils {
  static void showToast(BuildContext context, String message, int i) {
    if (message.toString() != "null" && message != '') {
      BotToast.showText(
          text: message,
          contentColor: Theme.of(context).hintColor,
          duration: Duration(seconds: i),
          textStyle: TextStyle(
              fontSize: 14, height: 1.5, color: Theme.of(context).scaffoldBackgroundColor),
          align: Alignment.center);
    }
  }

  void showProgressBar(BuildContext context) {
    final progressManager1 = Provider.of<ProgressManager>(context, listen: false);
    progressManager1.showProgress();
    // Perform your asynchronous operation here...
    progressManager1.hideProgress();
  }

}
abstract class AppStyles {
  static TextStyle customFontinika(BuildContext context,
      {double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? textDecoration,
      Color? color,
      String? fontFamily}) {
    color ??= Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;
    return
        //   TextStyle(
        //   color: color,
        //   fontFamily: "Calibri",
        //   fontSize: fontSize ?? 14,
        //   fontWeight: fontWeight,
        //   fontStyle: fontStyle,
        //   decoration: textDecoration,
        // );
        GoogleFonts.inika(
      color: color,
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: textDecoration,
    );
  }

  static TextStyle customFontopenSansRoboto(BuildContext context,
      {double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      TextDecoration? textDecoration,
      Color? color,
      String? fontFamily}) {
    color ??= Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;
    return GoogleFonts.roboto(
      color: color,
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: textDecoration,
    );
  }

  static InputDecoration InputDecorationWidget(
      {required BuildContext context, required String hintText}) {
    return InputDecoration(
      hintText: hintText.isNotEmpty ? hintText : "Enter your main domain",
      hintStyle: AppStyles.customFontinika(context,
          color: Colors.black12, fontSize: 12.0, fontWeight: FontWeight.normal),
      counterText: "",
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
    );
    ;
  }

  static progress(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  static exitApp(Size screenSize, BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text('Are you sure to Exit?',
                style: AppStyles.customFontinika(context,
                    color: Theme.of(context).hintColor,
                    fontSize:
                        const AdaptiveTextSize().getadaptiveTextSize(context, 16),
                    fontWeight: FontWeight.bold)),
            actions: [
              InkWell(
                child: Text(
                  "No",
                  style: AppStyles.customFontinika(context,
                    color: Theme.of(context).hintColor,
                    fontSize: double.tryParse(FontConstant.font14.toString()),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal, ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 30.0,
              ),
              InkWell(
                child: Text(
                  "Yes",
                  style: AppStyles.customFontinika(context,
                    color: Theme.of(context).hintColor,
                    fontSize: double.tryParse(FontConstant.font14.toString()),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal, ),
                ),
                onTap: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (Platform.isIOS) {
                    exit(0);
                  }
                },
              ),
              const SizedBox(
                width: 20.0,
              ),
            ],
          );
        }).then((exit) {
      if (exit == null) return;

      if (exit) {
        // user pressed Yes button
      } else {
        // user pressed No button
      }
    });
  }

  static Future logoutPopUp(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Colors.white,
          title: Text(
            "Are you sure you want to Logout from the application?",
            textAlign: TextAlign.center,
            style: AppStyles.customFontinika(context,
                color: Theme.of(context).hintColor,
                fontSize: double.tryParse(FontConstant.font18.toString()),
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal, ),
          ),
          actionsPadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "No",
                        style: AppStyles.customFontinika(context,
                          color: Theme.of(context).hintColor,
                          fontSize: double.tryParse(FontConstant.font18.toString()),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal, ),
                      ),
                    ),
                    onTap: () {
                      return Navigator.pop(context, 'empty');
                    },
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Yes",
                        style: AppStyles.customFontinika(context,
                          color: Theme.of(context).hintColor,
                          fontSize: double.tryParse(FontConstant.font18.toString()),
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal, ),
                      ),
                    ),
                    onTap: () {
                      return Navigator.pop(context, 'yes');
                    },
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  static bool onBackPressed(BuildContext context) {
    // Show the exit app dialog when back button is pressed
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit App',
              style: AppStyles.customFontinika(context,
                  color: Theme.of(context).hintColor,
                  fontSize: const AdaptiveTextSize()
                      .getadaptiveTextSize(context, FontConstant.font15),
                  fontWeight: FontWeight.w400),
          ),
          content: Text('Do you want to exit the app?',
            style: AppStyles.customFontinika(context,
                color: Theme.of(context).hintColor,
                fontSize: const AdaptiveTextSize()
                    .getadaptiveTextSize(context, FontConstant.font15),
                fontWeight: FontWeight.w400),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Close the dialog and prevent back navigation
              child: Text('No',
                style: AppStyles.customFontinika(context,
                    color: Theme.of(context).hintColor,
                    fontSize: const AdaptiveTextSize()
                        .getadaptiveTextSize(context, FontConstant.font15),
                    fontWeight: FontWeight.w400),
              ),
            ),
            TextButton(
              onPressed: () => exit(0), // Close the dialog and allow back navigation
              child:  Text('Yes',
                style: AppStyles.customFontinika(context,
                    color: Theme.of(context).hintColor,
                    fontSize: const AdaptiveTextSize()
                        .getadaptiveTextSize(context, FontConstant.font15),
                    fontWeight: FontWeight.w400),),
            ),
          ],
        );
      },
    );

    // Return false to prevent immediate back navigation without showing the exit app dialog
    return false;
  }

  static Future<String?> showAppPermission(BuildContext context) {
      return
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Icon(Icons.location_on_outlined,
          //       color: Theme.of(context).primaryColor,),
          //     Text('Use your location',
          //         style: AppStyles.customFontinika(context,
          //             color: Theme.of(context).hintColor,
          //             fontSize: const AdaptiveTextSize()
          //                 .getadaptiveTextSize(context, FontConstant.font15),
          //             fontWeight: FontWeight.w400),
          //     ),
          //   ],
          // ),
          content: Text('MHI Lite 2.0 is developed to enable field employees and managers to Punch In and Punch Out while they are out on duty. It requires access to their location during the punch to calculate working hours and attendance.'
              '\n\nCamera and external storage permissions are required, as they are needed to capture and store photos when the user Punches In or Punches Out.'
              '\n\nIf the user chooses to Punch In/Punch Out using a fingerprint, the app uses the phone\'s default fingerprint sensor to authenticate the user.'
              '\n\nThe Phone state permission is used to obtain the device\'s unique identification number.',
            style: AppStyles.customFontinika(context,
                color: Theme.of(context).hintColor,
                fontSize: const AdaptiveTextSize()
                    .getadaptiveTextSize(context, FontConstant.font15),
                fontWeight: FontWeight.w400),
          ),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     return Navigator.of(context).pop("false");
            //   }, // Close the dialog and prevent back navigation
            //   child: Text('Cancel',
            //     style: AppStyles.customFontinika(context,
            //         color: Theme.of(context).hintColor,
            //         fontSize: const AdaptiveTextSize()
            //             .getadaptiveTextSize(context, FontConstant.font15),
            //         fontWeight: FontWeight.w400),
            //   ),
            // ),
            TextButton(
              onPressed: () {
                return Navigator.of(context).pop("true");
              }, // Close the dialog and allow back navigation
              child:  Text('Continue',
                style: AppStyles.customFontinika(context,
                    color: Theme.of(context).hintColor,
                    fontSize: const AdaptiveTextSize()
                        .getadaptiveTextSize(context, FontConstant.font15),
                    fontWeight: FontWeight.w400),),
            ),
          ],
        );
      },
    );
    // return "";
  }
  static Future<String?> showAppPermissionRequired(BuildContext context, String content, bool boolval) {
      return
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: boolval == true ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined,
                color: Theme.of(context).primaryColor,),
              Text('This app requires location permission.',
                  style: AppStyles.customFontinika(context,
                      color: Theme.of(context).hintColor,
                      fontSize: const AdaptiveTextSize()
                          .getadaptiveTextSize(context, FontConstant.font15),
                      fontWeight: FontWeight.w400),
              ),
            ],
          ): const SizedBox(height: 0.0, width: 0.0,),
          content: Text(content,
            style: AppStyles.customFontinika(context,
                color: Theme.of(context).hintColor,
                fontSize: const AdaptiveTextSize()
                    .getadaptiveTextSize(context, FontConstant.font15),
                fontWeight: FontWeight.w400),
          ),
          actions: [
            boolval == true ? TextButton(
              onPressed: () {
                return Navigator.of(context).pop("false");
              }, // Close the dialog and prevent back navigation
              child: Text('Close the app',
                style: AppStyles.customFontinika(context,
                    color: Theme.of(context).hintColor,
                    fontSize: const AdaptiveTextSize()
                        .getadaptiveTextSize(context, FontConstant.font15),
                    fontWeight: FontWeight.w400),
              ),
            ): const SizedBox(height: 0.0, width: 0.0,),
            boolval == true ? TextButton(
              onPressed: () {
                return Navigator.of(context).pop("true");
              }, // Close the dialog and allow back navigation
              child:  Text('Go to Settings',
                style: AppStyles.customFontinika(context,
                    color: Theme.of(context).hintColor,
                    fontSize: const AdaptiveTextSize()
                        .getadaptiveTextSize(context, FontConstant.font15),
                    fontWeight: FontWeight.w400),),
            ): const SizedBox(height: 0.0, width: 0.0,),
          ],
        );
      },
    );
    // return "";
  }

  static Future<bool?> showDialogWindow(BuildContext context,
      {String? title, Function? onTapyes, String? success, String? cancel}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title ?? "Do you want to Sign Out?",
            style: AppStyles.customFontinika(context,
                color: Theme.of(context).hintColor, fontWeight: FontWeight.w800),
          ),
          actions: <Widget>[
            OutlinedButton(
              // color: Theme.of(context).primaryColorLight,
              // splashColor: Theme.of(context).primaryColorLight,
              child: Text(
                cancel ?? "No",
                style: AppStyles.customFontinika(context, fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            Gaps.vGap(10),
            OutlinedButton(
              // color: Theme.of(context).primaryColor,
              // splashColor: Theme.of(context).primaryColorLight,
                onPressed: onTapyes as void Function()?,
              // color: Theme.of(context).primaryColor,
              // splashColor: Theme.of(context).primaryColorLight,
                child: Text(
                  success ?? "Yes",
                  style: AppStyles.customFontinika(context,
                      fontSize: 16, color: Colors.redAccent),
                ))
          ],
        );
      },
    );
  }

}



class AdaptiveTextSize {
  const AdaptiveTextSize();
  getadaptiveTextSize(BuildContext context, dynamic value) {
    final mediaQuery = MediaQuery.of(context);
    if (mediaQuery.size.width > 1024) {
      return (value / 1024) * MediaQuery.of(context).size.height;
    }
    if (mediaQuery.size.width > 332) {
      return (value / 720) * MediaQuery.of(context).size.height;
    }
    // 720 is medium screen height
    return (value / 720) * MediaQuery.of(context).size.height;
  }

  double calculateDiagonalSize(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    return sqrt((width * width) + (height * height));
  }

  bool isTablet(BuildContext context) {
    final double diagonalSize = calculateDiagonalSize(context);
    return diagonalSize >= 1100.0; // Adjust this threshold as needed.
  }
}
