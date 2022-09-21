// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/values/my_imgs.dart';
// import 'package:kiwkemart/ui/widgets/custom_button.dart';
//
// class EnterNewAddress extends StatelessWidget {
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
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: Dimens.size20,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: (){
//                       Get.back();
//                     },
//                       child: Image.asset("assets/images/close 1.png")),
//                   SizedBox(width: Dimens.size16,),
//                   Text("Add new address",overflow: TextOverflow.ellipsis,style: TextStyle(
//                     fontSize: Dimens.size18,
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
//                      SizedBox(
//                        width: mediaQuery.width*0.6,
//                        child: TextFormField(
//                          style: TextStyle(
//                            fontSize: Dimens.size18
//                          ),
//                          enableInteractiveSelection: false,
//                          decoration: InputDecoration(
//
//                            contentPadding: EdgeInsets.all(Dimens.size10),
//                            border: InputBorder.none,
//                            hintText: 'Enter your address',
//                            hintStyle: TextStyle(
//                              fontSize: Dimens.size18,
//                              color: MyColors.grey,
//                            )
//                          ),
//                        ),
//                      ),
//                       Row(
//                         children: [
//                           Image.asset(MyImgs.mapSearchBlue,height: Dimens.size25,width: Dimens.size25,),
//                           SizedBox(width: Dimens.size25,),
//                           Image.asset(MyImgs.mapCurrentBlue,height: Dimens.size25,width: Dimens.size25,),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: Dimens.size10,),
//               Expanded(
//                 child: Container(
//                   height: mediaQuery.height*0.6,
//                   width: mediaQuery.width,
//                   decoration: BoxDecoration(
//                     //borderRadius: BorderRadius.circular(30)
//                   ),
//                /// new address screen  is implemented
//
//                //   child: MapScreen(),
//                 ),
//               ),
//
//               SizedBox(
//                 height: Dimens.size10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal:  Dimens.size25),
//                 child: Center(child: CustomButton(height: mediaQuery.height*0.0001, width:mediaQuery.width*0.4, text: 'Confirm', onPressed: (){},roundCorner: Dimens.size40,fontSize: Dimens.size25 ,)),
//               ),
//               SizedBox(height: Dimens.size10,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
