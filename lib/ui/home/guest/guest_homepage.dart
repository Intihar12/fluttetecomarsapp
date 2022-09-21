import 'dart:async';
import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/homepage_controller/homepage_controller.dart';

import 'package:kiwkemart/data/model/home_page_model/home_page_model.dart';
import 'package:kiwkemart/ui/cart/cart.dart';
import 'package:kiwkemart/ui/home/components/drawer.dart';
import 'package:kiwkemart/ui/home/components/home_slider.dart';
import 'package:kiwkemart/ui/home/components/slider.dart';
import 'package:kiwkemart/ui/product_description/product_description.dart';
import 'package:kiwkemart/ui/promotion_deals/promotion_deals.dart';
import 'package:kiwkemart/ui/search_screen/search_screen.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/item_card_homepage.dart';
import 'package:kiwkemart/ui/widgets/item_card_category_product.dart';

import '../../subcategories/scroller_tabbar.dart';

class GestUserScreen extends StatefulWidget {
  const GestUserScreen({Key? key}) : super(key: key);

  @override
  State<GestUserScreen> createState() => _GestUserScreenState();
}

class _GestUserScreenState extends State<GestUserScreen> {
   // HomeController homeController = Get.put(HomeController());

//  var item = [1,2,3, 4, 5,6,7,8,9];

