import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';

class VoucherScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
           // backgroundColor: MyColors.darkBlue,
            leading: GestureDetector(
              onTap: (){
                Get.back();
              },
                child: Icon(Icons.arrow_back_outlined,size: Dimens.size30,)),
            title: Text("My Vouchers",style: TextStyle(
              fontSize: Dimens.size18,
            ),),
          ),
          backgroundColor: MyColors.appBackground,
          body:Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.size20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: Dimens.size30,),
                Container(
                  height: mediaQuery.height*0.8,
                  width: mediaQuery.width,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: 10,
                    separatorBuilder: (context, index) => SizedBox(height: Dimens.size15,),
                    itemBuilder:(context, index) {
                      return Container(
                        height: mediaQuery.height*0.18,
                        decoration: BoxDecoration(
                          color: MyColors.cardColor,
                          borderRadius: BorderRadius.circular(Dimens.size5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimens.size10,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: Dimens.size10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("vf56gstws",style:
                                     Get.textTheme.headline4!.copyWith(
                                   fontWeight: FontWeight.w700,
                                     color:MyColors.textVColor
                                     )
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Rs.250.00",style: TextStyle(
                                        fontSize: Dimens.size14,
                                      ),),
                                      SizedBox(height: 10,),
                                      Text("Rs 5000.00 minimum",style: Get.textTheme.subtitle1!.copyWith(
                                          color:MyColors.textVColor.withOpacity(0.5)
                                      )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimens.size10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Valid until",style: TextStyle(
                                          fontSize: Dimens.size12,
                                          color: MyColors.textVColor.withOpacity(0.5)
                                      ),),
                                      SizedBox(width: Dimens.size5,),
                                      Text("17 Oct 21",style: TextStyle(
                                        fontSize: Dimens.size14,
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimens.size10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Terms & conditions apply",style: TextStyle(
                                      fontSize: Dimens.size10,
                                      color: Get.theme.primaryColor
                                  ),),
                                  Text("Expired",style: TextStyle(
                                    fontSize: Dimens.size15,
                                    color: MyColors.textVColor.withOpacity(0.5)
                                  ),),
                                ],
                              ),
                              SizedBox(height: Dimens.size10,),

                            ],
                          ),
                        ),
                      );
                    },

                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
