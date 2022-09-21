
import 'package:flutter/material.dart';
import 'package:kiwkemart/ui/values/dimens.dart';

import 'otptext.dart';

class OtpTextField extends StatefulWidget {
  final Function(String) onCodeEnter;

  OtpTextField({required this.onCodeEnter});

  @override
  _OtpTextFieldState createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  late FocusNode pin1fn;
  late FocusNode pin2fn;
  late FocusNode pin3fn;
  late FocusNode pin4fn;
  late FocusNode pin5fn;
  late FocusNode pin6fn;

  @override
  void initState() {
    pin1fn = FocusNode();
    pin2fn = FocusNode();
    pin3fn = FocusNode();
    pin4fn = FocusNode();
    pin5fn = FocusNode();
    pin6fn = FocusNode();
    // _onVerifyCode();
    super.initState();
  }

  @override
  void dispose() {
    pin2fn.dispose();
    pin3fn.dispose();
    pin4fn.dispose();
    pin5fn.dispose();
    pin6fn.dispose();
    super.dispose();
  }

  void nextfocus({String? value, FocusNode? focusNode}) {
    if (value!.length == 1) {
      focusNode!.requestFocus();
    }
  }

  void backfocus({String? value, FocusNode? focusNode}) {
    if (value!.length == 0) {
      focusNode!.requestFocus();
    }
  }

  final oneText = TextEditingController();
  final twoText = TextEditingController();
  final threeText = TextEditingController();
  final fourText = TextEditingController();
  final fiveText = TextEditingController();
  final sixText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // pin6fn.addListener(_onOnFocusNodeEvent);
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.size1, bottom: Dimens.size1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: TextFieldWidget(
                focusNode: pin1fn,
                controller: oneText,
                onchanged: (value) {
                  nextfocus(value: value, focusNode: pin2fn);
                }),
          ),
          Flexible(
            flex: 1,
            child: TextFieldWidget(
                controller: twoText,
                focusNode: pin2fn,
                onchanged: (value) {
                  nextfocus(value: value, focusNode: pin3fn);
                  backfocus(value: value, focusNode: pin1fn);
                }),
          ),
          Flexible(
            flex: 1,
            child: TextFieldWidget(
                controller: threeText,
                focusNode: pin3fn,
                onchanged: (value) {
                  nextfocus(value: value, focusNode: pin4fn);
                  backfocus(value: value, focusNode: pin2fn);
                }),
          ),
          Flexible(
            flex: 1,
            child: TextFieldWidget(
                controller: fourText,
                focusNode: pin4fn,
                onchanged: (value) {
                  nextfocus(value: value, focusNode: pin5fn);

                  backfocus(value: value, focusNode: pin3fn);
                }),
          ),
          Flexible(
            flex: 1,
            child: TextFieldWidget(
                controller: fiveText,
                focusNode: pin5fn,
                onchanged: (value) {
                  nextfocus(value: value, focusNode: pin6fn);

                  backfocus(value: value, focusNode: pin4fn);
                }),
          ),
          Flexible(
            flex: 1,
            child: TextFieldWidget(
                controller: sixText,
                focusNode: pin6fn,
                onchanged: (value) {
                  String pin = oneText.text.toString() +
                      twoText.text.toString() +
                      threeText.text.toString() +
                      fourText.text.toString() +
                      fiveText.text.toString() +
                      sixText.text.toString();
                  backfocus(value: value, focusNode: pin5fn);
                  widget.onCodeEnter(pin);
                  // pin6fn.unfocus();
                }),
          ),
        ],
      ),
    );
  }
}
