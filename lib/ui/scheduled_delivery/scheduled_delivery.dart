// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/widgets/custom_button.dart';
//
// class ScheduledDelivery extends StatefulWidget {
//   const ScheduledDelivery({Key? key}) : super(key: key);
//
//   @override
//   _ScheduledDeliveryState createState() => _ScheduledDeliveryState();
// }
//
// class _ScheduledDeliveryState extends State<ScheduledDelivery> {
//   @override
//   Widget build(BuildContext context) {
//     var theme=Theme.of(context);
//     var textTheme=theme.textTheme;
//     var mediaQuery = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: MyColors.appBackground,
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 height: mediaQuery.height*0.13,
//                 width: mediaQuery.width,
//                 decoration: BoxDecoration(
//                     color: MyColors.darkBlue
//                 ),
//                 child:   Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                           onTap: (){
//                             Get.back();
//                           },
//                           child: Icon(Icons.arrow_back,size: 35,color: MyColors.white,)),
//                       Spacer(),
//                       Text("Scheduled Delivery",style: TextStyle(fontWeight:FontWeight.bold,fontSize: Dimens.size25,color: MyColors.white),),
//                       Spacer(),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: Dimens.size15,),
//               Material(
//                 elevation: 5,
//                 child: Container(
//                 height: mediaQuery.height*0.15,
//                   width: mediaQuery.width-50,
//                   color: MyColors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Row(
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset("assets/images/Ellipse 15.png"),
//                             SizedBox(height: Dimens.size5,),
//                             Container(
//                               height: mediaQuery.height*0.05,
//                               width: 4,
//                               color: MyColors.buttonColor,
//                             ),
//                             SizedBox(height: Dimens.size5,),
//                             Image.asset("assets/images/placeholder 1.png"),
//
//                         ],),
//                         SizedBox(width: Dimens.size15,),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 20),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Pickup Location",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: Dimens.size15,fontWeight: FontWeight.bold),),
//                                   Text("Abc street, abc town oppsite",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: Dimens.size12,fontWeight: FontWeight.bold,color: MyColors.grey),),
//                                 ],
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Receiver Location",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: Dimens.size15,fontWeight: FontWeight.bold),),
//                                   Text("Abc street, abc town oppsite",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: Dimens.size12,fontWeight: FontWeight.bold,color: MyColors.grey),),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Spacer(),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 20),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text("Change",style: TextStyle(color: MyColors.darkBlue),),
//                               Text("Change",style: TextStyle(color: MyColors.darkBlue),),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: Dimens.size15,),
//               Material(
//                 elevation: 5,
//                 child: Container(
//                   height: mediaQuery.height*0.15,
//                   width: mediaQuery.width-50,
//                   color: MyColors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Delivery Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: Dimens.size18),),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             GestureDetector(
//                               onTap: (){
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return Dialog(
//                                       child: Container(
//                                         height: mediaQuery.height*0.6,
//                                         width: mediaQuery.width,
//                                       ),
//                                     );
//                                   },);
//                               },
//                               child: Container(
//                                 height: mediaQuery.height*0.055,
//                                 width: mediaQuery.width*0.3,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: MyColors.lightBlue.withOpacity(0.1)
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text("Pickup Time"),
//                                     Icon(Icons.keyboard_arrow_down)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: Dimens.size15,),
//                             GestureDetector(
//                               onTap: (){
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return Dialog(
//                                       child: Container(
//                                         height: mediaQuery.height*0.6,
//                                         width: mediaQuery.width,
//                                       ),
//                                     );
//                                   },);
//                               },
//                               child: Container(
//                                 height: mediaQuery.height*0.055,
//                                 width: mediaQuery.width*0.3,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: MyColors.lightBlue.withOpacity(0.1)
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text("Select Date"),
//                                     Icon(Icons.keyboard_arrow_down)
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: Dimens.size15,),
//               Divider(thickness: 1,color: MyColors.grey,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("07 Products"),
//                     Text("View All",style: TextStyle(color: MyColors.buttonColor),),
//                   ],
//                 ),
//               ),
//               Divider(thickness: 1,color: MyColors.grey,),
//               SizedBox(height: Dimens.size15,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Sub Total",style: TextStyle(color: MyColors.grey,fontSize: Dimens.size17),),
//                     Text("\$ 320.10",style: TextStyle(color: MyColors.grey,fontSize: Dimens.size17),),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Delivery Fee",style: TextStyle(color: MyColors.grey,fontSize: Dimens.size17),),
//                     Text("\$ 20.25",style: TextStyle(color: MyColors.grey,fontSize: Dimens.size17),),
//                   ],
//                 ),
//               ),
//               SizedBox(height: Dimens.size30,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Image.asset("assets/images/voucher 1.png"),
//                     SizedBox(width: Dimens.size15,),
//                     Text("Got a voucher?"),
//
//                   ],
//                 ),
//               ),
//               SizedBox(height: Dimens.size10,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: mediaQuery.height*0.06,
//                       width: mediaQuery.width*0.55,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: MyColors.darkBlue,width: 1),
//                           borderRadius: BorderRadius.circular(10),
//                           color: MyColors.lightBlue.withOpacity(0.1)
//                       ),
//                       child: TextFormField(
//                         enableInteractiveSelection: false,
//                         style: TextStyle(
//                           fontSize: Dimens.size20
//                         ),
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(10),
//                           border: InputBorder.none,
//                           hintStyle: TextStyle(
//                             fontSize: Dimens.size20,
//                             color: MyColors.grey,
//                           ),
//                           hintText: 'Enter voucher code'
//                         ),
//                       )
//                     ),
//                     SizedBox(width: Dimens.size15,),
//                     GestureDetector(
//                       onTap: (){
//
//                       },
//                       child: Container(
//                         height: mediaQuery.height*0.06,
//                         width: mediaQuery.width*0.2,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: MyColors.lightBlue.withOpacity(0.1)
//                         ),
//                         child:  Center(child: Text("Apply")),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: Dimens.size15,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Total",style: TextStyle(color: MyColors.grey,fontSize: Dimens.size17),),
//                     Text("\$320.10",style: TextStyle(fontSize: Dimens.size25,fontWeight: FontWeight.bold),),
//                   ],
//                 ),
//               ),
//               SizedBox(height: Dimens.size20,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 50),
//                 child: CustomButton(height: mediaQuery.height*0.00008, width: mediaQuery.width, text: 'Confirm', onPressed: (){},roundCorner: 40,fontSize: Dimens.size25,color: MyColors.darkBlue,),
//               ),
//               SizedBox(height: Dimens.size10,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
