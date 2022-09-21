import 'dart:async';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/homepage_controller/homepage_controller.dart';
import 'package:kiwkemart/data/model/home_data/home_data.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

//
//
// class HomeSlider extends StatefulWidget {
//   List<HomeData>? homeData;
//  HomeSlider(this.homeData);
//
//   @override
//   _HomeSliderState createState() => _HomeSliderState();
// }
//
// class _HomeSliderState extends State<HomeSlider> {
//
//
//   var _current = 0;
//   late PageController _pageController;
//   double viewportFraction = 0.9;
//   double pageOffset = 0;
//   List<String> carouselImages = [
//     MyImgs.banner1,
//     MyImgs.banner2,
//     MyImgs.banner3,
//     MyImgs.banner4,
//   ];
//
//   // List<HomeData> carouselImages=[];
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(
//         keepPage: false,
//         initialPage: _current,
//         viewportFraction: viewportFraction)
//       ..addListener(() {
//         setState(() {
//           pageOffset = _pageController.page!;
//         });
//       });
//     Timer.periodic(
//       Duration(seconds: 5),
//           (Timer timer) {
//         _current < carouselImages.length - 1 ? _current++ : _current = 0;
//
//         if (_pageController.hasClients)
//           _pageController.animateToPage(
//             _current,
//             duration: Duration(milliseconds: 350),
//             curve: Curves.easeIn,
//           );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     var mediaQuery=MediaQuery.of(context).size;
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.22,
//       child: Stack(
//         children: [
//           PageView.builder(
//             onPageChanged: (index) {
//               setState(() {
//                 _current = index;
//               });
//             },
//             controller: _pageController,
//             itemBuilder: (_, index) {
//               var imageData = carouselImages[
//               index % carouselImages.length];
//               double scale = (pageOffset - index).abs() +
//                   viewportFraction;
//               return Padding(
//                 padding: EdgeInsets.only(
//                     left: 2,
//                     right: 2,
//                     top: scale * 10,
//                     bottom: scale * 10),
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     ClipRRect(
//                         borderRadius:
//                         BorderRadius.circular(8),
//                         child: Image.asset(imageData,
//                             fit: BoxFit.cover)),
//                     Container(
//                         decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.1),
//                             borderRadius:
//                             BorderRadius.circular(8))),
//                   ],
//                 ),
//               );
//             },
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 16),
//             child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: dotIndicator(
//                     _current % carouselImages.length)),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget dotIndicator(int index) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: carouselImages
//           .asMap()
//           .map(
//             (e, value) {
//           return MapEntry(
//             e,
//             Padding(
//               padding: EdgeInsets.all(3),
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 decoration: BoxDecoration(
//                     color: e == index
//                         ? MyColors.white
//                         : MyColors.white.withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(30)),
//                 width: e == index ? 20 : 8,
//                 height: 8,
//               ),
//             ),
//           );
//         },
//       )
//           .values
//           .toList(),
//     );
//   }
// }


class HomeSlide extends StatelessWidget {
  HomeSlide({Key? key}) : super(key: key);

  final HomeSlideController controller = Get.put(HomeSlideController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSlideController>(
        builder: (controller)
    {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.22,
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (index) {
                // setState(() {
                controller.current = index;
                controller.update();
                // });
              },
              controller: controller.pageController,
              itemBuilder: (_, index) {
                // var imageData = controller.carouselImages![
                // index % controller.carouselImages!.length];
                double scale = (controller.pageOffset - index).abs() +
                    controller.viewportFraction;
                // printInfo(info: controller.homeController.homeData!.response!.imagesUrl!+'/'+
                //     controller.carouselImages![controller.current].image!);
                return Padding(
                  padding: EdgeInsets.only(
                      left: 2,
                      right: 2,
                      top: scale * 10,
                      bottom: scale * 10),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                          borderRadius:
                          BorderRadius.circular(8),
                          child: Image.network(
                              // 'https://images.unsplash.com/photo-1642941522026-0579792e1ca0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDF8eGpQUjRobGtCR0F8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60'
                              controller.homeController.homeData!.response!.imagesUrl!+'/'+

                                 controller.carouselImages![index % controller.carouselImages!.length].image!,
                              fit: BoxFit.cover)),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius:
                              BorderRadius.circular(8))),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: dotIndicator(
                      controller.current % controller.carouselImages!.length)),
            ),
          ],
        ),
      );
    });
  }

  Widget dotIndicator(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: controller.carouselImages!
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

class HomeSlideController extends GetxController{

  var current = 0;
  late PageController pageController;
  double viewportFraction = 0.9;
  double pageOffset = 0;

  HomeController homeController = Get.find<HomeController>();
  List<Banners>? carouselImages;
  String? imageBase = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    carouselImages = homeController.homeData!.response!.banners;
    imageBase = homeController.homeData!.response!.imagesUrl!;
    pageController = PageController(
        keepPage: false,
        initialPage: current,
        viewportFraction: viewportFraction)
      ..addListener(() {
        // setState(() {
        pageOffset = pageController.page!;
        // });
      });
    Timer.periodic(
      Duration(seconds: 5),
          (Timer timer) {
        current < carouselImages!.length - 1 ? current++ : current = 0;
        if (pageController.hasClients)
          pageController.animateToPage(
            current,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
      },
    );

  }


}

