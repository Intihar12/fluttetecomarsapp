// import 'package:flutter/material.dart';
// import 'package:kiwkemart/ui/promotion_deals/dealFilter.dart';
// import 'package:kiwkemart/ui/values/dimens.dart';
// import 'package:kiwkemart/ui/widgets/horizontal_list_filter.dart';
// class MySliverAppBar extends SliverPersistentHeaderDelegate {
//   final double expandedHeight;
//   bool visibility=false;
//
//   MySliverAppBar({required this.expandedHeight,
//     required this.visibility
//   });
//
//
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Stack(
//       fit: StackFit.expand,
//    //   overflow: Overflow.visible,
//       children: [
//
//
//
//        visibility==false? Visibility(visible: true,
//   child:   Container(
//    // color: Colors.amberAccent,
//     child: DealFilter(),
//     height: 100,
//
//   ),
// )
//      :  Visibility(
//          visible: visibility,
//         child: _buildScrollerView(context))
//
//       ],
//     );
//   }
//   Widget _buildScrollerView(BuildContext context)
//   {
//     return Container(
//       height: 100,
//      // color: Colors.cyanAccent,
//       child: Column(
//         children: [
//           HorizontalFilter(),
//         ],
//       ),
//
//     );
//   }
//   @override
//   double get maxExtent => expandedHeight;
//
//   @override
//   double get minExtent => 100;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }