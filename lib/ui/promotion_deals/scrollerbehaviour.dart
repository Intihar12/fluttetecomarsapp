// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
//
// import 'dealFilter.dart';
//
// class ScrollerBehaviour extends StatefulWidget {
//   const ScrollerBehaviour({Key? key}) : super(key: key);
//
//   @override
//   _ScrollerBehaviourState createState() => _ScrollerBehaviourState();
// }
//
// class _ScrollerBehaviourState extends State<ScrollerBehaviour> {
//   String  message='';
// double topPosition=56.0;
//   // Height of your Container
// bool visibilityOf=false;
//   static final _containerHeight = 65.0;
//   double size=0;
//   var _fromTop = -_containerHeight;
//   final ScrollController _scrollController = ScrollController();
//
// int id=0;
// @ override
// void initState() {
//
//   _scrollController.addListener(_scrollListener);
//   super.initState();
// }
// _scrollListener() {
//
//   if(_scrollController.offset>topPosition){
//     if(topPosition<0)
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
//   }
//
//   if (  _scrollController.offset <=   _scrollController.position.minScrollExtent &&
//       !  _scrollController.position.outOfRange) {
//     setState(() {
// visibilityOf=false;
//       message = "reach the top";
//       print('message:$message');
//     });
//   }
// }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//       ),
//       body: NotificationListener<ScrollNotification>(
//           onNotification: (scrollNotification) {
//             setState(() {
//               if (scrollNotification.metrics.pixels > 200) {
//                 print(scrollNotification.metrics.pixels);
//                 visibilityOf=true;
//
//               }
//
//               else if(scrollNotification.metrics.pixels<=200){
//                 print(scrollNotification.metrics.pixels);
//                 visibilityOf=false;
//
//
//               }
//
//
//             });
//             return true;
//           },
//         child: Stack (
//           children: [
//               Visibility(
//                   visible: visibilityOf,
//                   child:Opacity(
//                     opacity: 1 - (-_fromTop / _containerHeight),
//                     child: Container(
//                       height: 100,
//                       color: Colors.grey,
//
//                     ),
//                   )
//               ),
//              ListView.builder(
//
//               controller: _scrollController,
//                 itemCount: 2,
//                 itemBuilder: _mainListBuilder,
//               ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   Widget _mainListBuilder(BuildContext context, int index) {
//
//     if (index == 0) return _buildScrollerView(context);
//     return _buildMainWidget(context);
//   }
//   Widget _buildScrollerView(BuildContext context)
//   {
//     return Container(
//       height: 200,
//       color: Colors.cyanAccent,
//       child: Column(
//         children: [
//           SizedBox(height: 50,),
//           Container(
//             height: 30,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   height: 30,
//                   width: 30,
//                   color: Colors.amberAccent,
//                 ),
//                 Container(
//                   height: 30,
//                   width: 30,
//                   color: Colors.grey,
//                 ),
//                 Container(
//                   height: 30,
//                   width: 30,
//                   color: Colors.blue,
//                 )
//               ],
//             ),
//           ),
//           SizedBox(height: 10,),
//           Container(
//             height: 30,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   height: 30,
//                   width: 30,
//                   color: Colors.amberAccent,
//                 ),
//                 Container(
//                   height: 30,
//                   width: 30,
//                   color: Colors.grey,
//                 ),
//                 Container(
//                   height: 30,
//                   width: 30,
//                   color: Colors.blue,
//                 )
//               ],
//             ),
//           ),
//           SizedBox(height: 10,),
//           Container(
//             height: 30,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   height: 30,
//                   width: 30,
//                   color: Colors.amberAccent,
//                 ),
//                 Container(
//                   height: 30,
//                   width: 30,
//                   color: Colors.grey,
//                 ),
//                 Container(
//                   height: 30,
//                   width: 30,
//                   color: Colors.blue,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//
//     );
//   }
//
//   Widget _buildMainWidget(BuildContext context)
//   {
//     return SafeArea(
//       child: Container(
//            //  height: maxHeight,
//         color: Colors.amberAccent,
//         child:DealFilter()
//       ),
//     );
//   }
//
//
//
//   Widget _yourContainer() {
//     return Opacity(
//       opacity: 1 - (-_fromTop / _containerHeight),
//       child: Container(
//         height: _containerHeight,
//         color: Colors.red,
//         alignment: Alignment.center,
//         child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 8,
//             itemBuilder: (context, index){
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4),
//                 child: InkWell(
//                   onTap: (){
//                     setState(() {
//                       id=index;
//                     });
//                   },
//                   child: Container(
//                     width: 80,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(22),
//                         color:  id == index ? MyColors.blue10 :MyColors.white  ,
//                         border: Border.all(
//                           color: MyColors.black,
//                         )
//                     ),
//                     child: Center(child: Text("Apple", style: TextStyle( color: id == index ? MyColors.white :MyColors.black, fontSize: 12),)),
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