  // void showDialog() {
  //   showGeneralDialog(
  //     barrierLabel: "Barrier",
  //     barrierDismissible: true,
  //     barrierColor: Colors.black.withOpacity(0.5),
  //     transitionDuration: Duration(milliseconds: 700),
  //     context: context,
  //     pageBuilder: (_, __, ___) {
  //       return Align(
  //         alignment: Alignment.center,
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * 0.7,
  //           width: 300,
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //                 image: AssetImage(MyImgs.popup), fit: BoxFit.cover),
  //             color: MyColors.white,
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.only(right: 8, bottom: 8),
  //                 child: Align(
  //                     alignment: Alignment.topRight,
  //                     child: GestureDetector(
  //                         onTap: () {
  //                           Get.back();
  //                         },
  //                         child: Icon(
  //                           Icons.clear,
  //                           size: 30,
  //                         ))),
  //               ),
  //               Text(
  //                 "Welcome to kwik e mart fans",
  //                 style: Get.textTheme.headline5,
  //               ),
  //               Text(
  //                 "New customers get 40% off with code:\n"
  //                     "KWIK40 * First order only. Minimum spend \$10,\n"
  //                     "maximum discount \$50.",
  //                 textAlign: TextAlign.center,
  //                 style: Get.textTheme.caption,
  //               ),
  //               SizedBox(
  //                 height: MediaQuery.of(context).size.height * 0.35,
  //               ),
  //               CustomButton(
  //                   height: 0.03,
  //                   width: 0.2,
  //                   text: "Order now",
  //                   onPressed: () {}),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //     transitionBuilder: (_, anim, __, child) {
  //       return SlideTransition(
  //         position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  void initState() {
    super.initState();
 // Future.delayed(Duration.zero, () => _box()(context));
 //   WidgetsBinding.instance!.addPostFrameCallback((_) => showDialog());
  }

  var scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Text('x')
      // Scaffold(
      //   key: _scaffoldKey,
      // //  drawer: MyDrawer(),
      //   appBar: PreferredSize(
      //     preferredSize: Size(double.infinity, 100),
      //     child: Container(
      //       width: MediaQuery.of(context).size.width,
      //       height: 100,
      //       // color: MyColors.yellow,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 // GestureDetector(
      //                 //     onTap: () {
      //                 //       _scaffoldKey.currentState!.openDrawer();
      //                 //     },
      //                 //     child: Icon(Icons.menu)),
      //                 SizedBox(
      //                   width: 20,
      //                 ),
      //                 Expanded(
      //                     child: Image.asset(
      //                       MyImgs.blueLogo,
      //                       height: 30,
      //                       width: 30,
      //                     )),
      //                 Container(
      //                   width: 80,
      //                   //    color: Colors.amberAccent,
      //                   child: Row(
      //                     children: [
      //                       InkWell(
      //                         onTap: () {
      //                           Get.to(SearchScreen());
      //                         },
      //                         child: CircleAvatar(
      //                           radius: Dimens.size18,
      //                           backgroundColor: MyColors.grey200,
      //                           child: Icon(
      //                             Icons.search,
      //                             color: Get.theme.colorScheme.primary,
      //                           ),
      //                         ),
      //                       ),
      //                       // SizedBox(
      //                       //   width: 10,
      //                       // ),
      //                       // GestureDetector(
      //                       //     onTap: () {
      //                       //       Get.to(
      //                       //         Cart(),
      //                       //         transition: Transition.leftToRightWithFade,
      //                       //         duration: const Duration(milliseconds: 700),
      //                       //       );
      //                       //     },
      //                       //     child: Image.asset(
      //                       //       MyImgs.basket,
      //                       //       width: Dimens.size25,
      //                       //       height: Dimens.size25,
      //                       //       color: MyColors.black,
      //                       //     )),
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(
      //               top: Dimens.size10,
      //             ),
      //             child: Container(
      //               height: Dimens.size45,
      //               width: mediaQuery.width,
      //               decoration: BoxDecoration(
      //                 // border: Border.all(color: MyColors.white400),
      //                 //
      //                 // borderRadius: BorderRadius.only(
      //                 //   topLeft: Radius.circular(15),
      //                 //   topRight: Radius.circular(15),
      //                 //
      //                 // ),
      //                   color: MyColors.white200),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //
      //                   Row(
      //                     children: [
      //                       Icon(Icons.location_on),
      //                       SizedBox(
      //                         width: Dimens.size10,
      //                       ),
      //                       Container(
      //                         height: Dimens.size45,
      //                         width: mediaQuery.width * 0.55,
      //                         // color: MyColors.grey,
      //                         child: Align(
      //                           alignment: Alignment.centerLeft,
      //                           child: Text(
      //                             "D block, Johar Town, Lahore",
      //                             overflow: TextOverflow.ellipsis,
      //                             style: Get.textTheme.subtitle1!.copyWith(
      //                                 color: MyColors.black,
      //                                 fontWeight: FontWeight.normal),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   Container(
      //                     height: 45,
      //                     width: 130,
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.only(
      //
      //                         topLeft: Radius.circular(45),
      //
      //                       ),
      //                       color: MyColors.lightBlue,
      //                     ),
      //                     child: Row(
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Icon(
      //                           Icons.location_on,
      //                           color: MyColors.white,
      //                         ),
      //                         SizedBox(
      //                           width: Dimens.size10,
      //                         ),
      //                         Column(
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             Text(
      //                               "Opening Time",
      //                               style: Get.textTheme.subtitle1!
      //                                   .copyWith(color: MyColors.white),
      //                             ),
      //                             Text(
      //                               "9:00-16:00",
      //                               style: Get.textTheme.bodyText1!
      //                                   .copyWith(color: MyColors.white),
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   body: GetBuilder<HomeController>(
      //     builder: (value) => Padding(
      //       padding: const EdgeInsets.all(12.0),
      //       child: CustomScrollView(
      //         physics: BouncingScrollPhysics(),
      //         slivers: [
      //           SliverToBoxAdapter(
      //               child: SizedBox(
      //                 height: 150,
      //                 child:  FadedScaleAnimation(
      //                     HomeSlider()
      //                 ),)),
      //           SliverToBoxAdapter(
      //               child: Text(
      //                 "Featured",
      //                 style: Get.textTheme.headline2,
      //               )),
      //           SliverToBoxAdapter(
      //             child: Container(
      //               height: mediaQuery.height * 0.23,
      //               // color: MyColors.yellow,
      //               child: ListView.separated(
      //                 physics: BouncingScrollPhysics(),
      //                 itemCount: value.homeItemData.length,
      //                 scrollDirection: Axis.horizontal,
      //                 itemBuilder: (context, index) {
      //                   return ItemCardHomePage(
      //                     id: 1,
      //                     image: value.homeItemData[index].image,
      //                     title: value.homeItemData[index].title,
      //                     price: value.homeItemData[index].price,
      //                     oldPrice: value.homeItemData[index].oldPrice,
      //                     quantity: value.homeItemData[index].quantity,
      //                     offer: value.homeItemData[index].offer,
      //                     offerPercentage:
      //                     value.homeItemData[index].offPercentage,
      //                     onTap: () {
      //                       Get.to(
      //                         ProductDescription(
      //                         //  id: 1,
      //                           image: value.homeItemData[index].image,
      //                           text: value.homeItemData[index].title,
      //                           price: value.homeItemData[index].price,
      //                           quantity: value.homeItemData[index].quantity,
      //                         ),
      //                       );
      //                     },
      //                   );
      //                 },
      //                 separatorBuilder: (context, index) => SizedBox(
      //                   height: Dimens.size15,
      //                 ),
      //               ),
      //             ),
      //           ),
      //           SliverList(delegate: SliverChildListDelegate(
      //               List.generate(1, (idx) {
      //                 return  Wrap(
      //                     children: [
      //                       Container(
      //                         child: Padding(
      //                           padding: const EdgeInsets.symmetric(horizontal: 10),
      //                           child: ListView.builder(
      //                               physics: NeverScrollableScrollPhysics(),
      //                               shrinkWrap: true,
      //                               itemCount: homeController.homeCatData.length,
      //                               itemBuilder: (context, index1){
      //
      //                                 return Column(
      //                                   children: [
      //
      //                                     Text(homeController.homeCatData[index1].title),
      //                                     SizedBox(height: 5,),
      //                                     if(homeController.homeCatData[index1].data.length %3 ==0)
      //                                       Container(
      //
      //                                         child: StaggeredGridView.countBuilder(
      //                                           crossAxisCount: 3,
      //                                           itemCount: homeController.homeCatData[index1].data.length,
      //                                           physics: NeverScrollableScrollPhysics(),
      //                                           shrinkWrap: true,
      //                                           itemBuilder: (context, index) =>
      //                                               GenreTile(
      //                                                   index: index,data: homeController.homeCatData[index1].data
      //                                               ),
      //                                           staggeredTileBuilder: (index) =>
      //                                               StaggeredTile.count(
      //                                                   (3 % 3 == 0) ? 1 : 3,
      //                                                   (3 % 3 == 0) ? 1 : 3),
      //                                           mainAxisSpacing: 8.0,
      //                                           crossAxisSpacing: 8.0,
      //                                         ),
      //                                       ),
      //
      //                                     //else if( item[index]%3==2)
      //                                     if(homeController.homeCatData[index1].data.length==8)
      //                                       Container(
      //                                         child: StaggeredGridView.countBuilder(
      //                                           crossAxisCount: 3,
      //                                           physics: NeverScrollableScrollPhysics(),
      //                                           shrinkWrap: true,
      //                                           itemCount: homeController.homeCatData[index1].data.length,
      //                                           itemBuilder: (context, index) => GenreTile(
      //                                               index: index,data: homeController.homeCatData[index1].data
      //                                           ),
      //                                           staggeredTileBuilder: (index) => index==0 ||
      //                                               index==3 || index==4 || index==7  ?StaggeredTile.count(2,1):StaggeredTile.count(1,1),
      //
      //                                           mainAxisSpacing: 8.0,
      //                                           crossAxisSpacing: 8.0,
      //                                         ),
      //                                       ),
      //                                     if(homeController.homeCatData[index1].data.length==5)
      //                                       Container(
      //                                         child: StaggeredGridView.countBuilder(
      //                                           crossAxisCount: 3,
      //                                           shrinkWrap: true,
      //                                           physics: NeverScrollableScrollPhysics(),
      //                                           itemCount: homeController.homeCatData[index1].data.length,
      //                                           itemBuilder: (context, index) => GenreTile(
      //                                               index: index,data: homeController.homeCatData[index1].data
      //                                           ),
      //                                           staggeredTileBuilder: (index) => StaggeredTile.count(
      //                                               (index% 8 == 0) ?  2: 1,
      //                                               (index %  3== 0) ? 1 : 1),
      //                                           mainAxisSpacing: 8.0,
      //                                           crossAxisSpacing: 8.0,
      //                                         ),
      //                                       ),
      //                                     if(homeController.homeCatData[index1].data.length==2)
      //                                       Container(
      //                                         child: StaggeredGridView.countBuilder(
      //                                           crossAxisCount: 3,
      //                                           shrinkWrap: true,
      //                                           physics: NeverScrollableScrollPhysics(),
      //                                           itemCount:homeController.homeCatData[index1].data.length ,
      //                                           itemBuilder: (context, index) => GenreTile(
      //                                               index: index,data: homeController.homeCatData[index1].data
      //                                           ),
      //                                           staggeredTileBuilder: (index) => StaggeredTile.count(
      //                                               (index % 2 == 0) ?  2: 1,
      //                                               ( index%  2== 0) ? 1 : 1),
      //                                           mainAxisSpacing: 8.0,
      //                                           crossAxisSpacing: 8.0,
      //                                         ),
      //                                       ),//if (item[index] %3==1)
      //
      //                                     if(homeController.homeCatData[index1].data.length==7)
      //                                       Container(
      //                                         child: StaggeredGridView.countBuilder(
      //                                           crossAxisCount: 3,
      //                                           shrinkWrap: true,
      //                                           itemCount: homeController.homeCatData[index1].data.length,
      //                                           physics: NeverScrollableScrollPhysics(),
      //                                           itemBuilder: (context, index) => GenreTile(
      //                                               index: index,data: homeController.homeCatData[index1].data
      //                                           ),
      //                                           staggeredTileBuilder: (index) => index==0 ||
      //                                               index==3 ?StaggeredTile.count(2,1):StaggeredTile.count(1,1),
      //                                           mainAxisSpacing: 8.0,
      //                                           crossAxisSpacing: 8.0,
      //                                         ),
      //                                       ),
      //                                     if (homeController.homeCatData[index1].data.length==4)
      //                                       Container(
      //                                         child: StaggeredGridView.countBuilder(
      //                                           crossAxisCount: 3,
      //                                           physics: NeverScrollableScrollPhysics(),
      //                                           shrinkWrap: true,
      //                                           itemCount: homeController.homeCatData[index1].data.length,
      //                                           itemBuilder: (context, index) => GenreTile(
      //                                               index: index,data: homeController.homeCatData[index1].data
      //                                           ),
      //                                           staggeredTileBuilder: (index) => index==0 ||
      //                                               index==3 ?StaggeredTile.count(2,1):StaggeredTile.count(1,1)
      //                                           ,
      //                                           mainAxisSpacing: 8.0,
      //                                           crossAxisSpacing: 8.0,
      //                                         ),
      //                                       ),
      //                                     if(homeController.homeCatData[index1].data.length==1)
      //                                       Container(
      //
      //                                         child: StaggeredGridView.countBuilder(
      //                                           crossAxisCount: 3,
      //                                           shrinkWrap: true,
      //                                           physics: NeverScrollableScrollPhysics(),
      //                                           itemCount:homeController.homeCatData[index1].data.length ,
      //                                           itemBuilder: (context, index) => GenreTile(
      //                                               index: index,data: homeController.homeCatData[index1].data
      //                                           ),
      //                                           staggeredTileBuilder: (index) => StaggeredTile.count(
      //                                               (index % 3 == 0) ?  1: 3,
      //                                               ( index%  3== 0) ? 1 : 3),
      //                                           mainAxisSpacing: 8.0,
      //                                           crossAxisSpacing: 8.0,
      //                                         ),
      //                                       ),
      //
      //
      //                                   ],
      //                                 );
      //                               }
      //                           ),
      //                         ),
      //                       )
      //                       //  StaggeredGridView.countBuilder(
      //                       //   crossAxisCount: 4,
      //                       //   itemCount: 8,
      //                       //   itemBuilder: (BuildContext context, int index) => new Container(
      //                       //       color: Colors.green,
      //                       //       child: new Center(
      //                       //         child: new CircleAvatar(
      //                       //           backgroundColor: Colors.white,
      //                       //           child: new Text('$index'),
      //                       //         ),
      //                       //       )),
      //                       //   staggeredTileBuilder: (int index) =>
      //                       //   new StaggeredTile.count(2, index.isEven ? 2 : 1),
      //                       //   mainAxisSpacing: 4.0,
      //                       //   crossAxisSpacing: 4.0,
      //                       // ),
      //                       // GridView.builder(
      //                       //     controller: scrollController,
      //                       //     shrinkWrap: true,
      //                       //     physics: BouncingScrollPhysics(),
      //                       //     gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
      //                       //         maxCrossAxisExtent: 150,
      //                       //         childAspectRatio: 3 / 3,
      //                       //         crossAxisSpacing: 5,
      //                       //         mainAxisSpacing: 20),
      //                       //     itemCount: value.homeCatData[idx].data.length,
      //                       //     itemBuilder: (BuildContext ctx, index) {
      //                       //       return  InkWell(
      //                       //         onTap: (){
      //                       //           if(index==0){
      //                       //             Get.to(ScrollerTabBar(),
      //                       //               transition: Transition.leftToRightWithFade,
      //                       //               duration: const Duration(milliseconds: 700),
      //                       //             );
      //                       //           }
      //                       //           if(index==5){
      //                       //             Get.to(PromotionDeals(),
      //                       //               transition: Transition.leftToRightWithFade,
      //                       //               duration: const Duration(milliseconds: 700),
      //                       //             );
      //                       //           }
      //                       //           if(index==1){
      //                       //             showDialog();
      //                       //           }
      //                       //
      //                       //         },
      //                       //         child: Container(
      //                       //
      //                       //           height: mediaQuery.height*0.19,
      //                       //           width: mediaQuery.width*0.35,
      //                       //           decoration: BoxDecoration(
      //                       //             //  color: Colors.grey,
      //                       //               borderRadius: BorderRadius.circular(Dimens.size15)
      //                       //           ),
      //                       //           child: Stack(
      //                       //             children: [
      //                       //               Container(
      //                       //                 height: mediaQuery.height*0.19,
      //                       //                 width: mediaQuery.width*0.35,
      //                       //                 // color: Colors.amberAccent,
      //                       //                 child:   ClipRRect(
      //                       //                   // borderRadius:
      //                       //                   // BorderRadius.circular(8),
      //                       //                     child: Image.asset(value.homeCatData[idx].data[index].images,
      //                       //                         fit: BoxFit.cover)),
      //                       //               ),
      //                       //               Padding(
      //                       //                 padding: const EdgeInsets.only(top: 10,
      //                       //                     left: 20
      //                       //                 ),
      //                       //                 child: Text(value.homeCatData[idx].data[index].subtitle,
      //                       //
      //                       //                   style: Get.textTheme.bodyText1!.copyWith(
      //                       //                       color: Get.theme.colorScheme.onPrimary
      //                       //                   ),
      //                       //                 ),
      //                       //               ),
      //                       //             ],
      //                       //           ),
      //                       //
      //                       //         ),
      //                       //       );
      //                       //     }),
      //                     ]
      //                 );
      //               })
      //           ),),
      //
      //
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }


}


class GenreTile extends StatelessWidget {

  int index;
  List<HomePageSubModel> data;

  GenreTile({
    required this.data,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: (){
      //   Get.to(ScrollerTabBar(id: 1,));
      // },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                //  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: AssetImage(data[index].images),
                      fit: BoxFit.fill
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10,
                  left: 10),
              child: Text(
                data[index].subtitle,
                style: TextStyle(
                    color: Get.theme.colorScheme.onPrimary

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}