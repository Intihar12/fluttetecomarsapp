import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/sub_category_controller/sub_category_controller.dart';
import 'package:kiwkemart/data/model/home_data/home_data.dart';
import 'package:kiwkemart/ui/product_description/product_description.dart';
import 'package:kiwkemart/ui/search_screen/search_screen.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/basket.dart';
import 'package:kiwkemart/ui/widgets/item_card_category_product.dart';
import 'package:kiwkemart/ui/widgets/scrolling_list_with_tabbar/scrollable_tabbar.dart';
import 'package:kiwkemart/ui/widgets/shimmer_effect/category_shimmer_effect.dart';
import '../widgets/cart_animation/add_to_cart_animation.dart';
import '../widgets/cart_animation/add_to_cart_icon.dart';

class ScrollerTabBar extends StatelessWidget {
  Categories category;
  final int id;
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  var _cartQuantityItems = 0;

  ScrollerTabBar({required this.id, required this.category, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubcategoryController>(
        init: SubcategoryController(category: category),
        builder: (controller) {
          return AddToCartAnimation(
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
            child: SafeArea(
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size(double.infinity, 110),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      color: Get.theme.primaryColor,
                      height: 110,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                    color: Get.theme.colorScheme.onPrimary,
                                  ),
                                ),
                                Text(category.name ?? '',
                                    style: Get.textTheme.headline3!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Get.to(SearchScreen());
                                        },
                                        child: Image.asset(
                                          MyImgs.searchIcon,
                                          height: 36,
                                          width: 36,
                                        )),
                                    SizedBox(
                                      width: Dimens.size5,
                                    ),
                                    BasketWidget(
                                      gkCart: gkCart,
                                      basketColor: MyColors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 30,
                            width: Get.width,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.subCategory!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: InkWell(
                                      onTap: () {
                                        controller.id1.value = index;
                                        controller.onCategoryProduct(
                                            controller.subCategory![index].id
                                                .toString(),
                                            controller.saveStoreData!.id
                                                .toString());
                                      },
                                      child: Container(
                                        // color: Colors.grey.shade300,
                                        child: Obx(
                                          () => Text(
                                            controller
                                                    .subCategory![index].name ??
                                                '',
                                            style: controller.id1.value == index
                                                ? TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 16,
                                                    color:
                                                        MyColors.secondaryColor,
                                                    fontWeight: FontWeight.w500)
                                                : TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    // decoration: TextDecoration.underline,
                                                    color: Colors.white
                                                        .withOpacity(0.7)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // body: GetBuilder<SubcategoryController>(
                //     builder: (value) {
                //       return
                //         controller.isLoading  ||
                //             controller.noInternet||
                //             controller.subCatModel==null? CategoryShimmerEffect():
                //         Container(
                //           child: AnimatedBuilder(
                //               animation: controller,
                //               builder: (_, context) {
                //                 return Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     SizedBox(height: 10,),
                //                     Container(
                //                       height: 50,
                //                       child: TabBar(
                //                         physics: BouncingScrollPhysics(),
                //                         labelPadding:
                //                         EdgeInsets.only(right: 5.0, left: 5.0),
                //                         onTap: /*(index){*/
                //                         controller.selectedTabMove,
                //                         //},
                //                         controller: controller.tabController,
                //                         isScrollable: true,
                //                         indicatorWeight: 0.1,
                //                         tabs: controller.tabs
                //                             .map((e) => TabBarWidget(e))
                //                             .toList(),
                //                       ),
                //                     ),
                //                     Expanded(
                //                       child: Container(
                //                         child: ListView.builder(
                //                             physics: BouncingScrollPhysics(),
                //                             controller: controller.modalController,
                //                             itemCount: value.subCatModel!.length,
                //                             itemBuilder: (context, idx) {
                //                               return
                //                                 Container(
                //                                   child: Column(
                //                                     crossAxisAlignment: CrossAxisAlignment.start,
                //                                     children: [
                //                                       Padding(
                //                                         padding:
                //                                         const EdgeInsets.all(8.0),
                //                                         child: Text(
                //                                           "${value.subCatModel![idx].name}",
                //                                           style: Get.textTheme.headline2,
                //                                         ),
                //                                       ),
                //                                       SizedBox(height: 5,),
                //
                //
                //                                      Container(
                //                                         child: Column(
                //                                           children: [
                //                                             GridView.builder(
                //                                                 shrinkWrap: true,
                //                                                 padding: EdgeInsets.symmetric(horizontal: 10),
                //                                                 physics:
                //                                                 NeverScrollableScrollPhysics(),
                //                                                 gridDelegate:
                //                                                 SliverGridDelegateWithMaxCrossAxisExtent(
                //                                                     maxCrossAxisExtent: 140,
                //                                                     childAspectRatio: 4 / 6,
                //                                                     crossAxisSpacing: 5,
                //                                                     mainAxisSpacing: 20),
                //                                                 itemCount: value.subCatModel![idx].products!.length,
                //                                                 itemBuilder:
                //                                                     (BuildContext ctx,
                //                                                     index) {
                //                                                   return InkWell(
                //                                                     onTap: () {
                //                                                       Get.to(
                //                                                         ProductDescription(
                //                                                           product: value.subCatModel![idx].products![index],
                //                                                           ),
                //                                                       );
                //                                                     },
                //                                                     child: ItemCard(
                //                                                       image:   value.categoryProduct!.response!.imagesUrl ?? '',
                //                                                       product: value.subCatModel![idx].products![index],
                //                                                       offer: true,
                //                                                     ),
                //                                                   );
                //                                                 }),
                //
                //                                             controller.categoryProduct!.response!.categories!.subCategories!.length-1==idx?
                //                                                   SizedBox(height: 300,):SizedBox(),
                //                                           ],
                //                                         ),
                //                                       )
                //
                //
                //                                     ],
                //                                   ),
                //                                 );
                //                             }
                //                           // else {
                //                           //   return Container(
                //                           //     child: Text("${value.subCatModel[idx].title}",
                //                           //       style: Get.textTheme.headline2,),
                //                           //   );
                //                           // }
                //                         ),
                //                       ),
                //                     )
                //                   ],
                //                 );
                //               }),
                //         );
                //     }),
                body: GetBuilder<SubcategoryController>(builder: (value) {
                  return controller.isLoading ||
                          controller.noInternet ||
                          controller.subCatModel == null
                      ? CategoryShimmerEffect()
                      : VerticalScrollableTabView(
                          tabController: controller.tabController!,
                          slivers: [
                            SliverAppBar(
                              elevation: 0,
                              pinned: true,
                              automaticallyImplyLeading: false,
                              backgroundColor: MyColors.white,
                              flexibleSpace: FlexibleSpaceBar(
                                titlePadding: EdgeInsets.only(bottom: 50),
                                collapseMode: CollapseMode.pin,
                              ),
                              bottom: PreferredSize(
                                preferredSize: const Size.fromHeight(15),
                                child: Align(
                                  alignment: Alignment.centerLeft, 
                                  child: TabBar(
                                    unselectedLabelStyle:
                                        Get.textTheme.subtitle1!.copyWith(
                                            fontWeight: FontWeight.normal),
                                    padding: EdgeInsets.only(bottom: 15,top: 5),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicator: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: MyColors.white),
                                        color: MyColors.primaryColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    indicatorColor: Colors.black,
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.black,
                                    physics: BouncingScrollPhysics(),
                                    indicatorPadding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    labelPadding:
                                        EdgeInsets.only(right: 5.0, left: 5.0),
                                    onTap: (index) {
                                      VerticalScrollableTabBarStatus.setIndex(
                                          index);
                                    },
                                    labelStyle: Get.textTheme.subtitle1!
                                        .copyWith(
                                            fontWeight: FontWeight.normal),
                                    controller: controller.tabController,
                                    isScrollable: true,
                                    indicatorWeight: 0.1,
                                    tabs: controller.tabs
                                        .map((e) => TabBarWidget1(e))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          listItemData: value.subCatModel!,
                          eachItemChild: (aaa, int idx) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "${value.subCatModel![idx].name}",
                                      style: Get.textTheme.headline2!.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                            top: 30,right: 10,bottom: 30,left: 10),
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 150,
                                                childAspectRatio: 4 / 7,
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 20),
                                        itemCount: value
                                            .subCatModel![idx].products!.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return InkWell(
                                            onTap: () {
                                              Get.to(
                                                ProductDescription(
                                                  product: value
                                                      .subCatModel![idx]
                                                      .products![index],
                                                ),
                                              );
                                            },
                                            child: ItemCard(
                                              image: value.categoryProduct!
                                                      .response!.imagesUrl ??
                                                  '',
                                              product: value.subCatModel![idx]
                                                  .products![index],
                                              offer: true,
                                              onClick: (GlobalKey
                                                  gkImageContainer) async {
                                                await runAddToCardAnimation(
                                                    gkImageContainer);
                                              },
                                              // runAddToCardAnimation: this.runAddToCardAnimation,
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                }),
              ),
            ),
          );
        });
  }
}

class TabBarWidget1 extends StatelessWidget {
  TabBarWidget1(this.categoryTab);

  final CategoryTabs categoryTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: MyColors.textVColor, width: 1)),
      child: Container(
          height: 40,
          child: Center(child: Text(categoryTab.catModel.name ?? ''))),
    );
    //  );
    // );
  }
}

class TabBarWidget extends StatelessWidget {
  TabBarWidget(this.categoryTab);

  final CategoryTabs categoryTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: categoryTab.selected ? Get.theme.primaryColor : Colors.white,
          border: categoryTab.selected
              ? Border.all(color: Get.theme.primaryColor, width: 1)
              : Border.all(color: MyColors.textVColor, width: 1)),
      child: SizedBox(
          height: 40,
          width: 100,
          child: Center(
              child: Text(
            categoryTab.catModel.name ?? '',
            style: Get.textTheme.subtitle1!.copyWith(
              color: categoryTab.selected
                  ? MyColors.white
                  : Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w400,
            ),
          ))),
    );
    //  );
    // );
  }
}
