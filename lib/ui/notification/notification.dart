// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/values/my_imgs.dart';
// import 'package:kiwkemart/ui/widgets/custom_button.dart';
//
//
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         body: Container(
//       child: Column(
//         children: [
//           SizedBox(height: Dimens.size200,),
//           Center(
//             child: SizedBox(
//               height: 100,
//               width: 100,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Image(image: AssetImage(MyImgs.iconNotification),),
//               ),
//             ),
//           ),
//           SizedBox(height: Dimens.size50,),
//           Text('Allow notification to get updates\nabout new categories, special offers\nand more!',
//             style: Get.textTheme.headline1!.copyWith(
//                 color: MyColors.textHeadLine,
//               fontWeight: FontWeight.normal
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height:Dimens.size50 ,),
//           Center(
//             child: CustomButton(text: 'Allow Notification', width: 0.7, height: 0.06,
//               roundCorner: Dimens.size30,
//               onPressed: () {
//
//               },
//
//             ),
//           ),
//           SizedBox(height:Dimens.size40 ,),
//           Text('No, Thanks',
//             style: Get.textTheme.headline1!.copyWith(
//                 color: Get.theme.colorScheme.primary,
//
//             ),
//           )
//         ],
//       ),
//
//     )
//     );
//   }
// }
