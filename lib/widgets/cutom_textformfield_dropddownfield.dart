import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../constants/entity_factory.dart';

class CustomTextFormField extends StatefulWidget {
  bool? obsureText;
  TextEditingController controller;
  FocusNode focusNode;
  Function(dynamic) onChanged;
  Widget? prefixIcon, suffixIcon;
  String label;
  CustomTextFormField({this.obsureText = false,required this.controller,
    required this.focusNode, this.suffixIcon, this.prefixIcon,
    required this.onChanged, required this.label, Key? key}): super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      obscureText: widget.obsureText!,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        isDense: true,
        labelText: widget.label,
        labelStyle: AppStyles.customFontinika(context,
          color: widget.focusNode.hasFocus == true
              ? ColorConstant.greenColor
              : ColorConstant.dullColor,
          fontWeight: FontWeight.w400,
          fontSize: const AdaptiveTextSize()
              .getadaptiveTextSize(context, 13),),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstant.dullColor),),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstant.greenColor),),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstant.dullColor),),
        errorMaxLines: 1,
      ),
      style: AppStyles.customFontinika(context,
        color: ColorConstant.darkColorDark,
        fontSize: const AdaptiveTextSize()
            .getadaptiveTextSize(context, 15),),
      onChanged: (v) => widget.onChanged(v),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}


class CustomDropDownFormField extends StatefulWidget {
  String label;
  List<DropdownMenuItem<String>> items;
  dynamic value;
  Function(dynamic) onChanged;
  CustomDropDownFormField({required this.label, required this.items,
    required this.value, required this.onChanged, super.key});

  @override
  State<CustomDropDownFormField> createState() => _CustomDropDownFormFieldState();
}

class _CustomDropDownFormFieldState extends State<CustomDropDownFormField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DropdownButtonFormField(
      // iconSize: 0.0,
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: AppStyles.customFontinika(context,
          color: ColorConstant.dullColor,
          fontSize: const AdaptiveTextSize()
              .getadaptiveTextSize(context, 13),),
        contentPadding: EdgeInsets.symmetric(
            vertical: size.height*0.02,
            horizontal: size.width*0.03),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstant.dullColor),),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstant.greenColor),),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorConstant.dullColor),),
      ),
      items: widget.items,
      value:widget.value,
      onChanged: (v) => widget.onChanged(v),
      validator: (value) {
        if (value == null) {
          return 'Please select some value';
        }
        return null;
      },
    );
  }
}