import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/deliveryAddress/delivery_address.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

class DeliveryLocationSet extends StatelessWidget {
  const DeliveryLocationSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  printInfo(info: 'Hay');
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.size15,
                      top: Dimens.size30,
                      right: Dimens.size15),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(DeliveryAddress());
                    },
                    child: Container(
                      height: Dimens.size50,
                      width: mediaQuery.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.size25),
                          color: MyColors.grey200),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 55),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: Dimens.size15),
                              child: Text(
                                'Enter your delivery address ',
                                textAlign: TextAlign.center,
                                style: Get.textTheme.headline5!.copyWith(
                                    color:
                                        Get.theme.colorScheme.secondaryVariant,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 35,
                              color: Get.theme.colorScheme.secondary,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 100, right: 20),
                child: Container(
                  height: mediaQuery.height * 0.1,
                  //   color: Colors.amberAccent,
                  child: Text(
                    'Start by entering delivery \naddress',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline1!
                        .copyWith(color: Get.theme.colorScheme.secondary),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: Dimens.size25, right: Dimens.size25),
                  child: Container(
                    height: mediaQuery.height * 0.3,

                    //  color: Colors.amberAccent,
                    child: ClipRRect(
// borderRadius:
// BorderRadius.circular(8),
                        child:
                            Image.asset(MyImgs.imgLocation, fit: BoxFit.cover)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
