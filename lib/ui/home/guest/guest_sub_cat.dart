// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:kiwkemart/data/model/itemModel/items_model.dart';
// import 'package:kiwkemart/ui/auth/login/login.dart';
// import 'package:kiwkemart/ui/product_description/product_description.dart';
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/values/my_imgs.dart';
// import 'package:kiwkemart/ui/widgets/item_card_category_product.dart';
//
// class GuestSubCategories extends StatefulWidget {
//   const GuestSubCategories({Key? key}) : super(key: key);
//
//   @override
//   _GuestSubCategoriesState createState() => _GuestSubCategoriesState();
// }
//
// class _GuestSubCategoriesState extends State<GuestSubCategories> {
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
//   int id=0;
//   bool fav=false;
//   @override
//   Widget build(BuildContext context) {
//     var theme=Theme.of(context);
//     var textTheme=theme.textTheme;
//     var mediaQuery = MediaQuery.of(context).size;
//     return SafeArea(
//         child: Scaffold(
//           backgroundColor: MyColors.appBackground,
//           appBar: AppBar(
//             centerTitle: true,
//             leading: BackButton(
//                 color: Colors.white
//             ),
//             elevation: 0,
//             backgroundColor: theme.primaryColor,
//             title: Padding(
//               padding: const EdgeInsets.only(left: Dimens.size15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: Dimens.size10,
//                   ),
//                   Text('Fruits',style: TextStyle(fontSize: Dimens.size20,color: MyColors.white,fontWeight: FontWeight.bold),),
//
//                   Container(
//                     width: Dimens.size80,
//                     //   color: Colors.amberAccent,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//
//                       children: [
//                         Image.asset(MyImgs.searchWhite,width: Dimens.size30,height: Dimens.size30,color: MyColors.white,),
//                         SizedBox(width: Dimens.size10,),
//                         Image.asset(MyImgs.basket,width: Dimens.size30,height: Dimens.size30,color: MyColors.white,),
//                       ],
//                     ),
//                   )
//
//                 ],
//               ),
//             ),
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: Dimens.size15,),
//                 Container(
//                     height: mediaQuery.height*0.04,
//                     // width: mediaQuery.width*1.0,
//                     // color: MyColors.grey100,
//                     child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: 8,
//                         itemBuilder: (context, index){
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: Dimens.size4),
//                             child: InkWell(
//                               onTap: (){
//                                 setState(() {
//                                   id=index;
//                                 });
//                               },
//                               child: Container(
//                                 width: Dimens.size80,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(Dimens.size22),
//                                     color:  id == index ? MyColors.blue10 :MyColors.white  ,
//                                     border: Border.all(
//                                       color: MyColors.black,
//                                     )
//                                 ),
//                                 child: Center(child: Text("Apple", style: TextStyle( color: id == index ? MyColors.white :MyColors.black, fontSize: Dimens.size12),)),
//                               ),
//                             ),
//                           );
//                         })
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: Dimens.size20),
//                   child: Text("Citruses", style: textTheme.headline2,),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: Dimens.size5),
//                   child: Container(
//                     height: mediaQuery.height*0.25,
//                     width: mediaQuery.width,
//                     child: ListView.separated(
//                       physics: AlwaysScrollableScrollPhysics(),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: itemData.length,
//                       separatorBuilder:(context, index) => SizedBox(width: 0,) ,
//                       itemBuilder: (context, index) {
//                         return ItemCard(
//                           id: 1,
//                           image: itemData[index].image, title: itemData[index].title,
//                           price: itemData[index].price,
//                           oldPrice: itemData[index].oldPrice,
//                           quantity: itemData[index].quantity,
//                           offer: false,
//                           onTap: (){
//                             Get.defaultDialog(title: "Login Please", middleText: "Please Login into your\naccount or create the account",
//                                 onConfirm: (){
//                                   Get.to(Login());
//                                 },
//                                 onCancel: (){}
//                             );
//                           }, offerPercentage: 10,);
//                       },
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: Dimens.size20),
//                   child: Text("Citruses", style: textTheme.headline2,),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: Dimens.size5),
//                   child: Container(
//                     height: mediaQuery.height*0.273,
//                     width: mediaQuery.width,
//                     child: ListView.separated(
//                       physics: AlwaysScrollableScrollPhysics(),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: itemData.length,
//                       separatorBuilder:(context, index) => SizedBox(width: 0,) ,
//                       itemBuilder: (context, index) {
//                         return ItemCard(image: itemData[index].image, title: itemData[index].title,
//                           price: itemData[index].price,
//                           oldPrice: itemData[index].oldPrice,
//                           quantity: itemData[index].quantity,
//                           offer: false,
//                           offerPercentage: itemData[index].offPercentage,
//                           onTap: (){Get.to(ProductDescription(
//
//                             image: itemData[index].image,
//                             text: itemData[index].title,
//                             price: itemData[index].price,
//                             quantity: itemData[index].quantity,
//                           ),);},);
//                       },
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: Dimens.size20),
//                   child: Text("Citruses", style: textTheme.headline2,),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: Dimens.size5),
//                   child: Container(
//                     height: mediaQuery.height*0.273,
//                     width: mediaQuery.width,
//                     child: ListView.separated(
//                       physics: AlwaysScrollableScrollPhysics(),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: itemData.length,
//                       separatorBuilder:(context, index) => SizedBox(width: 0,) ,
//                       itemBuilder: (context, index) {
//                         return ItemCard(image: itemData[index].image, title: itemData[index].title,
//                           price: itemData[index].price,
//                           oldPrice: itemData[index].oldPrice,
//                           quantity: itemData[index].quantity,
//                           offer: false,
//                           offerPercentage: itemData[index].offPercentage,
//                           onTap: (){Get.to(
//                             ProductDescription(
//                             image: itemData[index].image,
//                             text: itemData[index].title,
//                             price: itemData[index].price,
//                               quantity: itemData[index].quantity,
//                           ),
//                           );},);
//                       },
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ));
//   }
// }
