import 'dart:async';

import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:kiwkemart/ui/auth/walkthrough.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'custom_shape.dart';
import 'dart:math';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({Key? key}) : super(key: key);

  @override
  _SplashAnimationState createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 10),
            () => Get.to(WalkThroughScreen(), transition: Transition.downToUp,duration: Duration(milliseconds: 1500))
    );
  }


  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
 
    return Container(
//color:   Get.theme.colorScheme.primary,
      child: SafeArea(

        child:
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
         //height: 320,
          width: mediaQuery.width,
          shape: ArcShape(
            direction: ArcDirection.Outside,
            height: 30,
            position: ArcPosition.Top,
          ),


          child: Container(
          color: Get.theme.colorScheme.primary,
child: ShakeAnimation(
axix: Axis.vertical,
  duration: Duration(milliseconds: 1500),


  child:

    Center(
    child: Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(100),
  //   color: Colors.grey,
  //         image: DecorationImage(
  //             image: AssetImage(MyImgs.whiteLogo)
  //         )
      ),
  child: AnimatedTextKit(
    animatedTexts: [
      TypewriterAnimatedText(
        'Kiwk\nemart',
        textStyle: const TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.bold,
            fontFamily: 'FontsFree-Net-avertaextraboldotf',
          color: Colors.white
        ),
        speed: const Duration(milliseconds: 1000),
      ),
    ],

    totalRepeatCount: 4,
    pause: const Duration(milliseconds: 1000),
    displayFullTextOnTap: true,
    stopPauseOnTap: true,
  )
    ),
  ),
),
          ),
        ),
      )

    );
  }


}





class ShakeAnimation extends StatelessWidget {
  const ShakeAnimation({
    Key? key,
    this.duration=const Duration(milliseconds: 900),
    required this.child,
  this.offset=1.0,
    this.axix=Axis.horizontal,
  }) : super(key: key);
final Duration duration;
final double offset;
  final Widget child;
final Axis axix;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        child: child,
        duration: duration,
        curve: Curves.bounceInOut,
        tween: Tween(begin: 1.0,end: 0.1),
        builder: ( context,value, child){
          return Transform.translate(

              offset: axix==Axis.horizontal?
              Offset(
                value * offset,
                0.0,
              )
            :Offset(

0.0,

                value * offset,


              )
            ,
            child: child,
          );
        }


    );
  }
}


