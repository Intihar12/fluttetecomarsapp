// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kiwkemart/data/model/itemModel/items_model.dart';
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/values/my_imgs.dart';
// import 'package:kiwkemart/ui/widgets/item_card_category_product.dart';
//
//
//
// class DealFilter extends StatefulWidget {
//   const DealFilter({Key? key}) : super(key: key);
//
//   @override
//   _DealFilterState createState() => _DealFilterState();
// }
//
// class _DealFilterState extends State<DealFilter> {
//   ScrollController modalController=ScrollController();
//
//   List<ItemModel> itemData = [
//     ItemModel(image: MyImgs.mango, title: "Mango",category: "citruses", quantity: 1/2, price: 123, oldPrice: 110, offer: true, offPercentage: 10),
//     ItemModel(image: MyImgs.banana, title: "Banana",category: "citruses", quantity: 2/4, price: 100, oldPrice: 110,offer: true, offPercentage: 10),
//     ItemModel(image: MyImgs.kiwi, title: "Kiwi",category: "citruses", quantity: 2/4, price: 90, oldPrice: 110,offer: true, offPercentage: 10,),
//     ItemModel(image: MyImgs.kiwi, title: "Kiwi",category: "citruses", quantity: 2/4, price: 105, oldPrice: 110, offer: false,offPercentage: 10),
//     ItemModel(image: MyImgs.dragon, title: "Dragon",category: "citruses", quantity: 2/4, price: 109, oldPrice: 110, offer: true,offPercentage: 10),
//     ItemModel(image: MyImgs.apple, title: "Apple",category: "citruses", quantity: 2/4, price: 25, oldPrice: 110, offer: true,offPercentage: 10),
//     ItemModel(image: MyImgs.grapes, title: "Grapes",category: "citruses", quantity:2/4, price: 30, oldPrice: 110, offer: false,offPercentage: 10),
//     ItemModel(image: MyImgs.kiwi, title: "Kiwi",category: "citruses", quantity: 2/4, price: 88, oldPrice: 110, offer: true,offPercentage: 10),
//     ItemModel(image: MyImgs.lemonImg, title: "Lemon",category: "citruses", quantity: 2/4, price: 45, oldPrice: 110, offer: false,offPercentage: 10),
//     ItemModel(image: MyImgs.oragneImg, title: "Orange",category: "citruses", quantity: 2/4, price: 95, oldPrice: 110, offer: true,offPercentage: 10),
//     ItemModel(image: MyImgs.lemonImg, title: "Lemon",category: "citruses", quantity: 2/4, price: 66, oldPrice: 110, offer: true,offPercentage: 10),
//   ];
//
//   int id=0;
//
//   List<String> carouselImages = [
//     MyImgs.banner1,
//     MyImgs.banner2,
//     MyImgs.banner3,
//     MyImgs.banner4,
//   ];
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var mediaQuery=MediaQuery.of(context).size;
//     return GridView.count(
//       physics: const BouncingScrollPhysics(),
//       controller: modalController,
//       childAspectRatio: 2,
//       shrinkWrap: true,
//       crossAxisSpacing: 14,
//       mainAxisSpacing: 8,
//       crossAxisCount: 4 ,
//       children: List.generate(100, (index) {
//         return InkWell(
//           onTap: (){
//             setState(() {
//               id=index;
//             });
//           },
//           child: Container(
//             width: 80,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(22),
//                 color:  id == index ? MyColors.blue10 :MyColors.white  ,
//                 border: Border.all(
//                   color: MyColors.black,
//                 )
//             ),
//             child: Center(child: Text("Apple", style: TextStyle( color: id == index ? MyColors.white :MyColors.black, fontSize: 12),)),
//           ),
//         ) ;
//       }),
//     );
//   }
//
// }
