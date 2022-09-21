import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/controller/delivery_controller/delivery_controller.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/address/save_adress.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/payments/payment_screen.dart';
import 'package:kiwkemart/ui/scheduled_delivery/scheduled_delivery_stats/scheduled_delivery_stats.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/custom_textfield.dart';

class Delivery extends StatelessWidget {
  Delivery({this.lat, this.lng, this.address, this.userAddressId});

  String? lat;
  String? lng;
  String? address;
  int? userAddressId;
  int instantDelivery = 0;
  int callMe = 0;
  int bell = 0;
  final GlobalKey<FormState> form1FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> form2FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return GetBuilder<DeliveryController>(
        init: DeliveryController(),
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text("Checkout",style: theme.textTheme.headline2!.copyWith(color: MyColors.white,fontWeight: FontWeight.w500),),
                  leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back)),
                  elevation: 0,
                  bottom: const TabBar(
                    unselectedLabelColor: MyColors.black,
                    labelColor: MyColors.white,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.delivery_dining),
                        text: "Delivery",
                        iconMargin: EdgeInsets.only(bottom: 5),
                      ),
                      Tab(
                        icon: Icon(Icons.directions_walk_rounded),
                        text: "Pickup",
                        iconMargin: EdgeInsets.only(bottom: 5),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  //controller.isLoading ? SizedBox():
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Dimens.size12, 0, Dimens.size12, Dimens.size12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            //    Text("Delivery Address", style: textTheme.headline2,),
                            Container(
                              // height: mediaQuery.height*0.1,
                              decoration: BoxDecoration(
                                color: MyColors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 10, right: 10),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.off(SaveAddress(SingleToneValue
                                              .instance.deliveryAddress));
                                        },
                                        child: Text(
                                          "Change",
                                          style: textTheme.subtitle1!.copyWith(
                                              color: MyColors.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Dimens.size12,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 8.0, right: 5),
                                                  child: Icon(
                                                    Icons.location_on_outlined,
                                                    color: MyColors.primaryColor,
                                                    size: Dimens.size20,
                                                  ),
                                                ),
                                                Text(
                                                  "Delivery Address",
                                                  style: Get.textTheme.headline4!,
                                                ),
                                              ],
                                            ),
                                            address == null
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 20,
                                                            right: 10,
                                                            left: 25),
                                                    child: Text(
                                                      controller.userAddress ?? "",
                                                      style: Get
                                                          .textTheme.subtitle1!
                                                          .copyWith(
                                                        color:
                                                            MyColors.textVColor,fontWeight: FontWeight.w400
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Text(
                                                      address!,
                                                      style: Get
                                                          .textTheme.subtitle1!
                                                          .copyWith(
                                                        color:
                                                            MyColors.textVColor,
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: mediaQuery.width * 1.0,
                              //     color: MyColors.grey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Mode",
                                    style: textTheme.headline4,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.instantDelivery = true;
                                          if (controller.scheduleDelivery) {
                                            controller.scheduleDelivery = false;
                                          }
                                          controller.update();
                                        },
                                        child: Container(
                                          height: mediaQuery.height * 0.07,
                                          width: mediaQuery.width * 0.45,
                                          decoration: BoxDecoration(
                                            color: controller.instantDelivery
                                                ? MyColors.yellow
                                                : MyColors.lightPrimary,
                                            borderRadius: BorderRadius.circular(
                                                Dimens.size10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                MyImgs.instantDeliveryIcon,
                                                height: 30,
                                                width: 30,
                                              ),
                                              Text(
                                                "Instant Delivery",
                                                style: Get.textTheme.subtitle1!
                                                    .copyWith(
                                                        color:
                                                            MyColors.textVColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(ScheduledDeliveryStats());
                                        },
                                        child: Container(
                                          height: mediaQuery.height * 0.07,
                                          width: mediaQuery.width * 0.45,
                                          decoration: BoxDecoration(
                                              color: controller.scheduleDelivery
                                                  ? MyColors.yellow
                                                  : MyColors.lightPrimary,
                                              borderRadius: BorderRadius.circular(
                                                  Dimens.size10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                MyImgs.sceDeliveryIcon,
                                                height: 30,
                                                width: 30,
                                              ),
                                              // Icon(Icons.calendar_today_outlined, size: Dimens.size36,),
                                              Text(
                                                "Schedule Delivery",
                                                style: Get.textTheme.subtitle1!
                                                    .copyWith(
                                                        color:
                                                            MyColors.textVColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: mediaQuery.height * 0.19,
                              width: mediaQuery.width * 1.0,
                              //     color: MyColors.grey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Add Delivery Notes",
                                        style: textTheme.headline4,
                                      ),
                                      Text(
                                        "(optional)",
                                        style: textTheme.headline6!
                                            .copyWith(color: MyColors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    height: mediaQuery.height * 0.1,
                                    width: mediaQuery.width * 1.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: MyColors.textVColor
                                                .withOpacity(0.5))),
                                    child: CustomTextField(
                                        text: "Add a comment",
                                        controller: controller.commentController,
                                        length: 200,
                                        border: InputBorder.none,
                                        keyboardType: TextInputType.name,
                                        inputFormatters:
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[a-zA-Z- ]'))),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimens.size30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (callMe == 0) {
                                      callMe = 1;
                                    } else {
                                      callMe = 0;
                                    }
                                    controller.update();
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      controller.callWhenAtDoorText = SingleToneValue.instance.callAtDoor!;
                                      if (controller.callWhenAtDoor) {
                                        controller.callWhenAtDoor = false;
                                      } else {
                                        controller.callWhenAtDoor = true;
                                      }
                                      controller.update();
                                    },
                                    child: Container(
                                      height: mediaQuery.height * 0.04,
                                      width: mediaQuery.width * 0.4,
                                      decoration: BoxDecoration(
                                        color: controller.callWhenAtDoor
                                            ? MyColors.yellow
                                            : MyColors.blue20,
                                        borderRadius:
                                            BorderRadius.circular(Dimens.size5),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "${SingleToneValue.instance.callAtDoor}",
                                        style: Get.textTheme.subtitle1!
                                            .copyWith(color: MyColors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimens.size10,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.ringBellText = SingleToneValue.instance.ringBell!;
                                    if (controller.ringBell) {
                                      controller.ringBell = false;
                                    } else {
                                      controller.ringBell = true;
                                    }
                                    controller.update();
                                  },
                                  child: Container(
                                    height: mediaQuery.height * 0.04,
                                    width: mediaQuery.width * 0.44,
                                    decoration: BoxDecoration(
                                      color: controller.ringBell
                                          ? MyColors.yellow
                                          : MyColors.blue20,
                                      borderRadius:
                                          BorderRadius.circular(Dimens.size5),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "${SingleToneValue.instance.ringBell}",
                                      style: Get.textTheme.subtitle1!
                                          .copyWith(color: MyColors.black,
                                      fontWeight: FontWeight.w400,
                                        fontSize: 14
                                      ),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            //  Divider(),
                            SizedBox(
                              height: 30,
                            ),
                            Divider(),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Image.asset(
                                    MyImgs.drawerVoucherIcon,
                                    height: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "  Got a Voucher?",
                                    style: Get.textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: form1FormKey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: Dimens.size45,
                                    width: mediaQuery.width * 0.6,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(Dimens.size5),
                                        border: Border.all(
                                            color: MyColors.primaryColor)),
                                    child: TextFormField(
                                      controller: controller.voucherController,
                                      maxLength: 6,
                                      cursorHeight: 14,
                                      validator: (value) {
                                        return controller.validation
                                            .validateVoacher(value!);
                                      },
                                      style: textTheme.bodyText2!.copyWith(),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: " Enter voucher code",
                                        focusColor: MyColors.green50,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final isValid =
                                          form1FormKey.currentState!.validate();
                                      if (!isValid) {
                                        return;
                                      } else {
                                        controller.onApplyVoucher();
                                      }
                                    },
                                    child: Container(
                                        height: Dimens.size45,
                                        width: mediaQuery.width * 0.3,
                                        decoration: BoxDecoration(
                                            color: MyColors.lightPrimary,
                                            borderRadius: BorderRadius.circular(
                                                Dimens.size5),
                                            border: Border.all(
                                                color: MyColors.lightPrimary)),
                                        child: Center(
                                            child: Text(
                                          "Apply",
                                          style: textTheme.bodyText1,
                                        ))),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            textRowWidget(
                                text1: "Sub Total",
                                text2: controller.subTotal!.toStringAsFixed(2)),
                            textRowWidget(
                                text1: "Services Charges",
                                text2: Constants.serviceFee),
                            textRowWidget(
                                text1: "Delivery Fee",
                                text2: Constants.deliveryFee),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: Get.textTheme.subtitle1!
                                        .copyWith(color: MyColors.textVColor)),
                                Text(
                                  "${Constants.currency} " +
                                      controller.total!.toStringAsFixed(2),
                                  style: textTheme.headline4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CustomButton(
                              height: 0.06,
                              width: 1.0,
                              roundCorner: 5,
                              text: "Proceed to payment",
                              onPressed: () {
                                controller.buttonProceed();
                              },
                            ),
                          ]),
                    ),
                  ),
                  //  controller.isLoading ? SizedBox():
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Dimens.size12, 0, Dimens.size12, Dimens.size12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //   Text("Self Pickup", style: textTheme.headline2,),
                            SizedBox(
                              height: 20,
                            ),

                            Container(
                              padding: EdgeInsets.all(10),
                              // height: mediaQuery.height*0.13,
                              decoration: BoxDecoration(
                                color: MyColors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Dimens.size12,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8.0,right: 5),
                                                  child: Icon(
                                                    Icons.location_on_outlined,
                                                    color: MyColors.primaryColor,
                                                    size: Dimens.size20,
                                                  ),
                                                ),
                                                Text(
                                                  "Pick up Address",
                                                  style: Get.textTheme.headline4!,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 25),
                                              child: Text(
                                                controller.saveStoreData != null?controller.saveStoreData!.address!
                                                    :"",
                                                style: Get.textTheme.subtitle1!
                                                    .copyWith(
                                                  color: MyColors.textVColor,fontWeight: FontWeight.w400
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25,bottom: 5),
                                              child: Text(
                                                controller.saveStoreData != null?'Store Name:  ${controller.saveStoreData!.name!}':"",
                                                style: Get.textTheme.subtitle1!.copyWith(
                                                  color: MyColors.textVColor,fontWeight: FontWeight.w400
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            Container(
                              height: mediaQuery.height * 0.17,
                              width: mediaQuery.width * 1.0,
                              //     color: MyColors.grey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add Pick up Notes(optional)",
                                    style: textTheme.headline4,
                                  ),
                                  Container(
                                    height: mediaQuery.height * 0.1,
                                    width: mediaQuery.width * 1.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: MyColors.textVColor
                                                .withOpacity(0.5))),
                                    child: CustomTextField(
                                        text: "Add a comment",
                                        controller:
                                            controller.commentControllerPickUp,
                                        maxLine: 3,
                                        length: 200,
                                        border: InputBorder.none,
                                        keyboardType: TextInputType.name,
                                        inputFormatters:
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[a-zA-Z- ]'))),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimens.size30,
                            ),
                            Divider(),
                            Row(
                              children: [
                                Image.asset(
                                  MyImgs.drawerVoucherIcon,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "  Apply a Voucher",
                                  style: Get.textTheme.bodyText1,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: form2FormKey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: Dimens.size45,
                                    width: mediaQuery.width * 0.6,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(Dimens.size5),
                                        border: Border.all(
                                            color: MyColors.primaryColor)),
                                    child: TextFormField(
                                      maxLength: 6,
                                      cursorHeight: 8,
                                      validator: (value) {
                                        return controller.validation
                                            .validateVoacher(value!);
                                      },
                                      controller:
                                          controller.voucherControllerPickUp,
                                      style: textTheme.bodyText2!.copyWith(),
                                      keyboardType: TextInputType.text,
                                      // textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: " Enter voucher code",
                                        focusColor: MyColors.green50,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final isValid =
                                          form2FormKey.currentState!.validate();
                                      if (!isValid) {
                                        return;
                                      } else {
                                        controller.pickUpVoucher = true;
                                        controller.onApplyVoucher();
                                      }
                                    },
                                    child: Container(
                                        height: Dimens.size45,
                                        width: mediaQuery.width * 0.3,
                                        decoration: BoxDecoration(
                                            color: MyColors.lightPrimary,
                                            borderRadius: BorderRadius.circular(
                                                Dimens.size5),
                                            border: Border.all(
                                                color: MyColors.lightPrimary)),
                                        child: Center(
                                            child: Text(
                                          "Apply",
                                          style: textTheme.bodyText1,
                                        ))),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            textRowWidget(
                                text1: "Sub Total",
                                text2: controller.subTotal.toString()),
                            textRowWidget(
                                text1: "Services Charges",
                                text2: Constants.serviceFee),
                            // textRowWidget(text1: "Delivery Fee", text2: '987'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: Get.textTheme.subtitle1!
                                        .copyWith(color: MyColors.textVColor)),
                                Text(
                                  "${Constants.currency}" +
                                      (controller.total! -
                                              double.parse(Constants.deliveryFee))
                                          .toStringAsFixed(2),
                                  style: textTheme.headline4,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CustomButton(
                              height: 0.06,
                              width: 1.0,
                              roundCorner: 5,
                              text: "Proceed to payment",
                              onPressed: () {
                                controller.pickUp = true;
                                controller.update();
                                Get.to(
                                  PaymentScreen(),
                                );
                              },
                            ),
                          ]),
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }

  Widget textRowWidget({required String text1, required String text2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1,
            style:
                Get.textTheme.subtitle1!.copyWith(color: MyColors.textVColor)),
        Text("${Constants.currency} $text2",
            style:
                Get.textTheme.headline6!.copyWith(color: MyColors.textVColor)),
      ],
    );
  }

  Widget _itemRow(CartItemSave cartItemSave) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "X1 " + cartItemSave.title,
              ),
              Text(
                cartItemSave.quantity.toString() + ' ' + cartItemSave.unit,
              ),
            ],
          ),
          Text(
            (cartItemSave.quantity * cartItemSave.price).toStringAsFixed(2),
          ),
        ],
      ),
    );
  }
}
