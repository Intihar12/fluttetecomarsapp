import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';

class TextBoxField extends StatelessWidget {
  TextEditingController controller;

  TextBoxField(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: MyColors.grey200.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5),
          border:
              Border.all(width: 0.5, color: MyColors.black.withOpacity(0.5))),
      child: Center(
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            FocusScope.of(context).nextFocus();
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(1), // for mobile
          ],
          enableInteractiveSelection: false,
          style: TextStyle(
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
