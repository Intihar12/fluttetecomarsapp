import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/auth_controller/auth_controller.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/auth/components/header.dart';
import 'package:kiwkemart/ui/auth/login/login.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/widgets/country_picker.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/custom_textfield.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final AuthController controller = Get.put(AuthController());

  var visi = false.obs;
  var textShow = true.obs;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          HeaderAPP(
            title: 'Sign Up',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size15),
            child: Form(
              key: controller.signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimens.size70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: mediaQuery.width * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name',
                              style: Get.textTheme.bodyText2!.copyWith(
                                  color: MyColors.textPrivacy,
                                  fontWeight: FontWeight.normal),
                            ),
                            CustomTextField(
                                text: 'jhon',
                                length: 50,
                                keyboardType: TextInputType.text,
                                controller: controller.firstNameController,
                                validator: (value) {
                                  return controller.validation
                                      .validateFirstName(
                                    value!,
                                  );
                                },
                                inputFormatters:
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z- ]'))),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.width * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Name',
                              style: Get.textTheme.bodyText2!.copyWith(
                                  color: MyColors.textPrivacy,
                                  fontWeight: FontWeight.normal),
                            ),
                            CustomTextField(
                                text: 'jhon',
                                length: 50,
                                keyboardType: TextInputType.text,
                                controller: controller.lastNameController,
                                validator: (value) {
                                  return controller.validation.validateLatName(
                                    value!,
                                  );
                                },
                                inputFormatters:
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z- ]'))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //    SizedBox(height: Dimens.size10,),

                  //  SizedBox(height: Dimens.size10,),
                  Text(
                    'Email',
                    style: Get.textTheme.bodyText2!.copyWith(
                        color: MyColors.textPrivacy,
                        fontWeight: FontWeight.normal),
                  ),
                  CustomTextField(
                      text: 'abc@gmail.com',
                      length: 50,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      validator: (value) {
                        return controller.validation.emailValidation(value!);
                      },
                      inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone',
                  style: Get.textTheme.bodyText2!.copyWith(
                      color: MyColors.textPrivacy,
                      fontWeight: FontWeight.normal),
                ),
                CustomTextField(
                    text: SingleToneValue.instance.userPhone,
                    length: 20,
                    keyboardType: TextInputType.phone,
                    Readonly: true,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter),
              ],
            ),
          ),
          SizedBox(
            height: Dimens.size15,
          ),
          Obx(() {
            return Visibility(
              visible: textShow.value,
              child: GestureDetector(
                onTap: () {
                  visi.value = true;
                  textShow.value = false;
                },
                child: Text(
                  'I have a Referal Code',
                  style: Get.textTheme.headline5!
                      .copyWith(color: Get.theme.primaryColor),
                ),
              ),
            );
          }),
          Obx(() {
            return Visibility(
              visible: visi.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Referral Code from friend',
                      style: Get.textTheme.bodyText2!.copyWith(
                          color: MyColors.textPrivacy,
                          fontWeight: FontWeight.normal),
                    ),
                    CustomTextField(
                        text: 'Enter refer Code',
                        length: 50,
                        keyboardType: TextInputType.text,
                        controller: controller.referController,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                  ],
                ),
              ),
            );
          }),
          SizedBox(
            height: Dimens.size40,
          ),
          CustomButton(
            text: 'Sign UP',
            width: 0.7,
            height: 0.06,
            roundCorner: Dimens.size8,
            onPressed: () {
              controller.onSignUPButton();
            },
          ),
          SizedBox(
            height: Dimens.size12,
          ),
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text('Already have an account?',
          //
          //       style: Get.textTheme.bodyText1!.copyWith(
          //         color: Get.theme.colorScheme.secondaryVariant,
          //         fontWeight: FontWeight.normal
          //
          //       ),
          //       ),
          //       SizedBox(width: Dimens.size4,),
          //       GestureDetector(
          //           onTap: (){
          //             Get.to(Login());
          //           },
          //           child: Text('Login',
          //             style: Get.textTheme.bodyText1!.copyWith(
          //                 color: MyColors.textPrivacy,
          //            fontWeight: FontWeight.normal
          //
          //             ),
          //
          //           )),
          //
          //
          //     ],
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'By continuing you agree to our',
                style: Get.textTheme.bodyText1!.copyWith(
                    color: MyColors.textPrivacy,
                    fontWeight: FontWeight.normal,
                    fontSize: 8),
              ),
              SizedBox(
                width: 2,
              ),
              GestureDetector(
                onTap: () {},
                child: Text('privacy policy',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: MyColors.textPrivacy,
                        fontWeight: FontWeight.normal,
                        fontSize: 8)),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                'and',
                style: Get.textTheme.bodyText1!.copyWith(
                    color: MyColors.textPrivacy,
                    fontWeight: FontWeight.normal,
                    fontSize: 8),
              ),
              SizedBox(
                width: 2,
              ),
              GestureDetector(
                onTap: () {},
                child: Text('Terms and condition',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: MyColors.textPrivacy,
                        fontWeight: FontWeight.normal,
                        fontSize: 8)),
              )
            ],
          ),

          //   SizedBox(height: Dimens.size12,),
        ],
      ),
    ));
  }
}
