import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/controller/orderStatus_controller/orderStatus_controller.dart';
import 'package:kiwkemart/ui/order_detail/order_detail.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';

import '../../widgets/shimmer_effect/order_screen_shimmer.dart';

class MyOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              "My Orders",
              style: TextStyle(
                fontSize: Dimens.size20,
              ),
            ),
          ),
          backgroundColor: MyColors.appBackground,
          body: GetBuilder<OrderStatusController>(
              init: OrderStatusController(),
              builder: (controller) {
                return controller.isLoading
                    ? OrdersShimmer()
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.size25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Dimens.size20,
                              ),
                              Container(
                                height: mediaQuery.height * 0.04,
                                width: mediaQuery.width,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: Dimens.size35,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.order.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (index == 0) {
                                          controller.id = index;
                                          controller.onOrderList('on_going');
                                        } else {
                                          controller.id = index;
                                          controller.onOrderList('completed');
                                        }
                                      },
                                      child: Container(
                                        height: mediaQuery.height * 0.05,
                                        width: mediaQuery.width * 0.24,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            Dimens.size5,
                                          ),
                                          border: controller.id == index
                                              ? Border.all(
                                                  color: MyColors.primaryColor)
                                              : Border.all(
                                                  color: MyColors.textVColor),
                                          color: controller.id == index
                                              ? Get.theme.primaryColor
                                              : MyColors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.order[index],
                                            style: TextStyle(
                                              fontSize: Dimens.size12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: Dimens.size20,
                              ),
                              controller.orderList!.response!.orders!.isEmpty?
                              Center(child: Padding(
                                padding: const EdgeInsets.only(top: 200),
                                child: Text(
                                  'No Order',
                                style: Get.textTheme.headline4!.copyWith(
                                  color: Get.theme.primaryColor
                                ),
                                ),
                              )):
                              Container(
                                height: mediaQuery.height * 0.8,
                                width: mediaQuery.width,
                                child: ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimens.size6),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: controller
                                      .orderList!.response!.orders!.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: Dimens.size15,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Material(
                                      color: MyColors.cardColor,
                                      borderRadius: BorderRadius.circular(
                                        Dimens.size10,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        width: mediaQuery.width * 0.145,
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Order# ${ controller
                                            .orderList!
                                              .response!
                                              .orders![index]
                                              .orderNo ??
                                          ''}",
                                                  style: TextStyle(
                                                    fontSize: Dimens.size12,
                                                  ),
                                                ),
                                                Text(
                                                  controller
                                                          .orderList!
                                                          .response!
                                                          .orders![index]
                                                          .scheduleDate ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: Dimens.size10,
                                                      color: MyColors.grey),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimens.size8,
                                            ),
                                            // Row(
                                            //   children: [
                                            //     Text(
                                            //       "Tracking Number",
                                            //       style: TextStyle(
                                            //           fontSize: Dimens.size12,
                                            //           color: MyColors.grey),
                                            //     ),
                                            //     SizedBox(
                                            //       width: Dimens.size5,
                                            //     ),
                                            //     Text(
                                            //       controller
                                            //               .orderList!
                                            //               .response!
                                            //               .orders![index]
                                            //               .orderNo ??
                                            //           '',
                                            //       style: TextStyle(
                                            //         fontSize: Dimens.size14,
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            SizedBox(
                                              height: Dimens.size8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Quantity",
                                                      style: TextStyle(
                                                          fontSize:
                                                              Dimens.size12,
                                                          color: MyColors.grey),
                                                    ),
                                                    SizedBox(
                                                      width: Dimens.size5,
                                                    ),
                                                    Text(
                                                      controller
                                                          .orderList!
                                                          .response!
                                                          .orders![index]
                                                          .orderItems
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: Dimens.size14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${Constants.currency} ${controller.orderList!.response!.orders![index].total}'
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: Dimens.size14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimens.size15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(OrderDetail(
                                                      id: controller
                                                          .orderList!
                                                          .response!
                                                          .orders![index]
                                                          .id
                                                          .toString(),
                                                      check: '',
                                                      orderNumber: controller
                                                          .orderList!
                                                          .response!
                                                          .orders![index]
                                                          .orderNo,
                                                    ));
                                                  },
                                                  child: Container(
                                                    height: mediaQuery.height *
                                                        0.03,
                                                    width:
                                                        mediaQuery.width * 0.15,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    Dimens
                                                                        .size30),
                                                        border: Border.all(
                                                            color: Get.theme
                                                                .primaryColor,
                                                            width: 1)),
                                                    child: Center(
                                                      child: Text(
                                                        "Details",
                                                        style: TextStyle(
                                                          fontSize:
                                                              Dimens.size10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  controller
                                                          .orderList!
                                                          .response!
                                                          .orders![index]
                                                          .orderType ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: Dimens.size10,
                                                      color: Get
                                                          .theme.primaryColor),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimens.size5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
              })),
    );
  }
}
