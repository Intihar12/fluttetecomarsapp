import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/values/values.dart';
import 'package:kiwkemart/ui/widgets/shimmer_effect/shimmer_effect.dart';

class CategoryShimmerEffect extends StatelessWidget {
  const CategoryShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect.fun(
        color: Colors.grey.shade300,
        color2: Colors.grey.shade100,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildContainer(
                      height: 30,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                    buildContainer(
                      height: 30,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                    buildContainer(
                      height: 30,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    buildContainer(
                      height: 20,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildContainer(
                      height: Get.height * 0.24,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                    buildContainer(
                      height: Get.height * 0.24,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                    buildContainer(
                      height: Get.height * 0.24,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    buildContainer(
                      height: 20,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildContainer(
                      height: Get.height * 0.24,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                    buildContainer(
                      height: Get.height * 0.24,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                    buildContainer(
                      height: Get.height * 0.24,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    buildContainer(
                      height: 20,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildContainer(
                      height: Get.height * 0.12,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                    buildContainer(
                      height: Get.height * 0.12,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                    buildContainer(
                      height: Get.height * 0.12,
                      width: Get.width * 0.30,
                      color: MyColors.grey,
                      round: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
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
