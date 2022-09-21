import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/auth_controller/auth_controller.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/widgets/round_button.dart';
import 'package:kiwkemart/ui/widgets/textBoxField.dart';

class PhoneVerification extends StatelessWidget {
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_sharp)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                ),

                Center(
                  child: Text(
                    'Verify OTP',
                    style: textTheme.headline1!
                        .copyWith(color: MyColors.primaryColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Enter the 6 digit code sent to you at ${SingleToneValue.instance.userPhone}',
                    style: textTheme.bodyText1
                        ?.copyWith(fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15 - 10,
                        child: TextBoxField(controller.firstController)),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15 - 10,
                        child: TextBoxField(controller.secondController)),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15 - 10,
                        child: TextBoxField(controller.thirdController)),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15 - 10,
                        child: TextBoxField(controller.fourthController)),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15 - 10,
                        child: TextBoxField(controller.fifthController)),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.15 - 10,
                        child: TextBoxField(controller.sixthController)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //  model!.timerValue! > 0?
                InkWell(
                  onTap: () {
                    controller.verifyPhone(SingleToneValue.instance.userPhone);
                  },
                  child: Text("Resend Code In",
                      // +model.timerValue.toString(),
                      style: textTheme.headline6!
                          .copyWith(fontWeight: FontWeight.w400)),
                ),

                Spacer(),

                GestureDetector(
                    onTap: () {
                      controller.otpButton();
                    },
                    child: RoundButton(
                        text: 'Verify OTP',
                        color: Get.theme.colorScheme.primary,
                        textColor: Colors.white)),

                SizedBox(
                  height: 20,
                ),
              ]),
        ),
      ),

      // )
    );
  }
}
