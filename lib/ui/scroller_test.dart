// import 'package:flutter/material.dart';
//
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyHomePage> {
//
//   double size=0;
//   @override
//   void initState() {
//     super.initState();
//
//     setState(() {
//       size = 100;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold (
//         body: NotificationListener<ScrollNotification>(
//             onNotification: (scrollNotification) {
//               setState(() {
//                 if (scrollNotification.metrics.pixels > 450) {
//                   print(scrollNotification.metrics.pixels);
//                   size = 600;
//                 }
//
//                 else if(scrollNotification.metrics.pixels<=450){
//                   size=100;
//                 }
//
//
//               });
//               return true;
//             },
//             child:SingleChildScrollView(
//
//               child: Column(
//                 children: [
//                   Container(
//                     height: 600,
//                     color: Colors.redAccent,
//                   ),
//                   Container(
//                     color: Colors.black38,
//                     width: size,
//                     height: size,
//                   ),
//                   Container(
//                     height: 600,
//                     color: Colors.blueAccent,
//                   ),
//                   Container(
//                     height: 600,
//                     color: Colors.yellowAccent,
//                   ),
//                 ],
//               ),
//             )
//         )
//     );
//   }
// }