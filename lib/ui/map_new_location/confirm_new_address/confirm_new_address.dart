//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kiwkemart/ui/address/address_details.dart';
// import 'package:kiwkemart/ui/deliveryAddress/delivery_address.dart';
// import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';
//
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/widgets/custom_button.dart';
//
// class ConfirmNewLocation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var mediaQuery = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: MyColors.white,
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: Dimens.size15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Image.asset("assets/images/close 1.png"),
//                   SizedBox(width: Dimens.size16,),
//                   Text("Add new address",overflow: TextOverflow.ellipsis,style: TextStyle(
//                       fontSize: Dimens.size18,
//                   ),),
//                 ],
//               ),
//               SizedBox(height: Dimens.size10,),
//               Container(
//                 height: mediaQuery.height*0.06,
//                 width: mediaQuery.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(Dimens.size15),
//                   color: MyColors.grey.withOpacity(0.2),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: Dimens.size15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Abc street, abc town opposite",overflow: TextOverflow.ellipsis,style: TextStyle(
//                             fontSize: Dimens.size14,
//                           ),),
//                           SizedBox(height: Dimens.size5,),
//                           Text("Lahore",overflow: TextOverflow.ellipsis,style: TextStyle(
//                               fontSize: Dimens.size12,
//                               color: MyColors.grey
//                           ),),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Image.asset("assets/images/search_icon 1.png", height: Dimens.size30,),
//                           SizedBox(width: Dimens.size25,),
//                           Image.asset("assets/images/blue-current-location.png", height: Dimens.size30,),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: Dimens.size10,),
//               Expanded(
//                 child: Container(
//                   height: mediaQuery.height*0.5,
//                   width: mediaQuery.width,
//                   decoration: BoxDecoration(
//                     //borderRadius: BorderRadius.circular(30)
//                   ),
//                 ///confirm address screen is implemented
//                 //  child: MapScreen(),
//                 ),
//               ),
//
//               SizedBox(
//                 height: Dimens.size10,
//               ),
//               Container(
//                 height: mediaQuery.height*0.12,
//                 width: mediaQuery.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(Dimens.size20),
//                   color: MyColors.buttonColor.withOpacity(0.2),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(width: Dimens.size10,),
//                     Image.asset("assets/images/current_location_logo.png"),
//                     SizedBox(width: Dimens.size10,),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Current Location",style: TextStyle(
//                             fontSize: Dimens.size16
//                         ),),
//                         SizedBox(height: Dimens.size10,),
//                         Text("Abc street, abc town opposite",overflow: TextOverflow.ellipsis,style: TextStyle(
//                           fontSize: Dimens.size14,
//                         ),),
//                         SizedBox(height: Dimens.size10,),
//                         Text("Lahore",overflow: TextOverflow.ellipsis,style: TextStyle(
//                             fontSize: Dimens.size12,
//                             color: MyColors.grey
//                         ),),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: Dimens.size10,
//               ),
//               Center(child: CustomButton(height: 0.065, width: 0.8, text: 'Confirm',
//                 onPressed: (){Get.to(AddressDetails(),
//                 );},
//                 roundCorner: Dimens.size30,)),
//               SizedBox(height: Dimens.size10,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
