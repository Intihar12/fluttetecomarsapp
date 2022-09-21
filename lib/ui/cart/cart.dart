import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:kiwkemart/data/api/api_with_getx.dart';
import 'package:kiwkemart/data/controller/cart_controller/cart_controller.dart';
import 'package:kiwkemart/data/controller/homepage_controller/homepage_controller.dart';
import 'package:kiwkemart/data/model/cart_model/cart_model.dart';
import 'package:kiwkemart/ui/delivery/delivery.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/cart_card.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';

import '../../data/constants/constants.dart';
import '../../data/controller/sub_category_controller/sub_category_controller.dart';

class Cart extends StatelessWidget {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: Text(
          'My Basket',
          style: Get.textTheme.headline2!.copyWith(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: theme.primaryColor,
      ),
      body: GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) =>
          // controller.isLoading?
          //     SizedBox()
          // Center(
          //     child:SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //         bottom: Dimens.size12,
          //         left: Dimens.size12,
          //         right: Dimens.size12),
          //     child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: Dimens.size12, vertical: 10),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text("My Basket", style: textTheme.headline2!),
          //                 Text(
          //                   "${controller.cartdata.length} Products",
          //                   style: Get.textTheme.subtitle2!
          //                       .copyWith(color: MyColors.textVColor.withOpacity(0.7)),
          //                 ),
          //                 GestureDetector(
          //                     onTap: () {
          //                       Get.defaultDialog(
          //                           title: "Caution",
          //                           middleText:
          //                           "Are you sure to empty you basket",
          //                           textConfirm: "Yes",
          //                           textCancel: 'Cancel',
          //                           onConfirm: () {
          //
          //
          //                           },
          //                           onCancel: () {
          //
          //                           });
          //                     },
          //                     child: Text(
          //                       "Empty Basket",
          //                       style: Get.textTheme.subtitle2!
          //                           .copyWith(color: MyColors.textVColor.withOpacity(0.7)),
          //                     ))
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10,
          //           ),
          //           Divider(
          //             height: 2,
          //             thickness: 2,
          //           ),
          //           SizedBox(
          //             height: mediaQuery.height * 0.6,
          //             width: mediaQuery.width * 1.0,
          //             child: controller.cartdata.length == 0
          //                 ? Text("Your Basket is empty")
          //                 : Scrollbar(
          //               controller: _scrollController,
          //               child: ListView.builder(
          //                   controller: _scrollController,
          //                   physics: BouncingScrollPhysics(),
          //                   shrinkWrap: true,
          //                   itemCount: controller.cartdata.length,
          //                   itemBuilder: (context, index) {
          //                     return CartCard(
          //                       index: index,
          //                       image:
          //                       controller.cartdata[index].image,
          //                       title:
          //                       controller.cartdata[index].title,
          //                       text: controller.cartdata[index].unit,
          //                       price:
          //                       controller.cartdata[index].price,
          //                       quantity: controller
          //                           .cartdata[index].quantity,
          //                       onPressed: () {
          //                         // value.cartdata.removeAt(index);
          //                         //     value.update();
          //                       },
          //                     );
          //                   }),
          //             ),
          //           ),
          //           Divider(
          //             height: 2,
          //             thickness: 2,
          //           ),
          //           SizedBox(
          //             height: 15,
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text("Total",
          //                   style: Get.textTheme.subtitle1!
          //                       .copyWith(color: MyColors.textVColor.withOpacity(0.7)),
          //                 ),
          //                 Text(
          //                   '${Constants.currency}${controller.calculateTotal(controller.cartdata)}',
          //                   style: textTheme.headline4,
          //                 )
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 15,
          //           ),
          //           CustomButton(
          //             height: 0.06,
          //             width: 0.9,
          //             roundCorner: 5,
          //             text: "Checkout",
          //             onPressed: () {
          //
          //           //    controller.onAddToCart();
          //             },
          //           ),
          //         ]),
          //   ),
          // ) )
         // :
          SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: Dimens.size12,
                      left: Dimens.size12,
                      right: Dimens.size12),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.size12, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("My Basket", style: textTheme.headline2!),
                              Text(
                                "${controller.cartdata.length} Products",
                                style: Get.textTheme.subtitle2!
                                    .copyWith(color: MyColors.textVColor.withOpacity(0.7)),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: "Caution",
                                        middleText:
                                            "Are you sure to empty you basket",
                                        textConfirm: "Yes",
                                        textCancel: 'Cancel',
                                        onConfirm: () async {
                                    await controller.emptyBasket();
                                        },
                                        onCancel: () {

                                        });
                                  },
                                  child: Text(
                                    "Empty Basket",
                                    style: Get.textTheme.subtitle2!
                                        .copyWith(color: MyColors.textVColor.withOpacity(0.7)),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 2,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: mediaQuery.height * 0.6,
                          width: mediaQuery.width * 1.0,
                          child: controller.cartdata.length == 0
                              ? Text("Your Basket is empty")
                              : Scrollbar(
                                  controller: _scrollController,
                                  child: ListView.builder(
                                      controller: _scrollController,
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.cartdata.length,
                                      itemBuilder: (context, index) {
                                        return CartCard(
                                          index: index,
                                          image:
                                              controller.cartdata[index].image,
                                          title:
                                              controller.cartdata[index].title,
                                          text: controller.cartdata[index].unit,
                                          price:
                                              controller.cartdata[index].price,
                                          quantity: controller
                                              .cartdata[index].quantity,
                                          onPressed: () {
                                            // value.cartdata.removeAt(index);
                                        //     value.update();
                                          },
                                        );
                                      }),
                                ),
                        ),
                        Divider(
                          height: 2,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total",
                                style: Get.textTheme.subtitle1!
                                    .copyWith(color: MyColors.textVColor.withOpacity(0.7)),
                              ),
                              Text(
                                '${Constants.currency}${controller.calculateTotal(controller.cartdata)}',
                                style: textTheme.headline4,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        controller.cartdata.length==0? CustomButton(
                          height: 0.06,
                          width: 0.9,
                          roundCorner: 5,
                          text: "Checkout",
                          onPressed: () {
                            Get.snackbar('Message','Please Add product');
                          },
                        )
                       : CustomButton(
                          height: 0.06,
                          width: 0.9,
                          roundCorner: 5,
                          text: "Checkout",
                          onPressed: () {

                            controller.onAddToCart();
                          },
                        ),
                      ]),
                ),
              ),
      ),
    ));
  }


}
