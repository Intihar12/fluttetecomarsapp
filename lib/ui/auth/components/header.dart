import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

import 'custom_shape.dart';



class HeaderAPP extends StatelessWidget {

String title;
HeaderAPP({required this.title});
  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    return
         Container(
          child:Column(
            children: [
              ShapeOfView(
                color: LinearGradient(
                  colors: [
                    //  Get.theme.colorScheme.onSecondary,
                    Get.theme.colorScheme.primary,
                    MyColors.gradient1
                  ],
                  begin: const FractionalOffset(0.0, 1.0),
                  end: const FractionalOffset(0.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
                height: 290,
                width: mediaQuery.width,
                shape: ArcShape(
                  direction: ArcDirection.Outside,
                  height: 30,
                  position: ArcPosition.Bottom,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Text(title,
                      style: Get.textTheme.headline1!.copyWith(
                        color: Get.theme.colorScheme.onPrimary,
                        //  fontWeight: FontWeight.normal
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: mediaQuery.height*0.17,
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ClipOval(
                                child: Image.asset(MyImgs.whiteLogo,
                                  // height: 20,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Text('Get groceries delivered at\nyour doorstep!',
                      textAlign: TextAlign.center,
                      style: Get.textTheme.headline1!.copyWith(
                        color: Get.theme.colorScheme.onPrimary,
                        //  fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ) ,
        ) ;

  }
}
