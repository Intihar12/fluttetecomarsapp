import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/controller/homepage_controller/homepage_controller.dart';
import 'package:kiwkemart/data/controller/product_description_controller/product_description_controller.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/category_product/category_product.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/basket.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/item_card_homepage.dart';
import 'package:kiwkemart/ui/widgets/shimmer_effect/prduct_description_shimmer.dart';
import '../widgets/cart_animation/add_to_cart_animation.dart';
import '../widgets/cart_animation/add_to_cart_icon.dart';

class ProductDescription extends StatelessWidget {
  Product? product;

  ProductDescription({
    Key? key,
    this.product,
  }) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  final GlobalKey imageGlobalKey = GlobalKey();
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDesController>(
        init: ProductDesController(productId: product!.productStoreId),
        builder: (controller) {
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
                  title: Text("Product Description"),
                  elevation: 0,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, right: 10),
                      child: BasketWidget(
                        gkCart: gkCart,
                        basketColor: MyColors.white,
                      ),
                    ),
                  ],
                ),
                body: controller.isLoading || controller.model == null
                    ? Center(
                        child: ProductDescriptionShimmer(),
                      )
                    : SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.size15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Dimens.size15,
                              ),
                              Stack(
                                children: [
                                  Container(
                                      key: imageGlobalKey,
                                      height: Get.height * 0.2,
                                      width: Get.width * 1.0,
                                      child: Image.network(
                                        controller.model!.response!.imagesUrl! +
                                            '/' +
                                            controller.model!.response!.productDetail!.image!,
                                        fit: BoxFit.contain,
                                      )),
                                  Row(
                                    children: [
                                      Spacer(),
                                      GestureDetector(
                                          onTap: () {
                                            //Vibration.vibrate(duration: 100);
                                            if (product!.isFav.value) {
                                              product!.isFav.value = false;
                                            } else {
                                              product!.isFav.value = true;
                                            }
                                            controller.update();
                                          },
                                          child: product!.isFav.value == false
                                              ? Icon(
                                                  Icons.favorite_border,
                                                  color: MyColors.black,
                                                  size: Dimens.size30,
                                                )
                                              : Icon(Icons.favorite,
                                                  color: MyColors.red500,
                                                  size: Dimens.size30)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimens.size20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                        controller.model!.response!.productDetail!.title.toString(),
                                        style: Get.textTheme.headline4!
                                            .copyWith(color: MyColors.black)),
                                  ),
                               controller.model!.response!.productDetail!.discountPrice==0 ||
                                   controller.model!.response!.productDetail!.discountPrice==null ?
                               Text(
                                 '${Constants.currency}${controller.model!.response!.productDetail!.price.toString()}',
                                 style: Get.textTheme.headline4!
                                     .copyWith(color: MyColors.black),
                               )
                                 : Text(
                                    '${Constants.currency}${controller.model!.response!.productDetail!.discountPrice.toString()}',
                                    style: Get.textTheme.headline4!
                                        .copyWith(color: MyColors.black),
                                  ),
                                ],
                              ),
                              Text(
                                controller.model!.response!.productDetail!
                                        .itemsPerUnit
                                        .toString() +
                                    ' ' +
                                    controller
                                        .model!.response!.productDetail!.unit!,
                                style: Get.textTheme.headline5!.copyWith(
                                    color: MyColors.textVColor.withOpacity(0.5),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                color: MyColors.grey,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              product!.stock == 0
                                  ? Container(
                                      height: 45,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(Dimens.size5),
                                        color: Colors.black,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Sold out",
                                          style: Get.textTheme.subtitle1!
                                              .copyWith(
                                                  color: MyColors.white,
                                                  fontSize: 12),
                                        ),
                                      ))
                                  : product!.itemCount.value == 0
                                      ? CustomButton(
                                          height: 0.06,
                                          width: 1.0,
                                          roundCorner: 5,
                                          text: "Add to Basket",
                                          onPressed: () async {
                                            addClick(imageGlobalKey);
                                            // product!.is18plus == '1'
                                            //     ? Get.snackbar("Cart",
                                            //         'This Product is for 18 plus')
                                            //     : printInfo(
                                            //         info: 'Ready to go');
                                            product!.itemCount.value++;
                                            final String? cartString =
                                                await controller
                                                    .sharedPrefClient
                                                    .getCartItem();
                                            final List<CartItemSave>
                                                cartItemSave =
                                                CartItemSave.decode(
                                                    cartString!);
                                            cartItemSave.add(CartItemSave(
                                              productStoreId:
                                                  product!.productStoreId!,
                                              storeId: 1,
                                              quantity:
                                                  product!.itemCount.value,
                                              image: controller.model!.response!
                                                      .imagesUrl! +
                                                  '/' +
                                                  (product!.image ?? ''),
                                              unit: product!.unit ?? '',
                                              title: product!.title ?? '',
                                              stock: product!.stock ?? 7,
                                              price: double.parse(
                                                          product!.discount ??
                                                              '0') >
                                                      0
                                                  ? double.parse(
                                                      product!.discountPrice!)
                                                  : double.parse(
                                                      product!.price!),
                                            ));
                                            Constants.cartCount.value =
                                                Constants.itemInCart(
                                                    cartItemSave);
                                            if (homeController
                                                    .homeData!
                                                    .response!
                                                    .featuredProduct!
                                                    .isNotEmpty ||
                                                homeController
                                                        .homeData!
                                                        .response!
                                                        .featuredProduct!
                                                        .length !=
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
                                                    product!.productStoreId) {
                                                  printInfo(info: 'hgjg');
                                                  homeController
                                                          .homeData!
                                                          .response!
                                                          .featuredProduct![k]
                                                          .itemCount
                                                          .value =
                                                      product!.itemCount.value;
                                                }
                                              }
                                            }
                                            final String encodedData =
                                                CartItemSave.encode(
                                                    cartItemSave);
                                            await controller.sharedPrefClient
                                                .setCartItem(encodedData);
                                            controller.update();
                                          })
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                                onTap: () async {
                                                  final String? cartString =
                                                      await controller
                                                          .sharedPrefClient
                                                          .getCartItem();
                                                  final List<CartItemSave>
                                                      cartItemSave =
                                                      CartItemSave.decode(
                                                          cartString!);
                                                  cartItemSave.removeWhere(
                                                      (element) =>
                                                          element
                                                              .productStoreId ==
                                                          product!
                                                              .productStoreId);
                                                  product!.itemCount.value = 0;
                                                  Constants.cartCount.value =
                                                      Constants.itemInCart(
                                                          cartItemSave);
                                                  if (homeController
                                                          .homeData!
                                                          .response!
                                                          .featuredProduct!
                                                          .isNotEmpty ||
                                                      homeController
                                                              .homeData!
                                                              .response!
                                                              .featuredProduct!
                                                              .length !=
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
                                                              .featuredProduct![
                                                                  k]
                                                              .productStoreId ==
                                                          product!
                                                              .productStoreId) {
                                                        printInfo(info: 'hgjg');
                                                        homeController
                                                                .homeData!
                                                                .response!
                                                                .featuredProduct![k]
                                                                .itemCount
                                                                .value =
                                                            product!.itemCount
                                                                .value;
                                                      }
                                                    }
                                                  }
                                                  final String encodedData =
                                                      CartItemSave.encode(
                                                          cartItemSave);
                                                  await controller
                                                      .sharedPrefClient
                                                      .setCartItem(encodedData);
                                                  controller.update();
                                                },
                                                child: Image.asset(
                                                  MyImgs.bin,
                                                  height: Dimens.size35,
                                                  width: Dimens.size30,
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    final String? cartString =
                                                        await controller.sharedPrefClient.getCartItem();
                                                    final List<CartItemSave>cartSaveItem =
                                                        CartItemSave.decode(cartString!);
                                                    if (product!.itemCount.value == 1) {
                                                      product!.itemCount.value = 0;
                                                      cartSaveItem.removeWhere(
                                                          (element) => element.productStoreId == product!.productStoreId);
                                                      Constants.cartCount.value = Constants.itemInCart(cartSaveItem);
                                                      if (homeController.homeData!.response!.featuredProduct!.isNotEmpty ||
                                                          homeController.homeData!.response!.featuredProduct!.length != 0) {
                                                        for (int k = 0; k < homeController.homeData!.response!.featuredProduct!.length; k++) {
                                                          if (homeController.homeData!.response!.featuredProduct![k].productStoreId
                                                              ==product!.productStoreId)
                                                          {
                                                            printInfo(info: 'hgjg');
                                                            homeController.homeData!.response!.featuredProduct![k].itemCount.value
                                                            = product!.itemCount.value;
                                                          }
                                                        }
                                                      }
                                                      final String encodedData = CartItemSave.encode(cartSaveItem);
                                                      await controller.sharedPrefClient.setCartItem(encodedData);
                                                    } else {
                                                      product!.itemCount.value--;
                                                      int i = cartSaveItem.indexWhere((element) =>
                                                              element.productStoreId == product!.productStoreId && element.storeId == 1);
                                                      cartSaveItem[i].quantity = product!.itemCount.value;
                                                      Constants.cartCount.value = Constants.itemInCart(cartSaveItem);
                                                      if (homeController.homeData!.response!.featuredProduct!.isNotEmpty ||
                                                          homeController.homeData!.response!.featuredProduct!.length != 0)
                                                      {
                                                        for (int k = 0; k < homeController.homeData!.response!.featuredProduct!.length; k++)
                                                        {
                                                          if (homeController.homeData!.response!.featuredProduct![k]
                                                              .productStoreId == product!.productStoreId)
                                                          {
                                                            printInfo(
                                                                info: 'hgjg');
                                                            homeController.homeData!.response!.featuredProduct![k].itemCount.value
                                                            = product!.itemCount.value;
                                                          }
                                                        }
                                                      }
                                                      final String encodedData = CartItemSave.encode(cartSaveItem);
                                                      await controller.sharedPrefClient.setCartItem(encodedData);
                                                    }
                                                    controller.update();
                                                  },
                                                  child: Container(
                                                      height: Get.height * 0.04,
                                                      width: Get.width * 0.08,
                                                      decoration: BoxDecoration(
                                                          color: MyColors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(Dimens
                                                                      .size4),
                                                          border: Border.all(
                                                              color: MyColors
                                                                  .black)),
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.remove,
                                                        color: MyColors.black,
                                                      ))),
                                                ),
                                                SizedBox(
                                                  width: Dimens.size20,
                                                ),
                                                Obx(() {
                                                  return Text(
                                                      "${product!.itemCount.value}");
                                                }),
                                                SizedBox(
                                                  width: Dimens.size20,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    // addClick(imageGlobalKey);
                                                    product!.itemCount.value++;
                                                    final String? cartString = await controller.sharedPrefClient.getCartItem();
                                                    final List<CartItemSave>cartItemSave = CartItemSave.decode(cartString!);
                                                    int i = cartItemSave.indexWhere((element) =>
                                                            element.productStoreId == product!.productStoreId && element.storeId == 1);
                                                    cartItemSave[i].quantity = product!.itemCount.value;
                                                    Constants.cartCount.value = Constants.itemInCart(cartItemSave);
                                                    if (homeController.homeData!.response!.featuredProduct!.isNotEmpty ||
                                                        homeController.homeData!.response!.featuredProduct!.length != 0) {
                                                      for (int k = 0; k < homeController.homeData!.response!.featuredProduct!.length; k++)
                                                      {
                                                        if (homeController.homeData!.response!.featuredProduct![k].productStoreId
                                                            == product!.productStoreId) {
                                                          printInfo(
                                                              info: 'hgjg');
                                                          homeController.homeData!.response!.featuredProduct![k].itemCount.value
                                                          = product!.itemCount.value;
                                                        }
                                                      }
                                                    }
                                                    final String encodedData = CartItemSave.encode(cartItemSave);
                                                    await controller.sharedPrefClient.setCartItem(encodedData);
                                                    controller.update();
                                                  },
                                                  child: Container(
                                                      height: Get.height * 0.04,
                                                      width: Get.width * 0.08,
                                                      decoration: BoxDecoration(
                                                          color: MyColors
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.all(
                                                              color: MyColors
                                                                  .primaryColor)),
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.add,
                                                        color: MyColors
                                                            .secondaryColor,
                                                      ))),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                              SizedBox(
                                height: Dimens.size10,
                              ),
                              Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.size5)),
                                // elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Dimens.size5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Dimens.size5,
                                      ),
                                      Text("Product Description",
                                          style: Get.textTheme.headline4!
                                              .copyWith(color: MyColors.black)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Wrap(
                                        children: [
                                          Text(
                                            controller.model!.response!.productDetail!.description!,
                                            style: Get.textTheme.subtitle1!
                                                .copyWith(
                                                    color: MyColors.textVColor),
                                            textAlign: TextAlign.justify,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('You might also like '),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 200,
                                      // color: Colors.grey,
                                      child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: controller.model!.response!.otherProducts!.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return ItemCardHomePage(
                                            product: controller.model!.response!.otherProducts![index],
                                            image: controller.model!.response!.imagesUrl!,
                                            onTap: () async {
                                              await controller
                                                  .onProductDetail(controller.model!.response!.otherProducts![index].productStoreId.toString())
                                                  .then((value) async {
                                                if (value) {
                                                  await controller.manageCount();
                                                }
                                              });
                                            },
                                            onClick: (GlobalKey
                                                gkImageContainer) async {
                                              await runAddToCardAnimation(gkImageContainer);
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: Dimens.size15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dimens.size5,
                              ),
                              Divider(
                                thickness: 1,
                                color: MyColors.grey,
                              ),
                              SizedBox(
                                height: Dimens.size5,
                              ),
                              Text("About Product",
                                  style: Get.textTheme.headline4!
                                      .copyWith(color: MyColors.black)),
                              SizedBox(
                                height: Dimens.size10,
                              ),
                              SizedBox(
                                height: 80,
                                child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.model!.response!.productDetail!.tags!.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Image.network(controller.model!.response!.imagesUrl! +
                                                '/' +
                                                controller.model!.response!.productDetail!.tags![index].icon!),
                                          ),
                                          SizedBox(
                                            height: Dimens.size5,
                                          ),
                                          Text(
                                            controller.model!.response!.productDetail!.tags![index].name!,
                                            style: TextStyle(fontSize: 10),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: Dimens.size5,
                              ),
                              Text("Ingredients",
                                  style: Get.textTheme.headline4!
                                      .copyWith(color: MyColors.black)),
                              SizedBox(
                                height: Dimens.size5,
                              ),
                              Text(
                                  controller.model!.response!.productDetail!.ingredients == null
                                      ? ''
                                      : controller.model!.response!.productDetail!.ingredients!,
                                  style: Get.textTheme.subtitle1!
                                      .copyWith(color: MyColors.black)),
                              SizedBox(
                                height: Dimens.size5,
                              ),
                              Text("Allergen Information",
                                  style: Get.textTheme.headline4!
                                      .copyWith(color: MyColors.black)),
                              SizedBox(
                                height: Dimens.size5,
                              ),
                              Text(
                                  controller.model!.response!.productDetail!
                                              .allergenInformation ==
                                          null
                                      ? ''
                                      : controller.model!.response!
                                          .productDetail!.allergenInformation!,
                                  style: Get.textTheme.subtitle1!
                                      .copyWith(color: MyColors.black)),
                              SizedBox(
                                height: Dimens.size10,
                              ),
                              Text("Nutrition Information",
                                  style: Get.textTheme.headline4!
                                      .copyWith(color: MyColors.black)),
                              SizedBox(
                                height: Dimens.size10,
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Typical Values',
                                          style: Get.textTheme.subtitle2!
                                              .copyWith(
                                                  color: MyColors.black,
                                                  fontSize: 10)),
                                      Text('Per 100g\nof product',
                                          style: Get.textTheme.subtitle2!
                                              .copyWith(
                                                  color: MyColors.black,
                                                  fontSize: 10)),
                                      Text('% RI\nPer 100g',
                                          style: Get.textTheme.subtitle2!
                                              .copyWith(
                                                  color: MyColors.black,
                                                  fontSize: 10)),
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.model!.response!.productDetail!.nutrition!.length,
                                padding:
                                    const EdgeInsets.only(top: Dimens.size16),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: Dimens.size5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30, right: 30),
                                      child: Column(
                                        children: [
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                controller.model!.response!.productDetail!.nutrition![index].typicalValues!,
                                                style: Get.textTheme.subtitle2!
                                                    .copyWith(
                                                        color: MyColors
                                                            .textVColor
                                                            .withOpacity(0.5),
                                                        fontSize: 10),
                                              ),
                                              Text(
                                                controller.model!.response!.productDetail!.nutrition![index].per100GOfProduct!,
                                                style: Get.textTheme.subtitle2!
                                                    .copyWith(
                                                        color: MyColors
                                                            .textVColor
                                                            .withOpacity(0.5),
                                                        fontSize: 10),
                                              ),
                                              Text(
                                                controller.model!.response!.productDetail!.nutrition![index].riPer100G!,
                                                style: Get.textTheme.subtitle2!
                                                    .copyWith(
                                                        color: MyColors
                                                            .textVColor
                                                            .withOpacity(0.5),
                                                        fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: Dimens.size10,
                              ),
                              Text("Other",
                                  style: Get.textTheme.headline4!
                                      .copyWith(color: MyColors.black)),
                              SizedBox(
                                height: Dimens.size5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Country of Origin",
                                      style: Get.textTheme.subtitle1!
                                          .copyWith(color: MyColors.black)),
                                  Text(
                                      controller.model!.response!.productDetail!.countryOfOrigin == null
                                          ? ''
                                          : controller.model!.response!.productDetail!.countryOfOrigin!,
                                      style: Get.textTheme.subtitle1!
                                          .copyWith(color: MyColors.black))
                                ],
                              ),
                              SizedBox(
                                height: Dimens.size5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Storage conditions",
                                      style: Get.textTheme.subtitle1!
                                          .copyWith(color: MyColors.black)),
                                  Text(
                                      controller.model!.response!.productDetail!.storageConditions == null
                                          ? ''
                                          : controller.model!.response!.productDetail!.storageConditions!,
                                      style: Get.textTheme.subtitle1!
                                          .copyWith(color: MyColors.black))
                                ],
                              ),
                              SizedBox(
                                height: Dimens.size5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Expiration Date",
                                      style: Get.textTheme.subtitle1!
                                          .copyWith(color: MyColors.black)),
                                  Text(
                                      controller.model!.response!.productDetail!.expirationDate == null
                                          ? ''
                                          : controller.model!.response!.productDetail!.expirationDate!,
                                      style: Get.textTheme.subtitle1!
                                          .copyWith(color: MyColors.black))
                                ],
                              ),
                              SizedBox(
                                height: Dimens.size10,
                              ),
                              Text("Disclaimer",
                                  style: Get.textTheme.headline4!
                                      .copyWith(color: MyColors.black)),
                              SizedBox(
                                height: Dimens.size10,
                              ),
                              Text(
                                controller.model!.response!.productDetail!.disclaimer == null
                                    ? ''
                                    : controller.model!.response!.productDetail!.disclaimer!,
                                style: Get.textTheme.subtitle1!.copyWith(
                                    color: MyColors.textVColor,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: Dimens.size30,
                              ),
                            ],
                          ),
                        ),
                      )),
          ));
        });
  }

  void addClick(GlobalKey gkImageContainer) async {
    await runAddToCardAnimation(gkImageContainer);
  }
}
