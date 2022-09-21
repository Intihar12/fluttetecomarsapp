import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/order_detail/order_detail.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';

import '../order_status/order_status.dart';
import '../tracking_order/tracking_order.dart';

class OrderSuccessful extends StatelessWidget {
  int? id;
  String? orderNo;

  OrderSuccessful({this.id, this.orderNo});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Dimens.size50,
              ),
              Container(
                height: mediaQuery.height * 0.25,
                child: Image.asset(MyImgs.happy),
              ),
              Container(
                height: mediaQuery.height * 0.2,
                width: mediaQuery.width * 1.0,
                //color: MyColors.grey,
                child: Column(
                  children: [
                    Text(
                      "Order Placed Successfully!",
                      style: textTheme.headline1!
                          .copyWith(color: MyColors.primaryColor, fontSize: 24),
                    ),
                    SizedBox(
                      height: Dimens.size10,
                    ),
                    Text(
                      "Your order has been placed. You will soon receive a confirmation via email address.",
                      style: textTheme.subtitle2!
                          .copyWith(color: MyColors.grey.withOpacity(0.7)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              CustomButton(
                height: 0.06,
                width: 0.85,
                text: "Continue Shopping",
                onPressed: () {
                  Get.offAll(Home());
                },
                roundCorner: 5,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                height: 0.06,
                width: 0.85,
                textColor: MyColors.primaryColor,
                color: MyColors.white,
                text: "View Order Details",
                onPressed: () {
                  Get.log(id.toString());
                  Get.to(OrderDetail(
                    id: id.toString(),
                    check: 'place',
                    orderNumber: orderNo,
                  ));
                },
                roundCorner: 5,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
