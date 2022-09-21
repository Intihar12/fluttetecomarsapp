import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/controller/order_details/order_details.dart';
import 'package:kiwkemart/ui/order_status/order_status.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/progress_bar.dart';
import 'package:kiwkemart/ui/widgets/shimmer_effect/order_details_shimmer.dart';

class OrderDetail extends StatelessWidget {
  String? id;
  String? check;
  String? orderNumber;

  OrderDetail({this.id, this.check, this.orderNumber});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 25,
            )),
        title: Text("Order Details",
        style: Get.textTheme.headline4!.copyWith(
          color: MyColors.white
        ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<OrderDetailController>(
        init: OrderDetailController(id: id),
        builder: (controller) {
          return controller.isLoading
              ? OrderDetailsShimmer()
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.size12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimens.size50,
                        ),
                        Text(
                          "Order#${controller.orderDetails!.response!.order!.orderNo!}",
                          style: textTheme.headline4!
                              .copyWith(color: MyColors.grey),
                        ),
                        SizedBox(
                          height: Dimens.size10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Address:",
                                style: textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: MyColors.black.withOpacity(0.6)),
                              ),
                            ),
                            SizedBox(
                              width: 220,
                              child: Text(
                                controller.orderDetails!.response!.order!
                                    .userAddress!.address!,
                                style: textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: MyColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimens.size10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Time:",
                                style: textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: MyColors.black.withOpacity(0.6)),
                              ),
                            ),
                            SizedBox(
                              width: 220,
                              child: Text(
                                controller.orderDetails!.response!.order!
                                    .scheduleDate!,
                                style: textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: MyColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimens.size20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Items",
                              style: textTheme.headline4,
                            ),
                            Container(
                              width: mediaQuery.width * 1.0,
                              //color: MyColors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.orderDetails!
                                        .response!.order!.orderItems!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: Dimens.size60,
                                        width: mediaQuery.width * 1.0,
                                        // color: MyColors.grey200,
                                        child: Column(
                                          children: [
                                            Divider(
                                              thickness: 1,
                                            ),
                                            SizedBox(
                                              height: Dimens.size10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: Dimens.size28,
                                                  width: Dimens.size28,
                                                  decoration: BoxDecoration(
                                                      color: theme.primaryColor
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimens.size4)),
                                                  child: Center(
                                                    child: Text(
                                                      controller
                                                          .orderDetails!
                                                          .response!
                                                          .order!
                                                          .orderItems![index]
                                                          .quantity!
                                                          .toString(),
                                                      style:
                                                          textTheme.subtitle1,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimens.size10,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .orderDetails!
                                                            .response!
                                                            .order!
                                                            .orderItems![index]
                                                            .title!,
                                                        style: textTheme
                                                            .caption!
                                                            .copyWith(
                                                                fontSize: 12),
                                                      ),
                                                      Text(
                                                        "X ${controller.orderDetails!.response!.order!.orderItems![index].quantity!} items",
                                                        style: textTheme
                                                            .caption!
                                                            .copyWith(
                                                                fontSize: 9),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "${controller.orderDetails!.response!.order!.orderItems![index].price}",
                                                  style: textTheme.caption!
                                                      .copyWith(fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: Dimens.size30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub Total",
                              style: Get.textTheme.headline6!.copyWith(
                                color: MyColors.textVColor.withOpacity(0.7)
                              ),
                            ),
                            Text(
                              Constants.currency +
                                  controller
                                      .orderDetails!.response!.order!.subTotal!,
                              style: Get.textTheme.headline6!.copyWith(
                            color: MyColors.textVColor.withOpacity(0.7)
                  ) ,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimens.size8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery fee",
                              style: Get.textTheme.headline6!.copyWith(
                                  color: MyColors.textVColor.withOpacity(0.7)
                              ),
                            ),
                            Text(
                              "${Constants.currency}20.0",
                              style: Get.textTheme.headline6!.copyWith(
                                  color: MyColors.textVColor.withOpacity(0.7)
                              ) ,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimens.size8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: Get.textTheme.headline6!.copyWith(
                                  color: MyColors.textVColor.withOpacity(0.7)
                              ),
                            ),
                            Text(
                              Constants.currency +
                                  controller
                                      .orderDetails!.response!.order!.total!,
                              style: textTheme.caption!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimens.size50,
                        ),
                        Center(
                          child: CustomButton(
                              height: 0.06,
                              width: 0.9,
                              text: 'View Order Status',
                              roundCorner: 8,
                              onPressed: () {
                                Get.to(() => OrderStatus(
                                      orderNumber: orderNumber,
                                    ));
                              }),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
    ));
  }
}
