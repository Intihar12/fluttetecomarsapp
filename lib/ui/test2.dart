// import 'package:flutter/material.dart';
// import 'package:kiwkemart/data/model/itemModel/items_model.dart';
// import 'package:kiwkemart/ui/promotion_deals/dealFilter.dart';
// import 'package:kiwkemart/ui/values/my_imgs.dart';
//
// import 'package:kiwkemart/ui/widgets/item_card_category_product.dart';
//
// import 'deign.dart';
//
//
// class Test2 extends StatefulWidget {
//   const Test2({Key? key}) : super(key: key);
//
//   @override
//   _Test2State createState() => _Test2State();
// }
//
// class _Test2State extends State<Test2> {
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
//   String  message='';
//   double topPosition=56.0;
//   // Height of your Container
//   bool visibilityOf=false;
//
//   double size=0;
//
//   final ScrollController _scrollController = ScrollController();
//   ScrollController modalController=ScrollController();
//   int id=0;
//   @ override
//   void initState() {
//
//     _scrollController.addListener(_scrollListener);
//     super.initState();
//   }
//   _scrollListener() {
//
//     if(_scrollController.offset>topPosition){
//       if(topPosition<0)
//       {
//         if (  _scrollController.offset >=   _scrollController.position.maxScrollExtent &&
//             !  _scrollController.position.outOfRange) {
//           setState(() {
//             message = "reach the bottom";
//             visibilityOf=true;
//             print('message:$message');
//           });
//         }
//       }
//
//     }
//
//     if (  _scrollController.offset <=   _scrollController.position.minScrollExtent &&
//         !  _scrollController.position.outOfRange) {
//       setState(() {
//         visibilityOf=false;
//         message = "reach the top";
//         print('message:$message');
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (scrollNotification) {
//           setState(() {
//             if (scrollNotification.metrics.pixels > 100) {
//               print(scrollNotification.metrics.pixels);
//               visibilityOf=true;
//
//             }
//
//             else if(scrollNotification.metrics.pixels<=100){
//               print(scrollNotification.metrics.pixels);
//               visibilityOf=false;
//
//
//
//             }
//
//
//           });
//           return true;
//         },
//
//         child: CustomScrollView(
//           slivers: [
//
//             SliverPersistentHeader(
//
//               delegate: MySliverAppBar(
//                 expandedHeight:100 , visibility: visibilityOf,
//
//               ),
//               pinned: true,
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//
//                     (context, index) => ListTile(title: _mainListBuilder(context, index),
//
//                 ),
//
//                 childCount: 1,
//
//               ),
//             )
//
//
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _mainListBuilder(BuildContext context, int index) {
//     return _buildMainWidget(context);
//   }
//
//
//   Widget _buildMainWidget(BuildContext context)
//   {
//     return SafeArea(
//       child: Container(
//         //  height: maxHeight,
//        //   color: Colors.amberAccent,
//           child:GridView.count(
//             controller: modalController,
//             childAspectRatio: 1/1.75,
//             shrinkWrap: true,
//             crossAxisSpacing: 14,
//             mainAxisSpacing: 12,
//             crossAxisCount: 3 ,
//             children: List.generate(itemData.length, (index) {
//               return ItemCard(
//                 id: 5,
//                 image: itemData[index].image,
//                   title: itemData[index].title,
//                   price: itemData[index].price,
//                   oldPrice: itemData[index].oldPrice,
//                   quantity: itemData[index].quantity,
//                   offer: itemData[index].offer, onTap: () {  }, offerPercentage: 10,);
//             }),
//           )
//       ),
//     );
//   }
//
// }


