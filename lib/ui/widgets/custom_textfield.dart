import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';

class CustomTextField extends StatelessWidget {


  final String text;
  final int length;
  final TextInputType   keyboardType;
  final TextInputFormatter   inputFormatters;
  bool ? Readonly=false;
  final Icon ? icon;
  final InputBorder ? border;
  final String ? errorText;
  final FocusNode ? focusNode;
  final String ? suffixtext;
  final Color ? hintColor;
final int  ?maxLine;
  TextEditingController ? controller;
  FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;
  FormFieldSetter<String>? onSaved;
  CustomTextField({Key? key,
    this.controller,
    this.border,
this.onSaved,
    this.maxLine,
    required this.text,
    this.validator,
    this.onChanged,
    this.errorText,
    this.Readonly,
    this.focusNode,
    this.hintColor,
    this.icon,
    this.suffixtext,
    required this.length,
    required this.keyboardType,
    required this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var textTheme=theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;

    return TextFormField(
onSaved: onSaved,
      maxLines: maxLine==null?1 :maxLine,
      maxLength: length,
      cursorHeight: 25,
      focusNode: focusNode,
      validator: validator,
      style:  textTheme.bodyText2!.copyWith(),
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: <TextInputFormatter>[inputFormatters],
      textInputAction: TextInputAction.next,
      readOnly: Readonly==true ? true : false,
      decoration: InputDecoration(
        errorText: errorText,
        counterText: "",
        border: border,
        hintText: text ,
        hintStyle: TextStyle(color: hintColor),
        contentPadding: const EdgeInsets.only(left: 8, bottom: 10),
        prefixIcon: icon,

        suffixText: suffixtext ,

        focusColor: MyColors.green50,
      ),
    );
  }
}