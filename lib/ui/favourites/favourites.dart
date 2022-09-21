import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/favourite/favourite.dart';
import 'package:kiwkemart/data/model/category_product/category_product.dart';
import 'package:kiwkemart/ui/product_description/product_description.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/widgets/item_card_category_product.dart';

import '../widgets/basket.dart';
import '../widgets/cart_animation/add_to_cart_animation.dart';
import '../widgets/cart_animation/add_to_cart_icon.dart';

class FavouriteScreen extends StatelessWidget {
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: AddToCartAnimation(
        gkCart: gkCart,
        rotation: true,
        dragToCardCurve: Curves.ease,
        dragToCardDuration: const Duration(milliseconds: 1000),
        previewCurve: Curves.linearToEaseOut,
        previewDuration: const Duration(milliseconds: 300),
        previewHeight: 30,
        previewWidth: 30,
        opacity: 0.85,
        initiaJump: false,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          // You can run the animation by addToCardAnimationMethod, just pass trough the the global key of  the image as parameter
          this.runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Favourite Products',
                style: Get.textTheme.headline2!.copyWith(
                    color: MyColors.white, fontWeight: FontWeight.w500),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15, top: 10),
                  child: BasketWidget(
                    gkCart: gkCart,
                    basketColor: MyColors.white,
                  ),
                ),
              ],
            ),
            body: GetBuilder<FavouriteController>(
                init: FavouriteController(),
                builder: (controller) {
                  return SingleChildScrollView(
                    child: controller.favItemSave.length == 0
                        ? Center(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 200),
                            child: Text(
                              'No Favourite item added',
                              style: Get.textTheme.headline4!
                                  .copyWith(color: Get.theme.primaryColor),
                            ),
                          ))
                        : // Text('TOTAL ITEMS ARE '+controller.favItemSave.length.toString())
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 140,
                                        childAspectRatio: 4 / 7.5,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 20),
                                itemCount: controller.favItemSave.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        ProductDescription(
                                          product: Product(
                                              productStoreId: controller
                                                  .favItemSave[index]
                                                  .productStoreId,
                                              storeId: controller
                                                  .favItemSave[index].storeId,
                                              title: controller
                                                  .favItemSave[index].title,
                                              image: controller
                                                  .favItemSave[index].image,
                                              price: controller
                                                  .favItemSave[index].price,
                                              discount: controller
                                                  .favItemSave[index].discount,
                                              discountPrice: controller
                                                  .favItemSave[index]
                                                  .discountPrice,
                                              unit: controller
                                                  .favItemSave[index].unit,
                                              itemsPerUnit: controller
                                                  .favItemSave[index]
                                                  .itemsPerUnit,
                                              minOrder: controller
                                                  .favItemSave[index].minOrder,
                                              is18plus: controller
                                                  .favItemSave[index].is18plus,
                                              stock: controller
                                                  .favItemSave[index].stock,
                                              itemCount: controller
                                                  .favItemSave[index].itemCount,
                                              isFav: true.obs),
                                        ),
                                      );
                                    },
                                    child: ItemCard(
                                      image: '',
                                      product: Product(
                                          productStoreId: controller
                                              .favItemSave[index]
                                              .productStoreId,
                                          storeId: controller
                                              .favItemSave[index].storeId,
                                          title: controller
                                              .favItemSave[index].title,
                                          image: controller
                                              .favItemSave[index].image,
                                          price: controller
                                              .favItemSave[index].price,
                                          discount: controller
                                              .favItemSave[index].discount,
                                          discountPrice: controller
                                              .favItemSave[index].discountPrice,
                                          unit: controller
                                              .favItemSave[index].unit,
                                          itemsPerUnit: controller
                                              .favItemSave[index].itemsPerUnit,
                                          minOrder: controller
                                              .favItemSave[index].minOrder,
                                          is18plus: controller
                                              .favItemSave[index].is18plus,
                                          stock: controller
                                              .favItemSave[index].stock,
                                          itemCount: controller
                                              .favItemSave[index].itemCount,
                                          isFav: true.obs),
                                      offer: true,
                                      onClick:
                                          (GlobalKey gkImageContainer) async {
                                        await runAddToCardAnimation(
                                            gkImageContainer);
                                      },
                                    ),
                                  );
                                }),
                          ),
                  );
                })),
      ),
    );
  }
}
