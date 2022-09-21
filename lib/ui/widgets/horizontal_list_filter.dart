// import 'package:flutter/material.dart';
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
//
// class HorizontalFilter extends StatefulWidget {
//   const HorizontalFilter({Key? key}) : super(key: key);
//
//   @override
//   _HorizontalFilterState createState() => _HorizontalFilterState();
// }
//
// class _HorizontalFilterState extends State<HorizontalFilter> {
//
//   final ScrollController _controller = ScrollController();
//   int id=0;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       child:  ListView.builder(
//         controller: _controller,
//           scrollDirection: Axis.horizontal,
//           itemCount: 8,
//           itemBuilder: (context, index){
//             return Padding(
//               padding:  EdgeInsets.symmetric(horizontal: Dimens.size4),
//               child: InkWell(
//                 onTap: (){
//                   setState(() {
//                     id=index;
//                   });
//                 },
//                 child: Container(
//                   width: 80,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(Dimens.size22),
//                       color:  id == index ? MyColors.blue10 :MyColors.white  ,
//                       border: Border.all(
//                         color: MyColors.black,
//                       )
//                   ),
//                   child: Center(child: Text("Apple", style: TextStyle( color: id == index ? MyColors.white :MyColors.black, fontSize: Dimens.size12),)),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
