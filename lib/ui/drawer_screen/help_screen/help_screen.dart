import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

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
                        Text("Help Center",style: TextStyle(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimens.size15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Customer Service Contact",style: TextStyle(
                              fontSize: Dimens.size15,
                              color: MyColors.grey
                          ),),
                          Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                        ],
                      ),
                      SizedBox(height: Dimens.size15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Terms and conditions",style: TextStyle(
                              fontSize: Dimens.size15,
                              color: MyColors.grey
                          ),),
                          Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                        ],
                      ),
                      SizedBox(height: Dimens.size15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Terms of Use",style: TextStyle(
                              fontSize: Dimens.size15,
                              color: MyColors.grey
                          ),),
                          Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                        ],
                      ),
                      SizedBox(height: Dimens.size15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Privacy Note",style: TextStyle(
                              fontSize: Dimens.size15,
                              color: MyColors.grey
                          ),),
                          Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                        ],
                      ),
                      SizedBox(height: Dimens.size15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cookies Policy",style: TextStyle(
                              fontSize: Dimens.size15,
                              color: MyColors.grey
                          ),),
                          Icon(Icons.navigate_next_sharp,color: MyColors.grey,)
                        ],
                      ),
                      SizedBox(height: Dimens.size15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("FAQ’s",style: TextStyle(
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
            )),
      ),
    );
  }
}
