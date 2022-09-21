import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';



class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {


  var _current = 0;
  late PageController _pageController;
  double viewportFraction = 1.0;
  double pageOffset = 0;
  List<String> carouselImages = [
    MyImgs.banner1,
    MyImgs.banner2,
    MyImgs.banner3,
    MyImgs.banner4,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        keepPage: false,
        initialPage: _current,
        viewportFraction: viewportFraction)
      ..addListener(() {
        setState(() {
          pageOffset = _pageController.page!;
        });
      });
    Timer.periodic(
      Duration(seconds: 5),
          (Timer timer) {
        _current < carouselImages.length - 1 ? _current++ : _current = 0;

        if (_pageController.hasClients)
          _pageController.animateToPage(
            _current,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    return Column(
      children: [

        Visibility(
          // visible: SingleToneValue.instance.orderPlaced as bool,
          visible: false,
          child: Padding(
            padding: const EdgeInsets.only(left: Dimens.size15,
                top: Dimens.size15,
                right: Dimens.size15
            ),
            child: Container(
              height: Dimens.size30,
              width:mediaQuery.width ,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.white400),

                  borderRadius: BorderRadius.only(
                   // topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),

                  ),
                //  color: MyColors.white200,
                color: MyColors.lightBlue,
              ),
              child: Row(
                children: [
                  Container(
                    height: Dimens.size50,
                    width:mediaQuery.width*0.7 ,
                    decoration: BoxDecoration(
                          boxShadow: [
                          BoxShadow(
                          color: Color(0xffA22447).withOpacity(.05),
                          offset: Offset(0, 0),
                          blurRadius: 20,
                          spreadRadius: 3)
                          ],
                        borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(0),
                        topRight: Radius.circular(50),
                      ),
                  //   color: MyColors.lightBlue,
                      color: MyColors.white200,
                    ),
                    child: Center(
                      child: Text("Your order is",
                        style: Get.textTheme.bodyText1!.copyWith( fontWeight: FontWeight.normal),),
                    ),
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text("Prepared", style: TextStyle(color: MyColors.white),),
                    ],
                  )
                ],
              ),

            ),
          ),
        ),
        SizedBox(height: 10,),

        Container(
          height: SingleToneValue.instance.orderPlaced as bool==true ?  MediaQuery.of(context).size.height * 0.2 :
          MediaQuery.of(context).size.height * 0.2,
          width: mediaQuery.width*1.0,


          child: Stack(
            children: [
              Builder(
                builder: (context) {
                  final double height = MediaQuery.of(context).size.height;
                  return CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1.5,
                       height: 130,



                      // viewportFraction:1.1,
                      // enlargeCenterPage: false,
                      //  aspectRatio: 16/9,
                      //  autoPlay: true,

                      // // aspectRatio: 16 / 9,
                      //
                      // // initialPage: 0,
                      // // enableInfiniteScroll: true,
                      // // reverse: false,
                      //
                      // autoPlayInterval: Duration(seconds: 3),
                      // autoPlayAnimationDuration: Duration(milliseconds: 800),
                      // autoPlayCurve: Curves.easeIn,
                      // //enlargeCenterPage: true,
                      // // onPageChanged: callbackFunction,
                      // scrollDirection: Axis.horizontal,
                    ),
                    items: carouselImages
                        .map((item) => Container(
                      width: mediaQuery.width*1.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item,
                          fit: BoxFit.fitWidth,
                          width: double.infinity,

                        ),
                      ),
                    ))
                        .toList(),
                  );
                },
              ),
              // PageView.builder(
              //   onPageChanged: (index) {
              //     setState(() {
              //       _current = index;
              //     });
              //   },
              //   controller: _pageController,
              //   itemBuilder: (_, index) {
              //     var imageData = carouselImages[
              //     index % carouselImages.length];
              //     double scale = (pageOffset - index).abs() +
              //         viewportFraction;
              //     return ClipRRect(
              //         // borderRadius:
              //         // BorderRadius.circular(8),
              //         child: Image.asset(imageData,
              //             fit: BoxFit.cover, width: double.infinity,));
              //   },
              // ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: dotIndicator(
                        _current % carouselImages.length)),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget dotIndicator(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: carouselImages
          .asMap()
          .map(
            (e, value) {
          return MapEntry(
            e,
            Padding(
              padding: EdgeInsets.all(3),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    color: e == index
                        ? MyColors.white
                        : MyColors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30)),
                width: e == index ? 20 : 8,
                height: 8,
              ),
            ),
          );
        },
      )
          .values
          .toList(),
    );
  }
}

