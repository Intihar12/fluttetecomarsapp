import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/constants/constants.dart';
import '../cart/cart.dart';
import '../values/values.dart';
import 'cart_animation/add_to_cart_icon.dart';

class BasketWidget extends StatelessWidget {
  GlobalKey<CartIconKey> gkCart;
  final Color basketColor;

  BasketWidget({Key? key, required this.gkCart, required this.basketColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if(Constants.cartCount.value==0){
            Get.snackbar("Not Added Basket", "Please added it to basket any item");
          }
          else{
            Get.to(Cart());
          }

        },
        child: Stack(
          children: [
            AddToCartIcon(
              key: gkCart,
              icon: Image.asset(
                MyImgs.basketIcon,
                width: 34,
                height: 30,
                color: basketColor,
              ),
              colorBadge: Colors.red,
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  bottom: 7,
                ),
                child: Obx(() {
                  return int.parse(Constants.cartCount.value.toString()) >= 100
                      ? CircleAvatar(
                          radius: 15,
                          backgroundColor: MyColors.secondaryColor,
                          child: Obx(() => Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Text(
                                  Constants.cartCount.value.toString(),
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.bodyText2!
                                      .copyWith(color: MyColors.black),
                                ),
                              )))
                      : CircleAvatar(
                          radius: 12,
                          backgroundColor: MyColors.secondaryColor,
                          child: Obx(() => Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Text(
                                  Constants.cartCount.value.toString(),
                                  textAlign: TextAlign.center,
                                  style: Get.textTheme.bodyText2!
                                      .copyWith(color: MyColors.black),
                                ),
                              )));
                })),
          ],
        ));
  }
}
