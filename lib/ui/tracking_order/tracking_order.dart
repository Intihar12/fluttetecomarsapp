import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

import '../../data/controller/location_map_controller/tracking_order_controller.dart';
import '../order_status/order_status.dart';

class TrackingOrder extends StatelessWidget {
TrackingOrderController _controller=Get.put(TrackingOrderController());
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Tracking Order'),
          elevation: 0,
        //  backgroundColor: MyColors.darkBlue,
          leading: GestureDetector(
            onTap: (){
              Get.off(OrderStatus());
            },
              child: Icon(Icons.arrow_back_outlined,size: Dimens.size30,)),
        ),
        body: GetBuilder<TrackingOrderController>(
          init: TrackingOrderController(),
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Container(
                  height: mediaQuery.height*0.55,
                     child: Stack(
                children: [
                  ( controller.lat2==null && controller.lng2==null )||
                      (controller.driverLat==null  && controller.driverLng==null)?
                      Center(child: CircularProgressIndicator()):
                  GoogleMap(
                    initialCameraPosition:CameraPosition(target: LatLng(
                     controller.lat2!,controller.lng2!
                    ), zoom: 16) ,
                    gestureRecognizers:
                    <Factory<OneSequenceGestureRecognizer>>[
                      new Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                      ),
                    ].toSet(),
                    onMapCreated: controller.onMapCreated1,
                    markers: controller.markers,
                    polylines:  controller.polylines,

                  ),
              ],
            ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text('Your Grocery is on the way !',
                      style: Get.textTheme.headline2!.copyWith(
                        color: MyColors.primaryColor
                      ),
                      ),
                      SizedBox(height: 25,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: MyColors.cardColor,
                                  child: Icon(Icons.person),
                                ),
                                SizedBox(width: 10,),
                                SizedBox(
                                  width: 100,

                                  child:
                                  controller.driverName==null?
                                      Text('loading')
                                 : Text(controller.driverName!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Get.textTheme.headline4!.copyWith(
                                    color: MyColors.black
                                  ),
                                  ),
                                )
                              ],
                            ),
                            Row(children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
  Text('Estd. Delivery',

  style: Get.textTheme.subtitle2!.copyWith(
    color: MyColors.textVColor.withOpacity(0.5)
  ),
  ),
                               controller.estimateTime==null?
                               Text('loading'):
                                  Text(controller.estimateTime!,
                                  style: Get.textTheme.headline6!.copyWith(
                                    color: MyColors.black
                                  ),
                                  )

                                ],
                              )

                            ],)
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: MaterialButton(
                          onPressed: (){
                          controller.makePhoneCall();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.primaryColor,

                            ),
                            child:Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                ),
                                Icon(Icons.phone,
                                  size: 30,
                                  color: MyColors.white,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text('Call Driver',
                                  style: Get.textTheme.headline6!.copyWith(
                                      color: MyColors.white
                                  ),
                                )
                              ],
                            )
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: MaterialButton(
                          onPressed: (){

                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.primaryColor,

                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 120,
                                ),
                                  Icon(Icons.mail,
                                  size: 30,
                                    color: MyColors.white,
                                  ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text('Message',
                                style: Get.textTheme.headline6!.copyWith(
                                  color: MyColors.white
                                ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }
        ),
        ),
    );

  }
}
