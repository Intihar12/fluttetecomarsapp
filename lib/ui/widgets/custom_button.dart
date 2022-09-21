import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double ? roundCorner;
  final String text;
  final double ? fontSize;
  final Color ? color;
  final Color ? textColor;
  final Color ? borderColor;
  void Function() onPressed;
  CustomButton({
    required this.height,
    required this.width,
    required this.text,
    this.fontSize,
    this.borderColor,
    this.textColor,
    this.roundCorner,
    this.color,
    required this.onPressed,
    Key? key,

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var textTheme=theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return MaterialButton(
      elevation: 0,
      color: color==null ? Get.theme.colorScheme.primary: color,
      height: mediaQuery.height*height,
      minWidth: mediaQuery.width*width,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor==null ? Get.theme.colorScheme.primary : borderColor!),
        borderRadius: BorderRadius.circular(roundCorner== null ?8: roundCorner!),
      ),
      onPressed: onPressed,
      child: Text(text,style: TextStyle(color: textColor==null ? theme.colorScheme.onPrimary : textColor!,
          fontSize: fontSize == null ? 18 : fontSize,
          fontWeight: FontWeight.w500),),);
  }
}