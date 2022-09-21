// import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:kiwkemart/data/model/itemModel/items_model.dart';
// import 'package:kiwkemart/ui/product_description/product_description.dart';
// import 'package:kiwkemart/ui/promotion_deals/dealFilter.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/values/my_imgs.dart';
// import 'package:kiwkemart/ui/widgets/item_card_category_product.dart';
//
// class NewPromotionDeals extends StatefulWidget {
//   const NewPromotionDeals({Key? key}) : super(key: key);
//
//   @override
//   _NewPromotionDealsState createState() => _NewPromotionDealsState();
// }
//
// class _NewPromotionDealsState extends State<NewPromotionDeals> {
//
//
//   ////////
//   static final _containerHeight = 200.0;
//
//   // You don't need to change any of these variables
//   var _fromTop = -_containerHeight;
//   var _controller = ScrollController();
//   var _allowReverse = true, _allowForward = true;
//   var _prevOffset = 0.0;
//   var _prevForwardOffset = -_containerHeight;
//   var _prevReverseOffset = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(_listener);
//   }
//
//   // entire logic is inside this listener for ListView
//   void _listener() {
//     double offset = _controller.offset;
//     var direction = _controller.position.userScrollDirection;
//
//     if (direction == ScrollDirection.reverse) {
//       _allowForward = true;
//       if (_allowReverse) {
//         _allowReverse = false;
//         _prevOffset = offset;
//         _prevForwardOffset = _fromTop;
//       }
//
//       var difference = offset - _prevOffset;
//       _fromTop = _prevForwardOffset + difference;
//       if (_fromTop > 0) _fromTop = 0;
//     } else if (direction == ScrollDirection.forward) {
//       _allowReverse = true;
//       if (_allowForward) {
//         _allowForward = false;
//         _prevOffset = offset;
//         _prevReverseOffset = _fromTop;
//       }
//
//       var difference = offset - _prevOffset;
//       _fromTop = _prevReverseOffset + difference;
//       if (_fromTop < -_containerHeight) _fromTop = -_containerHeight;
//     }
//     setState(() {}); // for simplicity I'm calling setState here, you can put bool values to only call setState when there is a genuine change in _fromTop
//   }
//
//   //////////////
//
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
//   List<ItemModel> search =[];
//
//
//   int id=0;
//
//   @override
//   Widget build(BuildContext context) {
//     var theme=Theme.of(context);
//     var textTheme=theme.textTheme;
//     var mediaQuery = MediaQuery.of(context).size;
//     return SafeArea(child: Scaffold(
//       appBar: AppBar(
//         leading: BackButton(
//             color: Colors.black
//         ),
//         elevation: 0,
//         backgroundColor: theme.colorScheme.background,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: 10,
//               ),
//               SizedBox(
//
//                 child: Text('Test',
//                   style: Get.textTheme.headline5!.copyWith(
//                       color: Get.theme.colorScheme.secondary
//                   ),
//                 ),
//               ),
//
//               Container(
//                 width: 80,
//                 //   color: Colors.amberAccent,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//
//                   children: [
//                     Icon(Icons.search,
//                       color: Get.theme.colorScheme.secondary,
//                     ),
//                     SizedBox(width: 10,),
//                     Icon(Icons.shopping_basket,
//                       color: Get.theme.colorScheme.secondary,
//                     )
//                   ],
//                 ),
//               )
//
//             ],
//           ),
//         ),
//       ),
//       body: CustomScrollView(
//         controller: _controller,
//         slivers: <Widget>[
//            SliverAppBar(
//              backgroundColor: MyColors.white,
//             pinned: true,
//             floating: true,
//             expandedHeight:_containerHeight,
//             flexibleSpace: FlexibleSpaceBar(
//               title: FadedScaleAnimation(
//                 Opacity(
//                   opacity: 1 - (-_fromTop / _containerHeight),
//                   child: Container(
//                       height: 30,
//                       // width: mediaQuery.width*1.0,
//                       // color: MyColors.grey100,
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: 8,
//                           itemBuilder: (context, index){
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 4),
//                               child: InkWell(
//                                 onTap: (){
//                                   setState(() {
//                                     id=index;
//                                   });
//                                 },
//                                 child: Container(
//                                   //height: _containerHeight,
//                                   width: 80,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(22),
//                                       color:  id == index ? MyColors.blue10 :MyColors.white  ,
//                                       border: Border.all(
//                                         color: MyColors.black,
//                                       )
//                                   ),
//                                   child: Center(child: Text("Apple", style: TextStyle( color: id == index ? MyColors.white :MyColors.black, fontSize: 12),)),
//                                 ),
//                               ),
//                             );
//                           })
//                   ),
//                 ),
//               ),
//               background: FadedScaleAnimation(
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: DealFilter(),
//                   ),
//               ),
//             ),
//
//       ),
//           SliverGrid(
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 200.0,
//               mainAxisSpacing: 10.0,
//               crossAxisSpacing: 10.0,
//               childAspectRatio: 2/2.2,
//
//             ),
//             delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                 return ItemCard(
//                   id: 4,
//                   image: itemData[index].image,
//                     title: itemData[index].title,
//                     price: itemData[index].price,
//                     oldPrice: itemData[index].oldPrice,
//                     quantity: itemData[index].quantity,
//                     offer: itemData[index].offer,
//                   onTap: (){
//                   Get.to(ProductDescription(
//                     image: itemData[index].image,
//                     text: itemData[index].title,
//                     price: itemData[index].price,
//                     quantity: itemData[index].quantity,
//                   ),
//                   );}, offerPercentage: 10,);
//               },
//               childCount: itemData.length,
//             ),
//           ),
//
//         ],
//       ),
//     ));
//   }
//   }
//
//
//
//
