import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kiwkemart/data/controller/profile_controller/profile_controller.dart';
import 'package:kiwkemart/ui/auth/components/custom_shape.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/custom_textfield.dart';

class Profile extends StatelessWidget {
  ProfileController profileController=Get.put(ProfileController());
  bool textReadable =true;
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var textTheme=theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(

      body: GetBuilder<ProfileController>(
        builder:(value)=> SingleChildScrollView(
          child: Container(
            height: mediaQuery.height*0.845,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    ShapeOfView(
                      color: LinearGradient(
                            colors: [
                              //  Get.theme.colorScheme.onSecondary,
                              Get.theme.colorScheme.primary,
                              MyColors.gradient1
                              ],
                              begin: const FractionalOffset(0.0, 1.0),
                              end: const FractionalOffset(0.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                      height: 250,
                      width: mediaQuery.width,
                      shape: ArcShape(
                        direction: ArcDirection.Outside,
                        height: 30,
                        position: ArcPosition.Bottom,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(
                            height: mediaQuery.height*0.1,
                            decoration: BoxDecoration(
                              color: MyColors.grey100,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ClipOval(
                                  child: Image.asset(MyImgs.deliveryBike, height: 20,)),
                            ),
                          ),
                          Text('${value.firstName.text} ${value.secondName.text}',
                            style: Get.textTheme.headline1!.copyWith(
                              color: Get.theme.colorScheme.onPrimary,
                              //  fontWeight: FontWeight.normal
                            ),
                          ),
                        ],
                      ),
                    ),
                    textReadable==false ? const Text("") :Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Edit Profile"),
                        IconButton(
                            onPressed: (){
                                textReadable=false;
                                value.myFocusNode.requestFocus();
                                value.update();

                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding:  EdgeInsets.only(left: Dimens.size12, right: Dimens.size12,),
                  child: Container(
                    height: mediaQuery.height*0.4,
                    width: mediaQuery.height*1.0,
                    //color: MyColors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textReadable == true ?  Text("First Name", style: textTheme.headline2,) : Text("First Name", style: textTheme.headline3,),
                        CustomTextField(

                            Readonly: textReadable,
                            text: "Enter first name",
                            focusNode: value.myFocusNode,
                            controller: value.firstName,
                            length: 50,
                            keyboardType: TextInputType.text,
                            inputFormatters: FilteringTextInputFormatter.allow(RegExp('[a-zA-Z- ]'))
                        ),
                        textReadable == true ?  Text("Second Name",style: textTheme.headline2,) : Text("Second Name", style: textTheme.headline3,),
                        CustomTextField(

                            Readonly: textReadable,
                            controller: value.secondName,
                            text: "Enter second name",
                            length: 50,
                            keyboardType: TextInputType.text,
                            inputFormatters: FilteringTextInputFormatter.allow(RegExp('[a-zA-Z- ]'))
                        ),
                        textReadable == true ? Text("Email", style: textTheme.headline2,) : Text("Email", style: textTheme.headline3,),
                        Form(

                          child: CustomTextField(

                              Readonly: textReadable,
                              controller: value.email,
                              text: "Enter email",
                              length: 50,
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: FilteringTextInputFormatter.singleLineFormatter
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CustomButton( height: 0.06,
                    width: 1.0,
                    text: textReadable == true ? "Done" : "Save",
                    onPressed: (){
                      textReadable == true ? Get.back() : Get.snackbar(
                        "Profile Updated",
                        "Your profiled is updated",
                      );
                        textReadable=true;
                   value.update();
                    },
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
