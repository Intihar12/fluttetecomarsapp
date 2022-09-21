// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:kiwkemart/data/model/itemModel/items_model.dart';
// import 'package:kiwkemart/ui/values/my_colors.dart';
// import 'package:kiwkemart/ui/values/my_imgs.dart';
//
// class Test extends StatefulWidget {
//   @override
//   _TestState createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   // Height of your Container
//   static final _containerHeight = 40.0;
//
//   // You don't need to change any of these variables
//   var _fromTop = -_containerHeight;
//   var _controller = ScrollController();
//   var _allowReverse = true, _allowForward = true;
//   var _prevOffset = 0.0;
//   var _prevForwardOffset = -_containerHeight;
//   var _prevReverseOffset = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(_listener);
//   }
//
//   // entire logic is inside this listener for ListView
//   void _listener() {
//     double offset = _controller.offset;
//     var direction = _controller.position.userScrollDirection;
//
//     if (direction == ScrollDirection.reverse) {
//       _allowForward = true;
//       if (_allowReverse) {
//         _allowReverse = false;
//         _prevOffset = offset;
//         _prevForwardOffset = _fromTop;
//       }
//
//       var difference = offset - _prevOffset;
//       _fromTop = _prevForwardOffset + difference;
//       if (_fromTop > 0) _fromTop = 0;
//     } else if (direction == ScrollDirection.forward) {
//       _allowReverse = true;
//       if (_allowForward) {
//         _allowForward = false;
//         _prevOffset = offset;
//         _prevReverseOffset = _fromTop;
//       }
//
//       var difference = offset - _prevOffset;
//       _fromTop = _prevReverseOffset + difference;
//       if (_fromTop < -_containerHeight) _fromTop = -_containerHeight;
//     }
//     setState(() {}); // for simplicity I'm calling setState here, you can put bool values to only call setState when there is a genuine change in _fromTop
//   }
//
//
//
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
//
//   List<ItemModel> search =[];
//   // bool c1=true;
//   // bool offer=false;
//
//   int id=0;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     var theme=Theme.of(context);
//     var textTheme=theme.textTheme;
//     var mediaQuery = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(title: Text("ListView")),
//       body: Stack(
//         children: <Widget>[
//           Column(
//             children: [
//               Container(
//                 height: 100,
//                color: MyColors.blue10,
//               ),
//               _yourListView(),
//             ],
//           ),
//           Positioned(
//             top: _fromTop,
//             left: 0,
//             right: 0,
//             child: _yourContainer(),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _yourListView() {
//     var theme=Theme.of(context);
//     var textTheme=theme.textTheme;
//     var mediaQuery = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Container(
//         height: mediaQuery.height*0.6,
//         width: mediaQuery.width*1.0,
//         color: MyColors.white,
//         child: GridView.count(
//           controller: _controller,
//           childAspectRatio: 2,
//           shrinkWrap: true,
//           crossAxisSpacing: 14,
//           mainAxisSpacing: 12,
//           crossAxisCount: 5 ,
//           children: List.generate(1000, (index) {
//             return InkWell(
//               onTap: (){
//                 setState(() {
//                   id=index;
//                 });
//               },
//               child: Container(
//                 width: 80,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(22),
//                     color:  id == index ? MyColors.blue10 :MyColors.white  ,
//                     border: Border.all(
//                       color: MyColors.black,
//                     )
//                 ),
//                 child: Center(child: Text("Apple", style: TextStyle( color: id == index ? MyColors.white :MyColors.black, fontSize: 12),)),
//               ),
//             ) ;
//           }),
//         ),
//       ),
//     );
//   }
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