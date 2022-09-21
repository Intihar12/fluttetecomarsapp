import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_textfield.dart';

class ChatSupport extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var textTheme=theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Order Status"),
          ],
        ),
        elevation: 0,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.size12),
          child: Container(
            height: mediaQuery.height*0.845,
            width: mediaQuery.width*1.0,
              // color: MyColors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        height: Dimens.size48,
                        width: Dimens.size230,
                        decoration: BoxDecoration(
                            color: MyColors.grey200,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimens.size12),
                                topLeft: Radius.circular(Dimens.size12),
                                topRight: Radius.circular(Dimens.size12))
                        ),
                      ),
                      Container(
                        height: Dimens.size48,
                        width: Dimens.size230,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimens.size12),
                              topLeft: Radius.circular(Dimens.size12),
                              topRight: Radius.circular(Dimens.size12))
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Container(
                     height: Dimens.size40,
                     width: Dimens.size280 ,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(Dimens.size20),
                         color: MyColors.grey200
                     ),
                     child: Padding(
                       padding: const EdgeInsets.only(bottom: Dimens.size20 ),
                       child: CustomTextField(
                         text: "Type message", length: 1000, keyboardType: TextInputType.text,
                         inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
                         border: InputBorder.none,

                       ),
                     ),
                   ),
                    Container(
                      height: Dimens.size42,
                      width: Dimens.size42,
                      decoration: BoxDecoration(
                        color:  theme.primaryColor,

                        shape: BoxShape.circle,
                      ),
                      child:  Image.asset(MyImgs.clip, height: Dimens.size30, width: Dimens.size30,)
                    ),

                  ],
                ),



              ],
            ),


          ),
        ),
      ),
    ));
  }
}
