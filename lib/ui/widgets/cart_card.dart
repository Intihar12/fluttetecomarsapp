import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/controller/cart_controller/cart_controller.dart';
import 'package:kiwkemart/data/controller/homepage_controller/homepage_controller.dart';
import 'package:kiwkemart/data/controller/sub_category_controller/sub_category_controller.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

class CartCard extends StatelessWidget {
  CartController controller=Get.put(CartController());
  final String image;
  final String title;
  final String text;
  final double price;
  final int index;
  int quantity;
  void Function() onPressed;

  CartCard({
    required this.image,
    required this.title,
    required this.text,
    required this.price,
    required this.onPressed,
    required this.index,
    required this.quantity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var textTheme=theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: 120,
      width: mediaQuery.width*1.0,
      //   color: MyColors.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: Dimens.size80,
                  width: mediaQuery.width*0.2,
                  decoration: BoxDecoration(
                    color: MyColors.lightPrimary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(image),
                ),
                SizedBox(
                  width: Dimens.size12,
                ),
                Expanded(
                  //flex: 1,
                  child: Container(
                    height: Dimens.size80,
                    width: mediaQuery.width*0.35,
                    //   color: MyColors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children:  [
                        Text(title,
                          maxLines: 1,
                          style: Get.textTheme.headline6!.copyWith(
                              color: MyColors.black
                          ),
                        ),
                        Text(text,
                          style: Get.textTheme.subtitle2!.copyWith(
                              color: MyColors.textVColor
                          ),
                        ),
                        Text("${Constants.currency}${controller.calculatePrice(price,quantity)}",
                          style: Get.textTheme.headline6!.copyWith(
                              color: MyColors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  height:Dimens.size80,
                  width: mediaQuery.width*0.2,
                  //  color: MyColors.yellow,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: InkWell(
                                onTap:()async{
                                  final String? cartString = await controller.sharedPrefClient.getCartItem();
                                  final List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
                                  if (Get.find<HomeController>().homeData!.response!.featuredProduct!.isNotEmpty ||
                                      Get.find<HomeController>().homeData!.response!
                                          .featuredProduct!.length != 0) {
                                    for (int k = 0; k < Get.find<HomeController>().homeData!.response!.featuredProduct!.length;
                                    k++) {
                                      if (Get.find<HomeController>().homeData!.response!.featuredProduct![k].productStoreId ==
                                          cartItemSave[index].productStoreId) {
                                        printInfo(info: 'hgjg');
                                        Get.find<HomeController>()
                                            .homeData!
                                            .response!
                                            .featuredProduct![k]
                                            .itemCount
                                            .value =
                                        0;
                                      }
                                    }
                                  }
                                  if (Get.isRegistered<SubcategoryController>()) {
                                    final categoryController = Get.find<SubcategoryController>();
                                    if (categoryController.subCatModel!.isNotEmpty ||
                                        categoryController.subCatModel!.length != 0) {
                                      for (int i = 0; i < categoryController.subCatModel!.length; i++) {
                                        if (categoryController.subCatModel![i].products!.length != 0) {
                                          for (int k = 0; k < categoryController.subCatModel![i].products!.length; k++) {
                                            if (cartItemSave[index].productStoreId ==
                                                categoryController.subCatModel![i].products![k].productStoreId) {
                                              categoryController.subCatModel![i].products![k].itemCount.value =
                                              0;
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }

                                  cartItemSave.removeAt(index);
                                  controller.cartdata.removeAt(index);
                                  Constants.cartCount.value = Constants.itemInCart(cartItemSave);
                                  final String encodedData = CartItemSave.encode(cartItemSave);
                                  await controller.sharedPrefClient.setCartItem(encodedData);
                                  controller.update();
                                },
                                child: Icon(Icons.clear, size: Dimens.size25, color: MyColors.textVColor.withOpacity(0.5),)),
                          ),
                        ],
                      ),

                      Container(
                        height: Dimens.size25,
                        //   color: MyColors.lightBlue,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            InkWell(
                              onTap: () async {
                                int count = 0;
                                final String? cartString = await controller.sharedPrefClient.getCartItem();
                                final List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
                                count = controller.cartdata[index].quantity -1;
                                if(count == 0){
                                  if (Get.find<HomeController>().homeData!.response!.featuredProduct!.isNotEmpty ||
                                      Get.find<HomeController>().homeData!.response!
                                          .featuredProduct!.length != 0) {
                                    for (int k = 0; k < Get.find<HomeController>().homeData!.response!.featuredProduct!.length;
                                    k++) {
                                      if (Get.find<HomeController>().homeData!.response!.featuredProduct![k].productStoreId ==
                                          cartItemSave[index].productStoreId) {
                                        printInfo(info: 'hgjg');
                                        Get.find<HomeController>()
                                            .homeData!
                                            .response!
                                            .featuredProduct![k]
                                            .itemCount
                                            .value =
                                        0;
                                      }
                                    }
                                  }
                                  if (Get.isRegistered<SubcategoryController>()) {
                                    final categoryController = Get.find<SubcategoryController>();
                                    if (categoryController.subCatModel!.isNotEmpty ||
                                        categoryController.subCatModel!.length != 0) {
                                      for (int i = 0; i < categoryController.subCatModel!.length; i++) {
                                        if (categoryController.subCatModel![i].products!.length != 0) {
                                          for (int k = 0; k < categoryController.subCatModel![i].products!.length; k++) {
                                            if (cartItemSave[index].productStoreId ==
                                                categoryController.subCatModel![i].products![k].productStoreId) {
                                              categoryController.subCatModel![i].products![k].itemCount.value =
                                              0;
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                  cartItemSave.removeAt(index);
                                  controller.cartdata.removeAt(index);
                                }else{
                                  cartItemSave[index].quantity--;
                                  controller.cartdata[index].quantity--;
                                  if (Get.find<HomeController>().homeData!.response!.featuredProduct!.isNotEmpty ||
                                      Get.find<HomeController>().homeData!.response!
                                          .featuredProduct!.length != 0) {
                                    for (int k = 0; k < Get.find<HomeController>().homeData!.response!.featuredProduct!.length;
                                    k++) {
                                      if (Get.find<HomeController>().homeData!.response!.featuredProduct![k].productStoreId ==
                                          cartItemSave[index].productStoreId) {
                                        printInfo(info: 'hgjg');
                                        Get.find<HomeController>()
                                            .homeData!
                                            .response!
                                            .featuredProduct![k]
                                            .itemCount
                                            .value =
                                            cartItemSave[index].quantity;
                                      }
                                    }
                                  }
                                  if (Get.isRegistered<SubcategoryController>()) {
                                    final categoryController = Get.find<SubcategoryController>();
                                    if (categoryController.subCatModel!.isNotEmpty ||
                                        categoryController.subCatModel!.length != 0) {
                                      for (int i = 0; i < categoryController.subCatModel!.length; i++) {
                                        if (categoryController.subCatModel![i].products!.length != 0) {
                                          for (int k = 0; k < categoryController.subCatModel![i].products!.length; k++) {
                                            if (cartItemSave[index].productStoreId ==
                                                categoryController.subCatModel![i].products![k].productStoreId) {
                                              categoryController.subCatModel![i].products![k].itemCount.value =
                                                  cartItemSave[index].quantity;
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                                Constants.cartCount.value = Constants.itemInCart(cartItemSave);
                                final String encodedData = CartItemSave.encode(cartItemSave);
                                await controller.sharedPrefClient.setCartItem(encodedData);
                                controller.update();

                              },
                              child: Container(
                                  height:  Dimens.size25,
                                  width: mediaQuery.width*0.06,
                                  decoration: BoxDecoration(
                                      color: MyColors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: MyColors.primaryColor
                                      )
                                  ),
                                  child: Center(child: Icon(Icons.remove,size: 16,
                                    color: MyColors.primaryColor,))),
                            ),
                            Text("$quantity"),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: InkWell(
                                onTap: () async {
                                  final String? cartString = await controller.sharedPrefClient.getCartItem();
                                  final List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
                                  cartItemSave[index].quantity++;
                                  controller.cartdata[index].quantity++;
                                  if (Get.find<HomeController>().homeData!.response!.featuredProduct!.isNotEmpty ||
                                      Get.find<HomeController>().homeData!.response!
                                          .featuredProduct!.length != 0) {
                                    for (int k = 0; k < Get.find<HomeController>().homeData!.response!.featuredProduct!.length;
                                    k++) {
                                      if (Get.find<HomeController>().homeData!.response!.featuredProduct![k].productStoreId ==
                                          cartItemSave[index].productStoreId) {
                                        printInfo(info: 'hgjg');
                                        Get.find<HomeController>()
                                            .homeData!
                                            .response!
                                            .featuredProduct![k]
                                            .itemCount
                                            .value =
                                            cartItemSave[index].quantity;
                                      }
                                    }
                                  }
                                  if (Get.isRegistered<SubcategoryController>()) {
                                    final categoryController = Get.find<SubcategoryController>();
                                    if (categoryController.subCatModel!.isNotEmpty ||
                                        categoryController.subCatModel!.length != 0) {
                                      for (int i = 0; i < categoryController.subCatModel!.length; i++) {
                                        if (categoryController.subCatModel![i].products!.length != 0) {
                                          for (int k = 0; k < categoryController.subCatModel![i].products!.length; k++) {
                                            if (cartItemSave[index].productStoreId ==
                                                categoryController.subCatModel![i].products![k].productStoreId) {
                                              categoryController.subCatModel![i].products![k].itemCount.value =
                                                  cartItemSave[index].quantity;
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                  Constants.cartCount.value = Constants.itemInCart(cartItemSave);
                                  final String encodedData = CartItemSave.encode(cartItemSave);
                                  await controller.sharedPrefClient.setCartItem(encodedData);

                                  controller.update();

                                },
                                child: Container(
                                    height:  Dimens.size25,
                                    width: mediaQuery.width*0.06,
                                    decoration: BoxDecoration(
                                        color: MyColors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: MyColors.primaryColor
                                        )
                                    ),

                                    child:  Center(child: Icon(Icons.add,size: 16,
                                      color:MyColors.primaryColor,))),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 5,),
            Divider()
          ],
        ),
      ),
    );
  }
}


