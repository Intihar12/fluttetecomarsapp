import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/widgets/shimmer_effect/shimmer_effect.dart';

class ProductDescriptionShimmer extends StatelessWidget {
  const ProductDescriptionShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect.fun(
      color: Colors.grey.shade300,
      color2: Colors.grey.shade100,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              buildContainer(
                height: 150,
                width: Get.width,
                color: MyColors.grey,
                round: 10,
              ),
              SizedBox(
                height: 10,
              ),
              buildContainer(
                height: 1,
                width: Get.width,
                color: MyColors.black,
                round: 0,
              ),
              SizedBox(
                height: 10,
              ),
              buildContainer(
                height: 15,
                width: 100,
                color: MyColors.grey,
                round: 10,
              ),
              SizedBox(
                height: 10,
              ),
              buildContainer(
                height: 50,
                width: 150,
                color: MyColors.grey,
                round: 10,
              ),
              SizedBox(
                height: 10,
              ),
              buildContainer(
                height: 15,
                width: 100,
                color: MyColors.grey,
                round: 10,
              ),
              SizedBox(
                height: 10,
              ),
              buildContainer(
                height: 150,
                width: Get.width,
                color: MyColors.grey,
                round: 10,
              ),
              SizedBox(
                height: 10,
              ),
              buildContainer(
                height: 1,
                width: Get.width,
                color: MyColors.black,
                round: 0,
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
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(round), color: color),
      child: child,
    );
  }
}
