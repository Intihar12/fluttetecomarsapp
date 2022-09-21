import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/custom_textfield.dart';

class PaymentFailed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: MyColors.black),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 25,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.size12, 0, Dimens.size12, Dimens.size12),
          child: Column(
            children: [
              SizedBox(
                height: Dimens.size50,
              ),
              Image.asset(MyImgs.failed),
              SizedBox(
                height: Dimens.size30,
              ),
              Text(
                "Transaction Failed",
                style: textTheme.headline3!
                    .copyWith(fontSize: 24, color: Colors.red),
              ),
              SizedBox(
                height: Dimens.size14,
              ),
              Text(
                "Try again using different payment details or contcat customer support for help.",
                style: textTheme.caption!.copyWith(
                    fontSize: 14, color: MyColors.black.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Dimens.size30,
              ),
              CustomButton(
                height: 0.06,
                width: 0.7,
                text: "Try Again",
                onPressed: () {
                  Get.back();
                },
                roundCorner: 5,
                color: MyColors.white,
                borderColor: MyColors.primaryColor,
                textColor: MyColors.primaryColor,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
