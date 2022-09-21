// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_navigation/src/routes/transitions_type.dart';
// import 'package:kiwkemart/data/controller/promotionDeals_controller/promotion_deals_controller.dart';
// import 'package:kiwkemart/data/model/itemModel/items_model.dart';
// import 'package:kiwkemart/ui/cart/cart.dart';
// import 'package:kiwkemart/ui/product_description/product_description.dart';
// import 'package:kiwkemart/ui/search_screen/search_screen.dart';
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/values/my_imgs.dart';
// import 'package:kiwkemart/ui/widgets/custom_button.dart';
// import 'package:kiwkemart/ui/widgets/item_card_category_product.dart';
//
// class PromotionDeals extends StatefulWidget {
//   @override
//   State<PromotionDeals> createState() => _PromotionDealsState();
// }
//
// class _PromotionDealsState extends State<PromotionDeals> {
//   PromotionDealController promotionDealController =
//       Get.put(PromotionDealController());
//
//   int id = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     var textTheme = theme.textTheme;
//     var mediaQuery = MediaQuery.of(context).size;
//     return SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             title: Padding(
//               padding: const EdgeInsets.only(left: Dimens.size15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: Dimens.size10,
//                   ),
//                   SizedBox(
//                     child: Text(
//                       'Promotions and Deals',
//                       style:
//                           Get.textTheme.headline5!.copyWith(color: MyColors.white),
//                     ),
//                   ),
//                   Container(
//                     width: 80,
//                     //    color: Colors.amberAccent,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         GestureDetector(
//                             onTap: () {
//                               Get.to(
//                                 Cart(),
//                                 transition: Transition.leftToRightWithFade,
//                                 duration: const Duration(milliseconds: 700),
//                               );
//                             },
//                             child: Image.asset(
//                               MyImgs.basket,
//                               width: Dimens.size25,
//                               height: Dimens.size25,
//                               color: MyColors.white,
//                             )),
//                       ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//           body: GetBuilder<PromotionDealController>(
//             builder: (value) => Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomScrollView(
//                 controller: value.modalController,
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: Container(
//                       height: mediaQuery.height * 0.05,
//                       child: ListView.separated(
//                         itemCount: 8,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                             onTap: () {
//
//                               id = index;
//                               value.update();
//                             },
//                             child: Container(
//                               width: 80,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(22),
//                                   color: id == index
//                                       ? MyColors.blue10
//                                       : MyColors.white,
//                                   border: Border.all(
//                                     color: MyColors.black,
//                                   )),
//                               child: Center(
//                                   child: Text(
//                                     "Apple",
//                                     style: TextStyle(
//                                         color: id == index
//                                             ? MyColors.white
//                                             : MyColors.black,
//                                         fontSize: 12),
//                                   )),
//                             ),
//                           );
//                         },
//                         separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10,),
//                       ),
//                     ),
//                   ),
//
//                   SliverList(delegate: SliverChildListDelegate(
//                       List.generate(value.subCatModel.length, (idx) {
//                         return  Wrap(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text("${value.subCatModel[idx].title}", style: Get.textTheme.headline2,),
//                               ),
//                               GridView.builder(
//                                   controller: value.modalController,
//                                   shrinkWrap: true,
//                                   physics: BouncingScrollPhysics(),
//                                   gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
//                                       maxCrossAxisExtent: 150,
//                                       childAspectRatio: 4 / 7,
//                                       crossAxisSpacing: 5,
//                                       mainAxisSpacing: 20),
//                                   itemCount: value.subCatModel[idx].data.length,
//                                   itemBuilder: (BuildContext ctx, index) {
//                                     return  ItemCard(
//                                       id: 3,
//                                       image: value.subCatModel[idx].data[index].image,
//                                       title: value.subCatModel[idx].data[index].title,
//                                       price: value.subCatModel[idx].data[index].price,
//                                       oldPrice: value.subCatModel[idx].data[index].oldPrice,
//                                       quantity: value.subCatModel[idx].data[index].quantity,
//                                       offer: value.subCatModel[idx].data[index].offer,
//                                       offerPercentage: value.subCatModel[idx].data[index].offPercentage,
//                                       onTap: () {
//                                         Get.to(
//                                           ProductDescription(
//                                             image: value.subCatModel[idx].data[index].image,
//                                             text: value.subCatModel[idx].data[index].title,
//                                             price: value.subCatModel[idx].data[index].price,
//                                             quantity: value.subCatModel[idx].data[index].quantity,
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   }),
//                             ]
//                         );
//                       })
//                   ),),
//                   SliverToBoxAdapter(
//                     child: Container(
//                       color: MyColors.white,
//                       height: Dimens.size90,
//                       width: mediaQuery.width * 1.0,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               _bottomsheet();
//                             },
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.circular(Dimens.size6),
//                                     border: Border.all(
//                                         color: MyColors.grey.withOpacity(0.2))),
//                                 child: Text(
//                                   " Looking for something else? ",
//                                   style: textTheme.headline6,
//                                 )),
//                           ),
//                           Divider(),
//                           GestureDetector(
//                               onTap: () {
//                                 value.scrollToTop();
//                               },
//                               child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius:
//                                           BorderRadius.circular(Dimens.size6),
//                                       border: Border.all(
//                                           color: MyColors.grey.withOpacity(0.2))),
//                                   child: Text(
//                                     " Back to top ",
//                                     style: textTheme.headline6,
//                                   ))),
//                           SizedBox(
//                             height: Dimens.size10,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//     ));
//   }
//
//   void _bottomsheet() {
//     showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(Dimens.size20),
//             topRight: Radius.circular(Dimens.size20)),
//       ),
//       isScrollControlled: true,
//       context: context,
//       builder: (context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.3,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(Dimens.size20),
//                 topRight: Radius.circular(Dimens.size20)),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: Dimens.size20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text("Please tell us what are you looking for"),
//                 Container(
//                   height: Dimens.size100,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: MyColors.black, width: 2)),
//                   child: TextFormField(
//                     decoration: InputDecoration(border: InputBorder.none),
//                   ),
//                 ),
//                 CustomButton(
//                     height: 0.06,
//                     width: 0.6,
//                     text: "submit",
//                     onPressed: () {
//                       Get.back();
//                     })
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
