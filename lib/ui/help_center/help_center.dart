import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_fonts.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/values/styles.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Help Center',

                style: Get.textTheme.headline4!.copyWith(
                  color: MyColors.white,

                ),
              ),
            ),
            body:
        SingleChildScrollView(
          child: Column(
            children: [
             SizedBox(height: 25,),

              Center(
                child: SizedBox(height: 230,
                child: Image.asset(MyImgs.helpCenterImg),
                ),
              ),
              SizedBox(height: 25,),
              Text('How can we help you?',
              style: Get.textTheme.headline1!.copyWith(
                color: MyColors.primaryColor,
                fontSize: 24
              ),

              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('It looks like you are experiencing some problems with the app. We are here to help so please get in touch with us',
                textAlign: TextAlign.center,
                style: Get.textTheme.subtitle2!.copyWith(
                  color: MyColors.textVColor.withOpacity(0.5)
                ),
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 70,
                   color: MyColors.cardColor,
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                      Icon(Icons.mail_outline,
                      size: 30,
                        color: MyColors.primaryColor,
                      ),
                    SizedBox(width: 15,),
                    Text('Email Us',
                      style: Get.textTheme.subtitle2!.copyWith(
                          color: MyColors.textVColor.withOpacity(0.5)
                      ),
                    ),
                  ],
                ),
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 70,
                  color: MyColors.cardColor,
                  child: Row(
                    children: [
                      SizedBox(width: 15,),
                      Icon(Icons.phone,
                        size: 30,
                        color: MyColors.primaryColor,
                      ),
                      SizedBox(width: 15,),
                      Text('Contact Us',
                        style: Get.textTheme.subtitle2!.copyWith(
                            color: MyColors.textVColor.withOpacity(0.5)
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
        )
    );
  }
}
