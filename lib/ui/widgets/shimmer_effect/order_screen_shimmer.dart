import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/widgets/shimmer_effect/shimmer_effect.dart';

class OrdersShimmer extends StatelessWidget {
  const OrdersShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size.height;
    return ShimmerEffect.fun(
      color: Colors.grey.shade300,
      color2: Colors.grey.shade100,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  buildContainer(
                    height: mediaQuery * 0.045,
                    width: 100,
                    color: MyColors.grey,
                    round: 10,
                  ),
                  buildContainer(
                    height: mediaQuery * 0.045,
                    width: 100,
                    color: MyColors.grey,
                    round: 10,
                  ),
                ],
              ),
              buildContainer(
                height: mediaQuery * 0.17,
                width: Get.width,
                color: MyColors.grey,
                round: 10,
              ),
              buildContainer(
                height: mediaQuery * 0.17,
                width: Get.width,
                color: MyColors.grey,
                round: 10,
              ),
              buildContainer(
                height: mediaQuery * 0.17,
                width: Get.width,
                color: MyColors.grey,
                round: 10,
              ),


            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer(
      {required double height,
      required double width,
      required Color color,
      required double round,
      Widget? child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(round), color: color),
      child: child,
    );
  }
}
