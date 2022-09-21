import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/homepage_controller/homepage_controller.dart';
import 'package:kiwkemart/data/model/home_data/home_data.dart' as home;
import 'package:kiwkemart/data/shared_pref_client.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/address/save_adress.dart';
import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';
import 'package:kiwkemart/ui/product_description/product_description.dart';
import 'package:kiwkemart/ui/search_screen/search_screen.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/item_card_homepage.dart';
import 'package:kiwkemart/ui/widgets/shimmer_effect/shimmer_effect.dart';
import '../subcategories/scroller_tabbar.dart';
import '../widgets/basket.dart';
import '../widgets/cart_animation/add_to_cart_animation.dart';
import '../widgets/cart_animation/add_to_cart_icon.dart';
import 'components/drawer.dart';
import 'components/home_slider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final sharedPrefClient = SharedPrefClient();
  //HomeController homeController=Get.put( HomeController());
  @override
  Widget build(BuildContext context) {
    HomeController homeController=Get.put( HomeController(context: context));
    return GetBuilder<HomeController>(
        init: HomeController(context: context),
        builder: (controller) {
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
              receiveCreateAddToCardAnimationMethod:
                  (addToCardAnimationMethod) {
                // You can run the animation by addToCardAnimationMethod, just pass trough the the global key of  the image as parameter
                this.runAddToCardAnimation = addToCardAnimationMethod;
              },
              child: Scaffold(
                key: scaffoldKey,
                drawer: MyDrawer(),
                appBar: PreferredSize(
                  preferredSize: Size(double.infinity, 140),
                  child: Container(
                    color: MyColors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    // color: MyColors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    scaffoldKey.currentState!
                                        .openDrawer();
                                  },
                                  child: Image.asset(
                                    MyImgs.drawerIcon,
                                    height: Dimens.size16,
                                    width: Dimens.size24,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Image.asset(
                                MyImgs.blueLogo,
                                height: 47,
                                width: 56,
                              )),
                              Container(
                                width: 100,
                                //    color: Colors.amberAccent,
                                child: Row(
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
                                      width: 10,
                                    ),
                                    BasketWidget(
                                      gkCart: gkCart,
                                      basketColor: MyColors.black,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: Dimens.size10,
                          ),
                          child: Container(
                            height: Dimens.size50,
                            width: mediaQuery.width,
                            decoration:
                                BoxDecoration(color: MyColors.lightPrimary),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    String? userId= await sharedPrefClient.getUserId();
                                    if(userId=='-21'){
                                      Get.to(MapScreen(
                                        id: SingleToneValue.instance.guestUserId,
                                      ));
                                    }
                                    else{
                                      Get.to(SaveAddress(
                                        SingleToneValue.instance.homePageId,
                                      ));
                                    }

                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Image.asset(MyImgs.locationHomeImg,
                                        height: 25,
                                          width: 18,
                                        )
                                      ),
                                      SizedBox(
                                        width: Dimens.size5,
                                      ),
                                      Container(
                                        height: Dimens.size50,
                                        width: mediaQuery.width * 0.45,
                                        // color: MyColors.grey,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: controller.address==null?
                                          Text(
                                            SingleToneValue.instance.currentAddress,
                                            overflow: TextOverflow.ellipsis,
                                            style: Get.textTheme.subtitle1!
                                                .copyWith(
                                                color: MyColors.black,
                                                fontWeight: FontWeight.w500
                                            ),
                                          )
                                           : Text(
                                           controller.address!,
                                            overflow: TextOverflow.ellipsis,
                                            style: Get.textTheme.subtitle1!
                                                .copyWith(
                                                    color: MyColors.black,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  height: 50,
                                  width: 144,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(45),
                                    ),
                                    color: MyColors.primaryColor,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: Dimens.size10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 5,),
                                          Text(
                                            "Opening Time",
                                            style: Get.textTheme.subtitle1!
                                                .copyWith(
                                                    color: MyColors.white,
                                            fontWeight: FontWeight.normal
                                            ),
                                          ),
                                          controller.noInternet ||
                                                  controller.isLoading ||
                                                  controller.homeData == null
                                              ? SizedBox()
                                              : Text(
                                                  controller
                                                          .homeData!
                                                          .response!
                                                          .store!
                                                          .openingClosingTime ??
                                                      "9:00-16:00",
                                                  style: Get
                                                      .textTheme.subtitle2!
                                                      .copyWith(
                                                          color:
                                                              MyColors.white,
                                                      fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body:
                    // GetBuilder<HomeController>(
                    //       builder: (value) =>
                    Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                          child: SizedBox(
                        height: 150,
                        child: FadedScaleAnimation(controller.isLoading ||
                                    controller.noInternet ||
                                    controller.homeData == null
                                ? buildBanner(context)
                               // : buildBanner(context)
                       : HomeSlide()
                            // :HomeSlider(controller.homeData!.response!.banners)
                            ),
                      )),
                      SliverToBoxAdapter(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Featured Products",
                          style: Get.textTheme.headline2!.copyWith(
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 200,
                          // color: MyColors.yellow,
                          child: controller.isLoading ||
                                  controller.noInternet ||
                                  controller.homeData == null
                              ? featureProduct(context)
                              : ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: controller.homeData!.response!
                                      .featuredProduct!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return ItemCardHomePage(
                                      product: controller.homeData!.response!.featuredProduct![index],
                                      image: controller
                                          .homeData!.response!.imagesUrl!,
                                      onTap: () async {

                                        Get.to(
                                          ProductDescription(
                                            product: controller
                                                .homeData!
                                                .response!
                                                .featuredProduct![index],
                                          ),
                                        );
                                      },
                                      onClick:
                                          (GlobalKey gkImageContainer) async {
                                        await runAddToCardAnimation(
                                            gkImageContainer);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: Dimens.size15,
                                  ),
                                ),
                        ),
                      ),
                      SliverList(
                        delegate:
                            SliverChildListDelegate(
                                controller.isLoading ||
                                        controller.noInternet ||
                                        controller.homeData == null
                                    ? List.generate(
                                        1, (index) => gridListShimmer(context))
                                    : List.generate(
                                        controller.homeData!.response!
                                            .categories!.length, (idx) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                controller
                                                        .homeData!
                                                        .response!
                                                        .categories![idx]
                                                        .name ??
                                                    '',
                                                style: Get.textTheme.headline4!
                                                    .copyWith(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            controller
                                                        .homeData!
                                                        .response!
                                                        .categories![idx]
                                                        .subCategories!
                                                        .length ==
                                                    9
                                                ? Container(
                                                    child: StaggeredGridView
                                                        .countBuilder(
                                                      crossAxisCount: 3,
                                                      itemCount: controller
                                                          .homeData!
                                                          .response!
                                                          .categories![idx]
                                                          .subCategories!
                                                          .length,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              GenreTile(
                                                        index: index,
                                                        data: controller
                                                            .homeData!
                                                            .response!
                                                            .categories![idx]
                                                            .subCategories,
                                                        categories: controller
                                                            .homeData!
                                                            .response!
                                                            .categories![idx],
                                                        imageUrl: controller
                                                            .homeData!
                                                            .response!
                                                            .imagesUrl,
                                                      ),
                                                      // Text(''),
                                                      staggeredTileBuilder:
                                                          (index) =>
                                                              StaggeredTile
                                                                  .count(
                                                                      (3 % 3 ==
                                                                              0)
                                                                          ? 1
                                                                          : 3,
                                                                      (3 % 3 ==
                                                                              0)
                                                                          ? 1
                                                                          : 3),
                                                      mainAxisSpacing: 8.0,
                                                      crossAxisSpacing: 8.0,
                                                    ),
                                                  )
                                                //else if( item[index]%3==2)
                                                : controller
                                                            .homeData!
                                                            .response!
                                                            .categories![idx]
                                                            .subCategories!
                                                            .length ==
                                                        8
                                                    ? Container(
                                                        child: StaggeredGridView
                                                            .countBuilder(
                                                          crossAxisCount: 3,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: controller
                                                              .homeData!
                                                              .response!
                                                              .categories![idx]
                                                              .subCategories!
                                                              .length,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              GenreTile(
                                                            index: index,
                                                            data: controller
                                                                .homeData!
                                                                .response!
                                                                .categories![
                                                                    idx]
                                                                .subCategories,
                                                            categories: controller
                                                                    .homeData!
                                                                    .response!
                                                                    .categories![
                                                                idx],
                                                            imageUrl: controller
                                                                .homeData!
                                                                .response!
                                                                .imagesUrl,
                                                          ),
                                                          staggeredTileBuilder:
                                                              (index) => index ==
                                                                          0 ||
                                                                      index ==
                                                                          3 ||
                                                                      index ==
                                                                          4 ||
                                                                      index == 7
                                                                  ? StaggeredTile
                                                                      .count(
                                                                          2, 1)
                                                                  : StaggeredTile
                                                                      .count(
                                                                          1, 1),
                                                          mainAxisSpacing: 8.0,
                                                          crossAxisSpacing: 8.0,
                                                        ),
                                                      )
                                                    : controller
                                                                .homeData!
                                                                .response!
                                                                .categories![
                                                                    idx]
                                                                .subCategories!
                                                                .length ==
                                                            5
                                                        ? Container(
                                                            child:
                                                                StaggeredGridView
                                                                    .countBuilder(
                                                              crossAxisCount: 3,
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: controller
                                                                  .homeData!
                                                                  .response!
                                                                  .categories![
                                                                      idx]
                                                                  .subCategories!
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      GenreTile(
                                                                index: index,
                                                                data: controller
                                                                    .homeData!
                                                                    .response!
                                                                    .categories![
                                                                        idx]
                                                                    .subCategories,
                                                                categories: controller
                                                                    .homeData!
                                                                    .response!
                                                                    .categories![idx],
                                                                imageUrl: controller
                                                                    .homeData!
                                                                    .response!
                                                                    .imagesUrl,
                                                              ),
                                                              staggeredTileBuilder: (index) =>
                                                                  StaggeredTile.count(
                                                                      (index % 8 ==
                                                                              0)
                                                                          ? 2
                                                                          : 1,
                                                                      (index % 3 ==
                                                                              0)
                                                                          ? 1
                                                                          : 1),
                                                              mainAxisSpacing:
                                                                  8.0,
                                                              crossAxisSpacing:
                                                                  8.0,
                                                            ),
                                                          )
                                                        : controller
                                                                    .homeData!
                                                                    .response!
                                                                    .categories![
                                                                        idx]
                                                                    .subCategories!
                                                                    .length ==
                                                                2
                                                            ? Container(
                                                                child: StaggeredGridView
                                                                    .countBuilder(
                                                                  crossAxisCount:
                                                                      3,
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  itemCount: controller
                                                                      .homeData!
                                                                      .response!
                                                                      .categories![
                                                                          idx]
                                                                      .subCategories!
                                                                      .length,
                                                                  itemBuilder: (context,
                                                                          index) =>
                                                                      GenreTile(
                                                                    index:
                                                                        index,
                                                                    data: controller
                                                                        .homeData!
                                                                        .response!
                                                                        .categories![
                                                                            idx]
                                                                        .subCategories,
                                                                    categories: controller
                                                                        .homeData!
                                                                        .response!
                                                                        .categories![idx],
                                                                    imageUrl: controller
                                                                        .homeData!
                                                                        .response!
                                                                        .imagesUrl,
                                                                  ),
                                                                  staggeredTileBuilder: (index) => StaggeredTile.count(
                                                                      (index % 2 ==
                                                                              0)
                                                                          ? 2
                                                                          : 1,
                                                                      (index % 2 ==
                                                                              0)
                                                                          ? 1
                                                                          : 1),
                                                                  mainAxisSpacing:
                                                                      8.0,
                                                                  crossAxisSpacing:
                                                                      8.0,
                                                                ),
                                                              ) //if (item[index] %3==1)
                                                            : controller
                                                                        .homeData!
                                                                        .response!
                                                                        .categories![
                                                                            idx]
                                                                        .subCategories!
                                                                        .length ==
                                                                    7
                                                                ? Container(
                                                                    child: StaggeredGridView
                                                                        .countBuilder(
                                                                      crossAxisCount:
                                                                          3,
                                                                      shrinkWrap:
                                                                          true,
                                                                      itemCount: controller
                                                                          .homeData!
                                                                          .response!
                                                                          .categories![
                                                                              idx]
                                                                          .subCategories!
                                                                          .length,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      itemBuilder:
                                                                          (context, index) =>
                                                                              GenreTile(
                                                                        index:
                                                                            index,
                                                                        data: controller
                                                                            .homeData!
                                                                            .response!
                                                                            .categories![idx]
                                                                            .subCategories,
                                                                        categories: controller
                                                                            .homeData!
                                                                            .response!
                                                                            .categories![idx],
                                                                        imageUrl: controller
                                                                            .homeData!
                                                                            .response!
                                                                            .imagesUrl,
                                                                      ),
                                                                      staggeredTileBuilder: (index) => index == 0 ||
                                                                              index ==
                                                                                  3
                                                                          ? StaggeredTile.count(
                                                                              2,
                                                                              1)
                                                                          : StaggeredTile.count(
                                                                              1,
                                                                              1),
                                                                      mainAxisSpacing:
                                                                          8.0,
                                                                      crossAxisSpacing:
                                                                          8.0,
                                                                    ),
                                                                  )
                                                                : controller
                                                                            .homeData!
                                                                            .response!
                                                                            .categories![
                                                                                idx]
                                                                            .subCategories!
                                                                            .length ==
                                                                        4
                                                                    ? Container(
                                                                        child: StaggeredGridView
                                                                            .countBuilder(
                                                                          crossAxisCount:
                                                                              3,
                                                                          physics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: controller
                                                                              .homeData!
                                                                              .response!
                                                                              .categories![idx]
                                                                              .subCategories!
                                                                              .length,
                                                                          itemBuilder: (context, index) =>
                                                                              GenreTile(
                                                                            index:
                                                                                index,
                                                                            data:
                                                                                controller.homeData!.response!.categories![idx].subCategories,
                                                                            imageUrl:
                                                                                controller.homeData!.response!.imagesUrl,
                                                                            categories:
                                                                                controller.homeData!.response!.categories![idx],
                                                                          ),
                                                                          staggeredTileBuilder: (index) => index == 0 || index == 3
                                                                              ? StaggeredTile.count(2, 1)
                                                                              : StaggeredTile.count(1, 1),
                                                                          mainAxisSpacing:
                                                                              8.0,
                                                                          crossAxisSpacing:
                                                                              8.0,
                                                                        ),
                                                                      )
                                                                    : controller.homeData!.response!.categories![idx].subCategories!.length ==
                                                                            1
                                                                        ? Container(
                                                                            child:
                                                                                StaggeredGridView.countBuilder(
                                                                              crossAxisCount: 3,
                                                                              shrinkWrap: true,
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              itemCount: controller.homeData!.response!.categories![idx].subCategories!.length,
                                                                              itemBuilder: (context, index) => GenreTile(
                                                                                index: index,
                                                                                imageUrl: controller.homeData!.response!.imagesUrl,
                                                                                data: controller.homeData!.response!.categories![idx].subCategories,
                                                                                categories: controller.homeData!.response!.categories![idx],
                                                                              ),
                                                                              staggeredTileBuilder: (index) => StaggeredTile.count((index % 3 == 0) ? 1 : 3, (index % 3 == 0) ? 1 : 3),
                                                                              mainAxisSpacing: 8.0,
                                                                              crossAxisSpacing: 8.0,
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child:
                                                                                StaggeredGridView.countBuilder(
                                                                              crossAxisCount: 3,
                                                                              itemCount: controller.homeData!.response!.categories![idx].subCategories!.length,
                                                                              physics: NeverScrollableScrollPhysics(),
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (context, index) => GenreTile(
                                                                                index: index,
                                                                                imageUrl: controller.homeData!.response!.imagesUrl,
                                                                                data: controller.homeData!.response!.categories![idx].subCategories,
                                                                                categories: controller.homeData!.response!.categories![idx],
                                                                              ),
                                                                              // Text(''),
                                                                              staggeredTileBuilder: (index) => StaggeredTile.count((3 % 3 == 0) ? 1 : 3, (3 % 3 == 0) ? 1 : 3),
                                                                              mainAxisSpacing: 8.0,
                                                                              crossAxisSpacing: 8.0,
                                                                            ),
                                                                          )
                                          ],
                                        );
                                      })),
                      ),
                    ],
                  ),
                ),
                // ),
              ),
            ),
          );
        });
  }

  /// banner shimmer effect
  Widget buildBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ShimmerEffect.fun(
        color: Colors.grey.shade300,
        color2: Colors.grey.shade100,
        child: buildContainer(
            height: 150, width: Get.width, color: MyColors.grey, round: 10),
      ),
    );
  }

  Widget buildBanner1(BuildContext context, String image) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 150,
      width: Get.width,
      child: Image.asset(
        image,
        fit: BoxFit.fill,
      ),
    );
  }

  ///  feature product
  Widget featureProduct(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ShimmerEffect.fun(
        color: Colors.grey.shade300,
        color2: Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildContainer(
                height: 150,
                width: Get.width * 0.28,
                color: MyColors.grey,
                round: 10),
            buildContainer(
                height: 150,
                width: Get.width * 0.28,
                color: MyColors.grey,
                round: 10),
            buildContainer(
                height: 150,
                width: Get.width * 0.28,
                color: MyColors.grey,
                round: 10),
          ],
        ),
      ),
    );
  }

  ///  grid of list

  Widget gridListShimmer(BuildContext context) {
    return ShimmerEffect.fun(
      color: Colors.grey.shade300,
      color2: Colors.grey.shade100,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('categories'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildContainer(
                      height: 110,
                      width: Get.width * 0.275,
                      color: MyColors.grey,
                      round: 10),
                  buildContainer(
                      height: 110,
                      width: Get.width * 0.275,
                      color: MyColors.grey,
                      round: 10),
                  buildContainer(
                      height: 110,
                      width: Get.width * 0.275,
                      color: MyColors.grey,
                      round: 10),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildContainer(
                      height: 110,
                      width: Get.width * 0.275,
                      color: MyColors.grey,
                      round: 10),
                  buildContainer(
                      height: 110,
                      width: Get.width * 0.275,
                      color: MyColors.grey,
                      round: 10),
                  buildContainer(
                      height: 110,
                      width: Get.width * 0.275,
                      color: MyColors.grey,
                      round: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer(
      {required double height,
      required double width,
      required Color color,
      required double round}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(round), color: color),
    );
  }
}

class GenreTile extends StatelessWidget {
  int? index;
  List<home.SubCategories>? data;
  home.Categories categories;
  String? imageUrl;

  GenreTile({
    this.data,
    this.index,
    required this.categories,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    printInfo(info: 'CAT LENGTH' + data!.length.toString());
    return index! >= 0
        ? InkWell(
            onTap: () {
              printInfo(
                  info: 'CAT NAME' +
                      data![index ?? 0].name.toString() +
                      'CAT ID' +
                      data![index ?? 0].id.toString());
              Get.to(ScrollerTabBar(
                id: data![index ?? 0].id!,
                //  id: 7,
                category: categories,
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color(int.parse(
                      (0xff).toString() +
                          data![index ?? 0]
                              .backgroundColor!
                              .replaceAll('#', ''),
                      radix: 16)),
                  borderRadius: BorderRadius.circular(8)),

              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10)
              //  ),
              // elevation: 2,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: (Image.network(
                          "${imageUrl}/${data![index ?? 0].image!}",
                          fit: BoxFit.cover,
                          // width: 150,
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: Text(
                      data![index ?? 0].name ?? '',
                      textAlign: TextAlign.left,
                      style: Get.textTheme.headline6!.copyWith(
                        color: MyColors.black,
                        fontWeight: FontWeight.w600

                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
  }
}
