import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/auth_controller/auth_controller.dart';
import 'package:kiwkemart/data/controller/location_map_controller/location_controller.dart';
import 'package:kiwkemart/data/controller/location_map_controller/location_map_controller.dart';
import 'package:kiwkemart/data/repository.dart';
import 'package:kiwkemart/data/shared_pref_client.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/auth/components/splash_animation.dart';
import 'package:kiwkemart/ui/auth/walkthrough.dart';
import 'package:kiwkemart/ui/deliveryAddress/delivery_address.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/values/strings.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../data/constants/constants.dart';
import 'delivery_location_set.dart';
import 'login/login.dart';


// class SplashScreen extends StatefulWidget {
//
// @override
// _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//
// }



class SplashScreen extends StatelessWidget {

  final _sharedPrefClient = SharedPrefClient();
  final _repo=Repository();
//  LocationMapController controller=Get.put(LocationMapController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => _afterBuild(context));

    // final mediaQuery = MediaQuery.of(context);
    // final isLandScape = mediaQuery.orientation == Orientation.landscape;
    // var height;
    // setState(() {
    //   if (isLandScape) {
    //     height = mediaQuery.size.width;
    //   } else {
    //     height = mediaQuery.size.height;
    //   }
    // });
    var height = Get.height;
    return SafeArea(
      child: Scaffold(
          body: Container(
            // color:Colors.amberAccent,
            color: Get.theme.colorScheme.primary,
            height: height * 1,
            width: MediaQuery
                .of(context)
                .size
                .width * 1,
            child: ShakeAnimation(
              axix: Axis.vertical,
              duration: Duration(milliseconds: 2000),
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(100),
//   color: Colors.grey,
                      image: DecorationImage(
                          image: AssetImage(MyImgs.whiteLogo)
                      )
                  ),

                ),
              ),
            ),
          )
      ),
    );
  }




  void _afterBuild(BuildContext context) => _checkInternetAndProceed(context);

  void _checkInternetAndProceed(BuildContext context) async {
    // print("#checkInternetAndProceed");
    var flagConnected = false;
    try {
      final result =
      await InternetAddress.lookup('google.com').timeout(Duration(
        seconds: 5,
      ));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // when connected
        flagConnected = true;
      }
    } catch (_) {}
    if (flagConnected) {
       _checkLocationAndMove(context);
     // Get.to(Home());
      // Get.offAll(DeliveryAddress());
    }
    else {
       //when no internet
       // _checkLocationAndMove(context);
      _onNoInternet(context);
    }
  }

  void _onNoInternet(BuildContext context) {
    // print("#showModalBottomSheet");
    showModalBottomSheet<void>(
      isDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft:  Radius.circular(Dimens.size10),
          topRight:  Radius.circular(Dimens.size10),
        ),
      ),
      builder: (builderContext) => _buildNoInternetWgt(context, builderContext),
    );
  }

  Widget _buildNoInternetWgt(
      BuildContext context, BuildContext builderContext) {

    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: EdgeInsets.all(Dimens.size16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Internet Connection',
            style: Theme.of(context).textTheme.headline6,
          ),
          Image.asset(
            MyImgs.noInternetImage,
            width: Dimens.size200,
            height: Dimens.size200,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(builderContext);
              _checkInternetAndProceed(context);
            },
            child: Text('Try Again'),
          ),
        ],
      ),
    );
  }
  void _checkLocationAndMove(BuildContext context) async {
    try{
      _repo.firebaseCloudMessagingListeners();
      String? lat = await _sharedPrefClient.getLat();
      String? lng = await _sharedPrefClient.getLng();
      String? walkThrough = await _sharedPrefClient.getWalkThrough();
      String? userId = await _sharedPrefClient.getUserId();
      SingleToneValue.instance.userName = await _sharedPrefClient.getUserName();
      if(lat == 'lat' && lng == 'lng' && walkThrough == '0' ){
        Get.to(WalkThroughScreen());
       }
      else if ( userId == '-21' ){
        Get.offAll(Login());
      }

        else
          {

         String? getCartList = await _sharedPrefClient.getCartItem();

         if(getCartList != "[]") {

           emptyCartOnDateChange().then((value) => Get.offAll(Home()));
         }else{
           Get.offAll(Home());
         }

      }

    }catch(_){

    }


  }

  // void _checkSessionAndProceed() async {
  //   if (await controller.isUserLoggedIn()) {
  //     Get.to(Home());
  //   } else {
  //     Get.to(WalkThroughScreen());
  //   }
  // }


  Future emptyCartOnDateChange() async {

    String? getCurrentDate  = await _sharedPrefClient.getCurrentDateTime();

    if(getCurrentDate == null || getCurrentDate == ""){
      List<String> list = DateTime.now().toString().split(" ");
      await _sharedPrefClient.setCurrentDateTime(list[0]);
    }else{
      String? getCurrentDate  = await _sharedPrefClient.getCurrentDateTime();
      List<String> list = DateTime.now().toString().split(" ");
      if(getCurrentDate != list[0]){
        _sharedPrefClient.setCartItem("[]");
        Constants.cartCount.value = 0;
        await _sharedPrefClient.setCurrentDateTime("");
      }
    }
  }


}
