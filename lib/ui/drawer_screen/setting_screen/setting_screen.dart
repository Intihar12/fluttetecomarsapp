import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:kiwkemart/ui/address/save_adress.dart';
import 'package:kiwkemart/ui/profile/profile.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

class SettingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.appBackground,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: mediaQuery.height*0.15,
                width: mediaQuery.width,
                color: MyColors.darkBlue,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.size20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back_outlined,size: Dimens.size30,color: MyColors.white,)),
                      Text("Settings",style: TextStyle(
                        fontSize: Dimens.size24,
                        color: MyColors.white
                      ),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimens.size20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.size20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(MyImgs.profile,height: Dimens.size25,width: Dimens.size25,),
                        SizedBox(width: Dimens.size5,),
                        Text("Profile",style: TextStyle(
                          fontSize: Dimens.size16
                        ),),
                      ],
                    ),

                    Divider(
                      thickness: 1,
                      color: MyColors.grey,
                    ),
                    SizedBox(height: Dimens.size10,),
                    GestureDetector(
                      onTap: (){
                        Get.to(Profile(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 700),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Edit Profile",style: TextStyle(
                              fontSize: Dimens.size15,
                          color: MyColors.grey
                          ),),
                          Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                        ],
                      ),
                    ),
                    SizedBox(height: Dimens.size10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Change Password",style: TextStyle(
                            fontSize: Dimens.size15,
                            color: MyColors.grey
                        ),),
                        Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                      ],
                    ),
                    SizedBox(height: Dimens.size10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Privacy",style: TextStyle(
                            fontSize: Dimens.size15,
                            color: MyColors.grey
                        ),),
                        Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                      ],
                    ),
                    SizedBox(height: Dimens.size30,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(MyImgs.payment,height: Dimens.size25,width: Dimens.size25,),
                        SizedBox(width: Dimens.size5,),
                        Text("My Payment Options",style: TextStyle(
                            fontSize: Dimens.size16
                        ),),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: MyColors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Change or add a payment method",style: TextStyle(
                            fontSize: Dimens.size15,
                            color: MyColors.grey
                        ),),
                        Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                      ],
                    ),
                    SizedBox(height: Dimens.size30,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(MyImgs.address,height: Dimens.size25,width: Dimens.size25,),
                        SizedBox(width: Dimens.size5,),
                        Text("My Addresses",style: TextStyle(
                            fontSize: Dimens.size16
                        ),),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: MyColors.grey,
                    ),
                    SizedBox(height: Dimens.size10,),
                    GestureDetector(
                      onTap: (){
                        Get.to(SaveAddress(1),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(milliseconds: 700),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Add or delete an address",style: TextStyle(
                              fontSize: Dimens.size15,
                              color: MyColors.grey
                          ),),
                          Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                        ],
                      ),
                    ),
                    SizedBox(height: Dimens.size10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Change address",style: TextStyle(
                            fontSize: Dimens.size15,
                            color: MyColors.grey
                        ),),
                        Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
