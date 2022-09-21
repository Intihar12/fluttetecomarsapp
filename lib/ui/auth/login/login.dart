import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/auth_controller/auth_controller.dart';
import 'package:kiwkemart/data/controller/auth_controller/login_controller.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/auth/components/header.dart';
import 'package:kiwkemart/ui/auth/signup/signup.dart';
import 'package:kiwkemart/ui/deliveryAddress/delivery_address.dart';
import 'package:kiwkemart/ui/home/guest/guest_homepage.dart';

import 'package:kiwkemart/ui/values/values.dart';
import 'package:kiwkemart/ui/widgets/country_picker.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/custom_textfield.dart';
import 'package:kiwkemart/ui/widgets/progress_bar.dart';

import '../delivery_location_set.dart';
import '../otp_screen.dart';

class Login extends StatelessWidget {
  LoginController controller = Get.put(LoginController());

  var code = '+44';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderAPP(
                title: 'Login ',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.size30),
                child: Container(
                  child: Form(
                    key: controller.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimens.size80,
                        ),
                        Text(
                          'Enter your mobile number',
                          style: Get.textTheme.headline1!
                              .copyWith(color: MyColors.textPrivacy),
                        ),
                        SizedBox(
                          height: Dimens.size25,
                        ),
                        Text(
                          'Please confirm your country code and enter\nyour mobile number',
                          style: Get.textTheme.subtitle2!.copyWith(
                            color: MyColors.hintText.withOpacity(0.52),
                          ),
                        ),
                        SizedBox(
                          height: Dimens.size40,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Country Code',
                                style: Get.textTheme.subtitle2!.copyWith(
                                  color: MyColors.hintText.withOpacity(0.52),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: Dimens.size10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.grey),
                                      )),
                                      child: CountryCodePicker(
                                        onChanged: controller.onCountryChange,
                                        showFlag: true,
                                        initialSelection: 'UK',
                                        favorite: ['+44', 'UK'],
                                        showCountryOnly: false,
                                        showOnlyCountryWhenClosed: false,
                                        alignLeft: false,
                                        showDropDownButton: true,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: CustomTextField(
                                          text: 'Mobile Number',
                                          length: 10,
                                          controller: controller.noController,
                                          onSaved: (value) {
                                            SingleToneValue.instance.number =
                                                value!;
                                          },
                                          validator: (value) {
                                            return controller.validateFiled(
                                                value!,
                                                'Please Enter Mobile Number');
                                          },
                                          onChanged: (value) {
                                            {
                                              SingleToneValue.instance.number =
                                                  value;
                                              controller.update();
                                            }
                                          },
                                          keyboardType: TextInputType.phone,
                                          inputFormatters:
                                              FilteringTextInputFormatter
                                                  .singleLineFormatter),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimens.size50,
                        ),
                        Center(
                          child: CustomButton(
                            text: 'Continue',
                            width: 0.9,
                            height: 0.06,
                            roundCorner: Dimens.size5,
                            onPressed: () {
                              Get.dialog(ProgressBar());
                              controller.onContinueButtonClick();
                            },
                          ),
                        ),
                        SizedBox(
                          height: Dimens.size30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.arrow_forward_outlined),
                              SizedBox(
                                width: Dimens.size8,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    controller.onSkip();
                                  },
                                  child: Text(
                                    "Skip",
                                    style: Get.textTheme.headline5!
                                        .copyWith(color: MyColors.black),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              //  CustomTextField(text: text, length: length, keyboardType: keyboardType, inputFormatters: inputFormatters)
            ],
          ),
        ),
      ),
    );
  }
}
