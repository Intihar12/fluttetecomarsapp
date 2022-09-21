//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kiwkemart/data/singleton/singleton.dart';
// import 'package:kiwkemart/ui/map_new_location/confirm_new_address/confirm_new_address.dart';
// import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/widgets/custom_button.dart';
//
// class AddNewLocation extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var mediaQuery = MediaQuery
//         .of(context)
//         .size;
//     var theme = Theme.of(context);
//     var textTheme = theme.textTheme;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: MyColors.white,
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: Dimens.size15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: Dimens.size20,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Image.asset("assets/images/close 1.png"),
//                   SizedBox(width: Dimens.size16,),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Abc street, abc town opposite",overflow: TextOverflow.ellipsis,style: TextStyle(
//                         fontSize: Dimens.size15,
//                         color: MyColors.darkBlue
//                       ),),
//                       Text("Lahore",overflow: TextOverflow.ellipsis,style: TextStyle(
//                           fontSize: Dimens.size12,
//                         color: MyColors.grey
//                       ),),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: Dimens.size10,),
//               Container(
//                 height: mediaQuery.height*0.6,
//                 width: mediaQuery.width,
//                 decoration: BoxDecoration(
//                   //borderRadius: BorderRadius.circular(30)
//                 ),
//                 child: MapScreen(id: SingleToneValue.instance.saveAddressId,),
//               ),
//               SizedBox(
//                 height: Dimens.size10,
//               ),
//               Container(
//                 height: mediaQuery.height*0.12,
//                 width: mediaQuery.width,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimens.size20),
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
//                           fontSize: Dimens.size16
//                         ),),
//                         SizedBox(height: Dimens.size10,),
//                         Text("Abc street, abc town opposite",overflow: TextOverflow.ellipsis,style: TextStyle(
//                             fontSize: Dimens.size14,
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
//
//               Center(child: CustomButton(height: 0.065, width: 0.8, text: 'Add a new location',
//                 onPressed: (){Get.to(ConfirmNewLocation());},roundCorner: Dimens.size30,)),
//               SizedBox(
//                 height: Dimens.size10,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
