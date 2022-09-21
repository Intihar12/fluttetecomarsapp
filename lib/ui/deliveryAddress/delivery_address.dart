import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwkemart/data/controller/location_map_controller/location_map_controller.dart';
import 'package:kiwkemart/data/model/map_search_models/map_autocomplete_model/map_auto_complete_model.dart';
import 'package:kiwkemart/data/model/map_search_models/map_search/map_search.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/custom_textfield.dart';

class DeliveryAddress extends StatelessWidget {
  // final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
        init: LocationController(),
        builder: (controller) {
          // var theme = Theme.of(context);
          // var textTheme = theme.textTheme;
          // var mediaQuery = MediaQuery.of(context).size;
          return SafeArea(
            child: Scaffold(
                body: Container(
              height: Get.height * 1.1,
              child: Stack(
                children: [
                  Container(
                      height: Get.height * 0.8,
                      child: Stack(
                        children: [
                          //    SimpleMap()
                          GoogleMap(
                            zoomControlsEnabled: true,
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: controller.latLng,
                              zoom: 16.151926040649414,
                            ),
                            onMapCreated: (GoogleMapController con) {
                              controller.mapCompleter.complete(con);
                            },
                            onCameraMove: (CameraPosition position) {
                              controller.latLng = LatLng(
                                  position.target.latitude,
                                  position.target.longitude);
                              controller.update();
                            },
                            onCameraIdle: () {
                              if(controller.moveLng != controller.latLng){
                                controller.onCameraMoveUpdate();
                              }
                            },
                          ),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Image(
                              image: AssetImage("assets/images/map_pin.png"),
                              width: 35,
                              height: 35,
                            ),
                          )),
                        ],
                      )),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: NotificationListener<
                            DraggableScrollableNotification>(
                        onNotification: (notification) {
                          controller.sheetDrag(notification.extent);
                          // LowerSheet.notifier.value = notification.extent;
                          return false;
                        },
                        child: DraggableScrollableActuator(
                          child: DraggableScrollableSheet(
                              key: Key(controller.flag.toString()),
                              expand: true,
                              minChildSize: controller.minExtent,
                              maxChildSize: controller.maxExtent,
                              initialChildSize: controller.initialExtent,
                              builder: (BuildContext context,
                                  ScrollController scrollcontroller) {
                                controller.draggableSheetContext = context;
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: MyColors.darkBlue,
                                  ),
                                  child: SingleChildScrollView(
                                      controller: scrollcontroller,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      if (controller.draggableSheetContext != null) {
                                                        if (controller.isExpanded) {
                                                          controller.initialExtent = controller.minExtent;
                                                          controller.isExpanded = !controller.isExpanded;
                                                          controller.flag = 0;
                                                        } else {
                                                          controller.initialExtent = controller.maxExtent;
                                                          controller.flag = 1;
                                                          controller.isExpanded = !controller.isExpanded;
                                                          controller.getPlaces(controller.postCodeController.text  );
                                                        }
                                                        controller.update();
                                                        DraggableScrollableActuator
                                                            .reset(controller
                                                                .draggableSheetContext);
                                                      }
                                                    },
                                                    child: Text('Down')),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Container(
                                                    height: Dimens.size50,
                                                    width: Get.width * 0.8,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(Dimens
                                                                    .size15),
                                                        border: Border.all(
                                                          color: MyColors.white,
                                                        ),
                                                        color:
                                                            MyColors.darkBlue),
                                                    child: CustomTextField(
                                                      onChanged: (value){
                                                        controller.getPlaces(value.toString());
                                                      },
                                                        icon: Icon(
                                                          Icons.search,
                                                          color: MyColors.white,
                                                        ),
                                                        text: 'Search Address',
                                                        hintColor:
                                                            MyColors.white,
                                                        length: 200,
                                                        border: InputBorder.none,
                                                        controller: controller.postCodeController,
                                                        onSaved: (value) {
                                                          controller.postCD = value!;
                                                        },
                                                        validator: (value) {
                                                          return controller.validatePostCode(value!);
                                                        },
                                                        keyboardType: TextInputType.name,
                                                        inputFormatters: FilteringTextInputFormatter.singleLineFormatter),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            controller.isExpanded
                                                ?
                                                controller.autoComplete == null
                                                    ? CircularProgressIndicator()
                                                    : Column(
                                                        children: List.generate(
                                                            controller
                                                                .autoComplete!
                                                                .predict
                                                                .length,
                                                            (index) {
                                                        return GestureDetector(
                                                          onTap: () async {
                                                           controller.idtoLatLong = await controller.getPlacesLatLong(controller
                                                                .autoComplete!
                                                                .predict[index].placeid);
                                                           controller.latLng = LatLng(controller.idtoLatLong!.result.geometry.locationData.lat,
                                                               controller.idtoLatLong!.result.geometry.locationData.lng);
                                                           controller.postCodeController.text = await controller.getAddress();
                                                           controller.autoComplete = null;
                                                           controller.isExpanded = false;
                                                           controller.initialExtent = controller.minExtent;
                                                           controller.flag = 0;
                                                           controller.update();
                                                           printInfo(info: "AAHHHHHH"+controller.latLng.toString());
                                                           await controller.animateCamera(controller.latLng);
                                                          },
                                                          child: _locationSelect(controller
                                                              .autoComplete!
                                                              .predict[index].structuredformatting.maintext,
                                                            controller
                                                                .autoComplete!
                                                                .predict[index].structuredformatting.secondarytext),
                                                        );
                                                      }))
                                                : SizedBox(),
                                            controller.isExpanded
                                                ? SizedBox()
                                                : Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: CustomButton(
                                                      height: 0.06,
                                                      width: 0.6,
                                                      text: "Submit",
                                                      onPressed: ()async{
                                                        await controller.sharedPrefClient.setLat('31.4545');
                                                        await controller.sharedPrefClient.setLng('74.56854');
                                                       Get.offAll(Home());
                                                      },
                                                      color: MyColors.white,
                                                      textColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                    ),
                                                  )
                                          ])),
                                );
                              }),
                        )),
                  )

                  // DraggableScrollableSheet(
                  //   initialChildSize: 0.3,
                  //   minChildSize: 0.1,
                  //   maxChildSize: 0.9,
                  //   builder: (context , scrollController){
                  //     return SingleChildScrollView(
                  //       //   physics: NeverScrollableScrollPhysics(),
                  //       controller:  scrollController,
                  //       child: Form(
                  //         key: controller.postFormKey,
                  //         child: Container(
                  //           height: mediaQuery.height*0.9,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(12),
                  //             color: MyColors.darkBlue,
                  //           ),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: [
                  //               Text("Add Delivery Address", style: textTheme.headline2!.copyWith( color: theme.colorScheme.background),),
                  //               Container(
                  //                 height: Dimens.size70,
                  //                 width:mediaQuery.width*0.8 ,
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(Dimens.size15),
                  //                     border: Border.all(
                  //                       color: MyColors.white,
                  //                     ),
                  //                     color: MyColors.darkBlue
                  //                 ),
                  //                 child:  CustomTextField(
                  //                     icon: Icon(Icons.search, color: MyColors.white,),
                  //                     text: controller.currentAddress ?? '',
                  //                     hintColor: MyColors.white,
                  //                     length: 200,
                  //                     border: InputBorder.none,
                  //                     controller: controller.postCodeController,
                  //                     onSaved: (value) {
                  //                       controller.postCD = value!;
                  //                     },
                  //                     validator: (value) {
                  //                       return controller.validatePostCode(value!);
                  //
                  //                     },
                  //                     keyboardType: TextInputType.name,
                  //                     inputFormatters: FilteringTextInputFormatter.singleLineFormatter),
                  //
                  //               ),
                  //               SizedBox(
                  //                 height: Dimens.size10,
                  //               ),
                  //               // Row(
                  //               //   mainAxisAlignment: MainAxisAlignment.center,
                  //               //   children: [
                  //               //     Icon(Icons.play_arrow_rounded, color: MyColors.white,),
                  //               //
                  //               //     GestureDetector(
                  //               //         onTap: (){
                  //               //            location.onButtonCurrentLocation();
                  //               //         },
                  //               //         child: Text("   Use my current location", style: textTheme.bodyText1!.copyWith( color: theme.colorScheme.background),))
                  //               //   ],
                  //               // ),
                  //               SizedBox(
                  //                 height: Dimens.size35,
                  //               ),
                  //               CustomButton(height: 0.06, width: 0.6, text: "Submit",
                  //                 onPressed: (){
                  //                   // location.onSubmitButtonClick();
                  //                   // Get.to(LocationError());
                  //                 },
                  //                 color: MyColors.white, textColor: theme.primaryColor,)
                  //
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            )),
          );
        });
  }

  Widget _locationSelect(String mainTxt, String subTxt) {
    return Container(
      child: ListTile(
        leading: Icon(
          Icons.location_pin,
          color: MyColors.darkBlue,
        ),
        title: Text(
          mainTxt != null ? mainTxt : '',
          // style: Theme.of(context).,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subTxt != null ? subTxt : '',
          // style: Styles.appTheme.textTheme.bodyText1,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
