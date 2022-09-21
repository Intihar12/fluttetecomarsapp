import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/product_search/product_search.dart';
import 'package:kiwkemart/ui/product_description/product_description.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/widgets/basket.dart';
import 'package:kiwkemart/ui/widgets/custom_textfield.dart';
import 'package:kiwkemart/ui/widgets/item_card_category_product.dart';

import '../widgets/cart_animation/add_to_cart_animation.dart';
import '../widgets/cart_animation/add_to_cart_icon.dart';

class SearchScreen extends StatelessWidget {
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
          title: Text("Search"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: BasketWidget(gkCart: gkCart, basketColor: MyColors.white),
            )
          ],
        ),
        body: GetBuilder<ProductSearch>(
            init: ProductSearch(),
            builder: (controller) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                            height: mediaQuery.height * 0.05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: MyColors.white200),
                            child: Center(
                              child: CustomTextField(
                                onChanged: (v) {
                                  if (v.isNotEmpty) {
                                    if (v.toString().length > 2) {
                                      controller.onSearchWord(
                                          controller.searchTextController.text);
                                    } else {
                                      controller.searchedProducts = null;
                                      controller.update();
                                    }
                                  }
                                },
                                controller: controller.searchTextController,
                                icon: Icon(Icons.search),
                                text: "I am looking for",
                                length: 55,
                                keyboardType: TextInputType.text,
                                inputFormatters: FilteringTextInputFormatter
                                    .singleLineFormatter,
                                border: InputBorder.none,
                              ),
                            )),
                      ],
                    ),
                  ),
                  controller.isLoading
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 58.0),
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .searchKeyword!.response!.keyWords!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.searchTextController.text =
                                            controller.searchKeyword!.response!
                                                    .keyWords![index].keyWord ??
                                                '';
                                        controller.onSearchWord(controller
                                                .searchKeyword!
                                                .response!
                                                .keyWords![index]
                                                .keyWord ??
                                            '');
                                      },
                                      child: Text(controller
                                              .searchKeyword!
                                              .response!
                                              .keyWords![index]
                                              .keyWord ??
                                          ''),
                                    ));
                              }),
                        ),
                  controller.isLoading ||
                          controller.searchedProducts == null ||
                          controller
                              .searchedProducts!.response!.products!.isEmpty
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Container(
                            child: Column(
                              children: [
                                GridView.builder(
                                    shrinkWrap: true,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 140,
                                            childAspectRatio: 4 / 7,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 20),
                                    itemCount: controller.searchedProducts!
                                        .response!.products!.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.to(
                                            ProductDescription(
                                              product: controller
                                                  .searchedProducts!
                                                  .response!
                                                  .products![index],
                                            ),
                                          );
                                        },
                                        child: ItemCard(
                                          image: controller.searchedProducts!
                                                  .response!.imagesUrl ??
                                              '',
                                          product: controller.searchedProducts!
                                              .response!.products![index],
                                          offer: true,
                                          onClick: (GlobalKey
                                              gkImageContainer) async {
                                            await runAddToCardAnimation(
                                                gkImageContainer);
                                          },
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        )




                  //yjrhyrr
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 98.0),
                  //   child: ListView.builder(
                  //       physics: NeverScrollableScrollPhysics(),
                  //       scrollDirection: Axis.vertical,
                  //       itemCount: controller.searchedProducts!.response!.products!.length,
                  //       itemBuilder: (context, index){
                  //         return  Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child:
                  //             GestureDetector(
                  //               onTap: (){
                  //                 controller.onSearchWord(controller.searchKeyword!.response!.keyWords![index].keyWord ?? '');
                  //               },
                  //               child:  Text(
                  //                   controller.searchedProducts!.response!.products![index].title ?? ''
                  //               ),
                  //             )
                  //
                  //         );
                  //       }),
                  // ),
                ],
              );
            }),
      ),
    ));
  }
}
