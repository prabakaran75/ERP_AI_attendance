
import 'package:flutter/material.dart';

// const Color login_bg = Color(0xFF7F8106);
// const Color login_bg = Color(0xB60E6580);
const Color login_bg = Color(0xff108268);
// const Color login_bg = Color(0xFF423A3A);
// const Color signup_bg = Color(0xFF000A54);
const Color signup_bg = Color(0xFF6e7c7d);

const double defpaultPadding = 16.0;
const Duration defaultDuration = Duration(milliseconds: 300);

abstract class ApplicationURL {
  static const String Login = "/api/Employee/Login"; 
}

class ColorConstant {
  // Light mode colors
  static Color transparent = Colors.transparent;
  static const Color loginBgLight = Color(0xFF05395B);
  static const Color signupBgLight = Color(0xFF000A54);
  static const Color primaryColorLight = Color(0xff9D1E01);
  static const Color primaryColor = Color(0xffE03200); //E03200FF
  static const Color primaryColor2 = Color(0xffd95b3c); //E03200FF
  static const Color primaryColor3 = Color(0xfffa9177); //E03200FF
  static const Color primaryColor4 = Color(0xfffab2a0); //E03200FF
  static const Color primaryDullColorLight =  Color(0x28f30304);
  static const Color darkColorLight =  Color(0xff000000);
  static Color onPageColor = Color(0xffCCA979);
  static const Color whiteColorLight =  Color(0xffFFFFFF);
  static const Color whiteColor =  Color(0xffd9d2d2);
  static const Color whiteColor2 =  Color(0xffc0b6b6);
  static const Color whiteColor3 =  Color(0xffb6a6a6);
  static const Color aicolor = Color(0xff4e3290);//#4e3290
  static const Color aithemecolor = Color(0xff563d96);
  static const Color aithemecolor1 = Color(0xFF8069B9);
  static const Color aithemecolor2 = Color(0xFF9E83D2);
  static const Color aithemecolor3 = Color(0xFFBFA8EC);
  static const Color aicolor2 = Color(0xff0002A1);//#0002A1

  // Dark mode colors
  static const Color loginBgDark =  Color(0xFF0A1428);
  static const Color signupBgDark =  Color(0xFF012540);
  static const Color primaryColorDark =  Color(0xff9D1E01);
  static const Color primaryDullColorDark =  Color(0x28FF6347);
  static const Color whiteColorDark =  Color(0xffFFFFFF);
  static Color dullColor = Colors.black54;
  static Color greenColor = const Color(0xff004D40);
  static const Color darkColorDark =  Color(0xff000000);//darkColorDark
}


class FontConstant {
  static int font10 = 10;
  static int font11 = 11;
  static int font12 = 12;
  static int font13 = 13;
  static int font14 = 14;
  static int font15 = 15;
  static int font16 = 16;
  static int font17 = 17;
  static int font18 = 18;
  static int font19 = 19;
  static int font20 = 20;
  static int font25 = 25;
  static int font30 = 25;
  static int font35 = 25;
}
