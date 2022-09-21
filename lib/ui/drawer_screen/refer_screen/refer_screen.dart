import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/refer_controller/refer_controller.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';

class ReferScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery
        .of(context)
        .size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return GetBuilder<ReferCodeController>(
      init: ReferCodeController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: mediaQuery.height*0.15,
                  width: mediaQuery.width,
                  color: Get.theme.primaryColor,
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
                            child: Row(
                              children: [

                                Icon(Icons.arrow_back_outlined,
                                  size: Dimens.size30,color: MyColors.white,),

                                Padding(
                                  padding: const EdgeInsets.only(left: 100),
                                  child: Text("Refer and Earn",
                                    style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w500,
                                        color: MyColors.white
                                    ),
                                  ),
                                )

                              ],
                            )),

                        Text("Invite a friend and get, \$50 Reward",textAlign: TextAlign.center,
                          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w500,
                          color: MyColors.white.withOpacity(0.8)
                          ),)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimens.size50,
                ),
                Center(child: Image.asset(MyImgs.referPic, height: mediaQuery.height*0.2,width: mediaQuery.width*0.6,)),
                SizedBox(
                  height: Dimens.size50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.size30),
                  child: Text("Share your code with friends to give them"
                      " \$50 off products (limited to \$500 order)"
                      " valid for 30 days. When they place there "
                      "first order you will get \$50 off products,",
                    textAlign: TextAlign.justify,
                  style: textTheme.caption!.copyWith(fontSize: 14),

                  ),
                ),
                SizedBox(
                  height: Dimens.size50,
                ),
                Center(
                 child: Container(
                   height: mediaQuery.height*0.07,
                   width: mediaQuery.width*0.3,
                   decoration: BoxDecoration(
                     border: Border.all(width: 1,color: Get.theme.primaryColor),
                     borderRadius: BorderRadius.circular(Dimens.size50)
                   ),
                   child: Center(
                     child: Obx(()=>
                        Text(controller.referCode.value,style: TextStyle(
                         fontWeight: FontWeight.w500,
                         fontSize: Dimens.size18,
                         color: Get.theme.primaryColor
                       ),),
                     ),
                   ),
                 ),
               ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.size30),
                  child: Center(child: CustomButton(height: 0.065, width: 0.8, text: 'Share Your Code', onPressed: (){
                    print('refercode:${controller.referCode}');
                    controller.share();

                  },roundCorner: Dimens.size5,)),
                ),
                SizedBox(
                  height: Dimens.size20,
                ),

              ],
            ),
          ),
        );
      }
    );
  }
}
