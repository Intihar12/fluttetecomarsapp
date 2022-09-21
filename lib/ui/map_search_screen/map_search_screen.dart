import 'dart:async';

import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwkemart/data/controller/location_map_controller/location_controller.dart';
import 'package:kiwkemart/data/model/map_search_models/map_autocomplete_model/map_auto_complete_model.dart';
import 'package:kiwkemart/data/shared_pref_client.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/address/address_details.dart';
import 'package:kiwkemart/ui/address/save_adress.dart';
import 'package:kiwkemart/ui/delivery/delivery.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';

import '../auth/login/login.dart';

class MapScreen extends StatelessWidget {
 final int? id;

  MapScreen({ this.id});

  LocationMapController locationController = Get.put(LocationMapController());
  final sharedPrefClient = SharedPrefClient();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return WillPopScope(
      onWillPop: () {
        return onPopScope();
      },
      child: SafeArea(
        child: Scaffold(
         // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            // backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text('Your address'),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                 onPopScope();
                  },
                );
              },
            ),
          ),
          body: GetBuilder(builder: (LocationMapController locationController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SingleToneValue.instance.currentLat== 31.4643687 &&
                //     SingleToneValue.instance.currentLng==74.2414678?
                //     Center(child: CircularProgressIndicator())
                // :
                Container(
                  height: Get.height * 0.6,
                  child: Stack(
                    children: [
                      GoogleMap(
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(SingleToneValue.instance.currentLat,
                              SingleToneValue.instance.currentLng),
                          zoom: 16.151926040649414,
                        ),
                        onCameraMove: (CameraPosition position) {
                          SingleToneValue.instance.currentLat =
                              position.target.latitude;
                          SingleToneValue.instance.currentLng =
                              position.target.longitude;
                          print("lat+ ${locationController.lat}");
                          print("lng+${locationController.lng}");
                        },
                        onMapCreated: (GoogleMapController controller) {
                          locationController.onMapCreated(controller);
                        },
                        onCameraIdle: () async {

                          if(id==SingleToneValue.instance.loginPageID){

                            locationController.getCustomLocation(
                                SingleToneValue.instance.currentLat,
                                SingleToneValue.instance.currentLng);

                            locationController.onLatLngPosition(
                                SingleToneValue.instance.currentLat,
                                SingleToneValue.instance.currentLng);
                            await sharedPrefClient.setAddress(locationController.customLocation.value);
                          }
                          else if(id==SingleToneValue.instance.guestUserId){
                            locationController.getCustomLocation(
                                SingleToneValue.instance.currentLat,
                                SingleToneValue.instance.currentLng);

                            locationController.onLatLngPosition(
                                SingleToneValue.instance.currentLat,
                                SingleToneValue.instance.currentLng);
                            await sharedPrefClient.setAddress(locationController.customLocation.value);
                          }
                          else if(id==SingleToneValue.instance.homePageId){
                            locationController.getCustomLocation(
                                SingleToneValue.instance.currentLat,
                                SingleToneValue.instance.currentLng);

                           locationController.onLatLngPosition(
                               SingleToneValue.instance.currentLat,
                               SingleToneValue.instance.currentLng);
                            await sharedPrefClient.setAddress(locationController.customLocation.value);
                          }
                          else if(id==SingleToneValue.instance.deliveryAddress){

                            locationController.getCustomLocation(
                                SingleToneValue.instance.currentLat,
                                SingleToneValue.instance.currentLng);

                            locationController.onLatLngPosition(
                                SingleToneValue.instance.currentLat,
                                SingleToneValue.instance.currentLng);
                          }
                          else{
                            locationController.getCustomLocation(
                                SingleToneValue.instance.currentLat,
                                SingleToneValue.instance.currentLng);

                            locationController.onLatLngPosition(
                                SingleToneValue.instance.currentLat,
                                SingleToneValue.instance.currentLng);
                          }

                        },
                      ),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Image.asset(
                                MyImgs.pinIcon,
                                height: Dimens.size35,
                              ))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Text("Choose your address",
                      style: Get.textTheme.headline4!
                          .copyWith(color: Get.theme.colorScheme.secondary)),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(" We 'll find near store",
                      style: Get.textTheme.bodyText2!
                          .copyWith(color: MyColors.cardGrey)),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    locationController.update();
                    locationController
                        .callApi(locationController.customLocation.value);
                    locationController.update();
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 0.85,
                        minChildSize: 0.6,
                        maxChildSize: 0.85,
                        builder: (
                          context,
                          scrollController,
                        ) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    height: 3,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: MyColors.grey,
                                        borderRadius: BorderRadius.circular(2)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, right: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      //  color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: MyColors.grey, width: 1),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(
                                              3, 0), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    height: 55,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            onEditingComplete: (){
                                              FocusScope.of(context).requestFocus(FocusNode());
                                            },
                                              controller: locationController
                                                  .locationTextController,
                                              onChanged: (value) {

                                                 locationController.callApi(value);


                                              },

                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 14),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none)),
                                            ),

                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            locationController
                                                .locationTextController
                                                .clear();
                                           // Get.back();
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: MyColors.grey,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    height: Get.height * 0.6,
                                    child: locationController.searchPlaces!.value != null
                                        ? Obx(()=>listview(context, locationController.searchPlaces!.value))
                                        : Text('')),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: Get.height * 0.055,
                      decoration: BoxDecoration(
                          //  color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: MyColors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Container(
                              width: Get.width * 0.8,
                              child: Obx(
                                () => Text(
                                  locationController.customLocation.value,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Get.theme.colorScheme.secondary,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                locationController.result.isTrue?
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: CustomButton(
                    text: 'Choose this address',
                    height: 0.055,
                    width: mediaQuery.width,
                    roundCorner: 10,
                    onPressed: () async {
                     locationController.chooseButton(id!);
                    },
                  ),
                )
                    :
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: CustomButton(
                    text: 'No address Select',
                    height: 0.055,
                    width: mediaQuery.width,
                    color: MyColors.red500,
                    roundCorner: 10,
                    onPressed: () async {
                      Get.snackbar("Location", "Not  Address select");
                    },
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _location(
      {required StructuredFormatting data, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.pin_drop_outlined,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Text(
                      data.maintext,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Text(
                  secnT(data: data),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String secnT({required StructuredFormatting data}) {
    if (data.secondarytext != null) {
      return data.secondarytext;
    }
    locationController.update();
    return '';
  }

  Widget listview(BuildContext context, AutoComplete data) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.predict.length,
        padding: const EdgeInsets.only(top: Dimens.size16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: Dimens.size5),
            child: GestureDetector(
              onTap: () async {
                SingleToneValue.instance.currentAddress =
                    data.predict[index].structuredformatting.secondarytext;
                locationController.mainText =
                    data.predict[index].structuredformatting.maintext;
                locationController.secondaryText =
                    data.predict[index].structuredformatting.secondarytext;
                locationController.callApi(' ');
                locationController.locationTextController.text =
                    locationController.mainText;
                FocusScope.of(context).requestFocus(new FocusNode());
                await locationController
                    .callApiLatLong(data.predict[index].placeid);
                Get.back();
              },
              child: _location(
                  data: data.predict[index].structuredformatting,
                  context: context),
            ),
          );
        },
      ),
    );
  }
  onPopScope() {
locationController.onPopScopeButton(id!);
  }
}
