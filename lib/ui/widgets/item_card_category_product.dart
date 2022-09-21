import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/controller/favourite/favourite.dart';
import 'package:kiwkemart/data/controller/homepage_controller/homepage_controller.dart';
import 'package:kiwkemart/data/controller/sub_category_controller/sub_category_controller.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/category_product/category_product.dart';
import 'package:kiwkemart/data/model/favourite/favourite.dart';
import 'package:kiwkemart/data/shared_pref_client.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';

import '../../data/singleton/singleton.dart';
import '../values/my_imgs.dart';
import 'custom_button.dart';

class ItemCard extends StatelessWidget {
  final bool offer;
  String image;
  Product product;
  HomeController homeController = Get.find<HomeController>();
  final GlobalKey imageGlobalKey = GlobalKey();
  final void Function(GlobalKey) onClick;

  ItemCard(
      {Key? key,
      required this.product,
      required this.offer,
      required this.image,
      required this.onClick})
      : super(key: key);
  bool fav = false;
  final _sharedPrefClient = SharedPrefClient();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black38),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Opacity(
        opacity: product.stock == 0 ? 0.3 : 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Rect.fromLTWH(14, top, width, height)
            Container(
              height: 120,
              width: Get.width * 0.3,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: image == ''
                          ? Container(
                              key: imageGlobalKey,
                              child: Image.network(
                                product.image ?? '',
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              key: imageGlobalKey,
                              child: Image.network(
                                image + '/' + (product.image ?? ''),
                                fit: BoxFit.fill,
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() => GestureDetector(
                          onTap: () async {
                            {
                              if (product.isFav.value) {
                                product.isFav.value = false;
                                final String? favString =
                                    await _sharedPrefClient.getFavItem();
                                final List<FavouriteItem> favItemSave =
                                    FavouriteItem.decode(favString!);
                                favItemSave.removeWhere((element) =>
                                    element.productStoreId ==
                                    product.productStoreId);
                                final String encodedData =
                                    FavouriteItem.encode(favItemSave);
                                await _sharedPrefClient.setFavItem(encodedData);
                              } else {
                                product.isFav.value = true;
                                final String? favString =
                                    await _sharedPrefClient.getFavItem();
                                final List<FavouriteItem> favItemSave =
                                    FavouriteItem.decode(favString!);
                                favItemSave.add(FavouriteItem(
                                  productStoreId: product.productStoreId ?? 0,
                                  storeId: product.storeId,
                                  title: product.title ?? '',
                                  image: image + '/' + (product.image ?? ''),
                                  price: product.price,
                                  discount: product.discount,
                                  discountPrice: product.discountPrice,
                                  unit: product.unit ?? '',
                                  itemsPerUnit: product.itemsPerUnit ?? '',
                                  minOrder: product.minOrder ?? '',
                                  is18plus: product.is18plus ?? '',
                                  stock: product.stock ?? 0,
                                ));
                                final String encodedData =
                                    FavouriteItem.encode(favItemSave);
                                await _sharedPrefClient.setFavItem(encodedData);
                              }
                              if (Get.isRegistered<HomeController>()) {
                                if (Get.find<HomeController>()
                                    .homeData!
                                    .response!
                                    .featuredProduct!
                                    .isNotEmpty) {
                                  Get.find<HomeController>()
                                      .homeData!
                                      .response!
                                      .featuredProduct!
                                      .forEach((element) {
                                    if (product.productStoreId ==
                                        element.productStoreId) {
                                      element.isFav.value = product.isFav.value;
                                    }
                                  });
                                }
                              }
                              if (!product.isFav.value) {
                                if (Get.isRegistered<FavouriteController>()) {
                                  Get.find<FavouriteController>()
                                      .favItemSave
                                      .removeWhere((element) =>
                                          element.productStoreId ==
                                          product.productStoreId);
                                  Get.find<FavouriteController>().update();
                                }
                              }

                              if (Get.isRegistered<SubcategoryController>()) {
                                if (Get.find<SubcategoryController>()
                                    .subCatModel!
                                    .isNotEmpty) {
                                  Get.find<SubcategoryController>()
                                      .subCatModel!
                                      .forEach((element) {
                                    if (element.products!.isNotEmpty) {
                                      element.products!.forEach((elementP) {
                                        if (elementP.productStoreId ==
                                            product.productStoreId) {
                                          elementP.isFav.value =
                                              product.isFav.value;
                                        }
                                      });
                                    }
                                  });
                                }
                              }
                            }
                          },
                          child: product.isFav.value
                              ? Icon(
                                  Icons.favorite,
                                  color: MyColors.red500,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: MyColors.black.withOpacity(0.5),
                                ))),
                    ],
                  ),
                  Visibility(
                    visible: double.parse(product.discount!) > 0 ? false : true,
                    child: Container(
                      height: 16,
                      width: 35,
                      decoration: BoxDecoration(
                          color: MyColors.red500,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                          child: Text(
                        "-${product.discount}%",
                        style: TextStyle(color: MyColors.white, fontSize: 10),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: Get.width * 0.3,
              //  color: MyColors.yellow,
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 17,
                      width: Get.width * 0.3,
                      child: Text(
                        product.title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    Text(
                      product.unit!.toString(),
                      style: textTheme.caption,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${Constants.currency}${product.discountPrice}",
                          style: textTheme.subtitle1!.copyWith(
                              fontWeight: FontWeight.normal
                          ),
                        ),
                        // SizedBox(width: Dimens.size12,),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            "${Constants.currency}${product.price}",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Get.theme.primaryColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            product.stock == 0
                ? Container(
                    height: 26,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.size5),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        "Sold out",
                        style: Get.textTheme.subtitle1!
                            .copyWith(color: MyColors.white, fontSize: 12),
                      ),
                    ))
                : Obx(() {
                    return product.itemCount.value == 0
                        ? InkWell(
                            onTap: () async {
                              onClick(imageGlobalKey);
                              SingleToneValue.instance.isShowDialog
                                  ? showSheet(context)
                                  : Container();
                              // product.is18plus == '1'
                              //     ? Get.snackbar(
                              //         "Cart", 'This Product is for 18 plus')
                              //     : printInfo(info: 'Ready to go');
                              printInfo(
                                  info: image + '/' + (product.image ?? ''));
                              product.itemCount.value++;
                              if (homeController.homeData!.response!
                                      .featuredProduct!.isNotEmpty ||
                                  homeController.homeData!.response!
                                          .featuredProduct!.length !=
                                      0) {
                                for (int k = 0;
                                    k <
                                        homeController.homeData!.response!
                                            .featuredProduct!.length;
                                    k++) {
                                  if (homeController.homeData!.response!
                                          .featuredProduct![k].productStoreId ==
                                      product.productStoreId) {
                                    homeController
                                        .homeData!
                                        .response!
                                        .featuredProduct![k]
                                        .itemCount
                                        .value = product.itemCount.value;
                                  }
                                }
                              }
                              final String? cartString =
                                  await _sharedPrefClient.getCartItem();
                              final List<CartItemSave> cartItemSave =
                                  CartItemSave.decode(cartString!);
                              cartItemSave.add(CartItemSave(
                                productStoreId: product.productStoreId ?? 0,
                                storeId: 1,
                                quantity: product.itemCount.value,
                                image: image + '/' + (product.image ?? ''),
                                unit: product.unit ?? '',
                                title: product.title ?? '',
                                stock: product.stock ?? 7,
                                price: double.parse(product.discount ?? '0') > 0
                                    ? double.parse(product.discountPrice!)
                                    : double.parse(product.price!),
                              ));
                              Constants.cartCount.value =
                                  Constants.itemInCart(cartItemSave);
                              final String encodedData =
                                  CartItemSave.encode(cartItemSave);
                              await _sharedPrefClient.setCartItem(encodedData);
                            },
                            child: Container(
                                height: 26,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimens.size5),
                                  color: Get.theme.primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "Add to Basket",
                                    style: Get.textTheme.subtitle1!.copyWith(
                                        color: MyColors.white, fontSize: 12,
                                    fontWeight: FontWeight.w500
                                    ),
                                  ),
                                )),
                          )
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 26,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Get.theme.primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final String? cartString =
                                          await _sharedPrefClient.getCartItem();
                                      final List<CartItemSave> cartSaveItem =
                                          CartItemSave.decode(cartString!);
                                      if (product.itemCount.value == 1) {
                                        product.itemCount.value = 0;
                                        cartSaveItem.removeWhere((element) =>
                                            element.productStoreId ==
                                            product.productStoreId);
                                        Constants.cartCount.value =
                                            Constants.itemInCart(cartSaveItem);
                                        if (homeController.homeData!.response!
                                                .featuredProduct!.isNotEmpty ||
                                            homeController.homeData!.response!
                                                    .featuredProduct!.length !=
                                                0) {
                                          for (int k = 0;
                                              k <
                                                  homeController
                                                      .homeData!
                                                      .response!
                                                      .featuredProduct!
                                                      .length;
                                              k++) {
                                            if (homeController
                                                    .homeData!
                                                    .response!
                                                    .featuredProduct![k]
                                                    .productStoreId ==
                                                product.productStoreId) {
                                              homeController
                                                      .homeData!
                                                      .response!
                                                      .featuredProduct![k]
                                                      .itemCount
                                                      .value =
                                                  product.itemCount.value;
                                            }
                                          }
                                        }
                                        final String encodedData =
                                            CartItemSave.encode(cartSaveItem);
                                        await _sharedPrefClient
                                            .setCartItem(encodedData);
                                      } else {
                                        product.itemCount.value--;
                                        int i = cartSaveItem.indexWhere(
                                            (element) =>
                                                element.productStoreId ==
                                                    product.productStoreId &&
                                                element.storeId == 1);
                                        cartSaveItem[i].quantity =
                                            product.itemCount.value;
                                        Constants.cartCount.value =
                                            Constants.itemInCart(cartSaveItem);
                                        if (homeController.homeData!.response!
                                                .featuredProduct!.isNotEmpty ||
                                            homeController.homeData!.response!
                                                    .featuredProduct!.length !=
                                                0) {
                                          for (int k = 0;
                                              k <
                                                  homeController
                                                      .homeData!
                                                      .response!
                                                      .featuredProduct!
                                                      .length;
                                              k++) {
                                            if (homeController
                                                    .homeData!
                                                    .response!
                                                    .featuredProduct![k]
                                                    .productStoreId ==
                                                product.productStoreId) {
                                              printInfo(info: 'hgjg');
                                              homeController
                                                      .homeData!
                                                      .response!
                                                      .featuredProduct![k]
                                                      .itemCount
                                                      .value =
                                                  product.itemCount.value;
                                            }
                                          }
                                        }
                                        final String encodedData =
                                            CartItemSave.encode(cartSaveItem);
                                        await _sharedPrefClient
                                            .setCartItem(encodedData);
                                      }
                                    },
                                    child: Container(
                                      height: 26,
                                      width: 30,
                                      child: Center(
                                        child: Icon(
                                          Icons.remove,
                                          size: 20,
                                          color: MyColors.secondaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${product.itemCount.value}",
                                    style: TextStyle(
                                      color: theme.colorScheme.onPrimary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      {
                                        product.itemCount.value++;
                                        final String? cartString =
                                            await _sharedPrefClient
                                                .getCartItem();
                                        final List<CartItemSave> cartItemSave =
                                            CartItemSave.decode(cartString!);
                                        int i = cartItemSave.indexWhere(
                                            (element) =>
                                                element.productStoreId ==
                                                    product.productStoreId &&
                                                element.storeId == 1);
                                        cartItemSave[i].quantity =
                                            product.itemCount.value;
                                        Constants.cartCount.value =
                                            Constants.itemInCart(cartItemSave);
                                        if (homeController.homeData!.response!
                                                .featuredProduct!.isNotEmpty ||
                                            homeController.homeData!.response!
                                                    .featuredProduct!.length !=
                                                0) {
                                          for (int k = 0;
                                              k <
                                                  homeController
                                                      .homeData!
                                                      .response!
                                                      .featuredProduct!
                                                      .length;
                                              k++) {
                                            if (homeController
                                                    .homeData!
                                                    .response!
                                                    .featuredProduct![k]
                                                    .productStoreId ==
                                                product.productStoreId) {
                                              printInfo(info: 'hgjg');
                                              homeController
                                                      .homeData!
                                                      .response!
                                                      .featuredProduct![k]
                                                      .itemCount
                                                      .value =
                                                  product.itemCount.value;
                                            }
                                          }
                                        }
                                        final String encodedData =
                                            CartItemSave.encode(cartItemSave);
                                        await _sharedPrefClient
                                            .setCartItem(encodedData);
                                      }
                                    },
                                    child: Container(
                                      height: 26,
                                      width: 30,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 20,
                                          color: MyColors.secondaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  }),
          ],
        ),
      ),
    );
  }

  static showSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        backgroundColor: MyColors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: 320,
            decoration: BoxDecoration(
                color: MyColors.lightPrimary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50, child: Image.asset(MyImgs.child)),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: 250,
                      child: Text(
                        'You have items for ages 18+ in your basket.',
                        style: Get.theme.textTheme.headline2,
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: 250,
                      child: Text(
                        'Please have your ID ready for the rider.',
                        style: Get.theme.textTheme.bodyText2!
                            .copyWith(color: MyColors.grey, fontSize: 12),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      height: 0.05,
                      width: 0.8,
                      roundCorner: 5,
                      text: 'I Understand',
                      onPressed: () {
                        SingleToneValue.instance.isShowDialog = false;
                        Get.back();
                      })
                ],
              ),
            ),
          );
        });
  }
}
