

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';

class RoundButton extends StatelessWidget {
  String text;
  Color color;
  Color textColor;

  RoundButton({
    required this.text,
    required  this.color,
    required this.textColor
  });



  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
        height: mediaQuery.height*0.065,
        width: mediaQuery.width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(
              color: MyColors.grey200.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )]
        ),
        child: Center(
          child: Text(
              text,
              style: textTheme.subtitle1!.copyWith(
                  color:textColor,
                  fontSize: 20
              )
          ),
        )

    );
  }
}
