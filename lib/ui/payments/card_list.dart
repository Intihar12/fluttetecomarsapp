
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/paymentcard_controller/paymentcard_controller.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/values/strings.dart';
import 'package:kiwkemart/ui/values/ui_size_config.dart';

import 'new_card_add.dart';



class SavedCards extends StatelessWidget {
  const SavedCards({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(" My Cards",

        style: Get.textTheme.headline4!.copyWith(
          color: MyColors.white
        ),
        ),
      ),
      body: GetBuilder<PaymentCardController>(
        init:PaymentCardController() ,
        builder: (controller) {
          return
              controller.isLoading ?Center(child:
              CircularProgressIndicator()):
              controller.cardListModel == null
              ?Column(
                children: [
                  SizedBox(height: 200,),
                  Text('No Card Added',
                  style:  Get.textTheme.headline1!.copyWith(
                    color: Get.theme.primaryColor
                  ),
                  ),
                  SizedBox(
                    height: getHeight(30),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AddNewCard());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          height: getHeight(Dimens.size45),
                          width: getWidth(mediaQuery.width),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimens.size5),
                              border:
                              Border.all(color: MyColors.primaryColor, width: 0.5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: MyColors.primaryColor),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Icon(Icons.add,
                                  size: 20,
                                  color: MyColors.primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: getWidth(20),
                              ),
                              Text(
                                'Add card',
                                style: Get.textTheme.headline3!.copyWith(
                                    color: MyColors.primaryColor
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              )
           : Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
            child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getHeight(Dimens.size30),
                ),
                SizedBox(
                  height: getHeight(Dimens.size20),
                ),

                Container(
                  height: getHeight(500),
                  width: getWidth(mediaQuery.width),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimens.size10, vertical: Dimens.size15),
                    itemCount: controller.cardListModel!.response!.otherCards!.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: getHeight(10),
                    ),
                    itemBuilder: (context, index) {
                      return Material(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(Dimens.size5),
                        child: Container(
                          height: getHeight(Dimens.size65),
                          width: getWidth(Dimens.size370),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimens.size5),
                              color: MyColors.lightPrimary),
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: Dimens.size15),
                            child: Row(
                              children: [
                                Container(
                                  height: getHeight(Dimens.size30),
                                  width: getWidth(Dimens.size50),
                                  decoration: BoxDecoration(
                                    color: MyColors.white,
                                    borderRadius:
                                    BorderRadius.circular(Dimens.size5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: controller.cardListModel!.response!.otherCards![index].cardType=='mastercard'?
                                    Image.asset(
                                      MyImgs.payCard,
                                    ): Image.asset(
                                      MyImgs.visaCard,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getWidth(15),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                 controller.cardListModel!.response!.otherCards![index].cardType=='mastercard'?   Align(
                                   alignment: Alignment.topLeft,
                                   child: Text(
                                        "MasterCard",
                                        style: textTheme.headline5!
                                            .copyWith(color: MyColors.black),
                                      ),
                                 ):Text(
                                   "Visa",
                                   style: textTheme.headline5!
                                       .copyWith(color: MyColors.black),
                                 ),
                                    Text(
                                      "XXXXXXXXXXXX${controller.cardListModel!.response!.otherCards![index].last4Digit.toString()}",
                                      style: textTheme.bodyText1!
                                          .copyWith(color: MyColors.black),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: (){
                                    controller.removeCard(payId: controller.cardListModel!.response!.otherCards![index].pmId!);
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: MyColors.black.withOpacity(0.5),
                                    size: Dimens.size20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: getHeight(30),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => AddNewCard());
                  },
                  child: Container(
                      height: getHeight(Dimens.size45),
                      width: getWidth(mediaQuery.width),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.size5),
                          border:
                          Border.all(color: MyColors.primaryColor, width: 0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: MyColors.primaryColor),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Icon(Icons.add,
                            size: 20,
                              color: MyColors.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: getWidth(20),
                          ),
                          Text(
                            'Add card',
                            style: Get.textTheme.headline3!.copyWith(
                              color: MyColors.primaryColor
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}