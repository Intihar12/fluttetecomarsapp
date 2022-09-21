import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/saveaddress_controller/saveaddress_controller.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/delivery/delivery.dart';
import 'package:kiwkemart/ui/home/components/drawer.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/map_new_location/add_new_location/add_new_location.dart';
import 'package:kiwkemart/ui/map_new_location/confirm_new_address/confirm_new_address.dart';
import 'package:kiwkemart/ui/map_new_location/enter_new_address/enter_new_address.dart';
import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';

import '../../data/shared_pref_client.dart';
import '../values/my_colors.dart';
import '../values/values.dart';
import '../widgets/expandable_text.dart';
import 'address_details.dart';

class SaveAddress extends StatelessWidget {
  int id;

  SaveAddress(this.id);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final sharedPrefClient = SharedPrefClient();
  int listIndex = 0;
  double? lat;
  double? long;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return onPopScope();
      },
      child: SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Saved Address',
                style: Get.textTheme.headline2!.copyWith(
                  color: MyColors.white,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  onPopScope();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: MyColors.white,
                ),
              ),
            ),
            body: GetBuilder<SaveAddressController>(
                init: SaveAddressController(),
                builder: (value) {
                  return value.noInternet || value.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : value.addressModel == null
                          ? SizedBox(
                              child: Center(
                              child: Text('Server Error',
                                  style: Get.textTheme.headline1!
                                      .copyWith(color: MyColors.primaryColor)),
                            ))
                          : value.addressModel!.response!.isEmpty
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Image.asset(
                                      MyImgs.noAddressFoundImg,
                                      height: 200,
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Center(
                                      child: Text(
                                          'No Address Found Please Add Address',
                                          style: Get.textTheme.headline1!
                                              .copyWith(
                                                  color:
                                                      MyColors.primaryColor)),
                                    ),
                                    SizedBox(
                                      height: Dimens.size100,
                                    ),
                                    CustomButton(
                                      height: 0.065,
                                      width: 0.8,
                                      text: 'Add New Location',
                                      onPressed: () {
                                        value.onButtonClick(id);
                                      },
                                      roundCorner: Dimens.size5,
                                    )
                                  ],
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                          height: mediaQuery.height * 0.72,
                                          width: Get.width,
                                          child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            controller: value.controller,
                                            itemCount: value
                                                .addressModel!.response!.length,
                                            itemBuilder: (context, int index) {
                                              return Padding(
                                                padding: EdgeInsets.all(10),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    //  listIndex=index;
                                                    if (id ==
                                                        SingleToneValue.instance
                                                            .deliveryAddress) {
                                                      // SingleToneValue.instance.userAddressId=value.addressModel!.response![index].id;
                                                      SingleToneValue.instance
                                                              .deliveryScreenAddress =
                                                          value
                                                              .addressModel!
                                                              .response![index]
                                                              .address!;
                                                      // SingleToneValue.instance.deliveryScreenPostalCode=value.addressModel!.response![index].postalCode!;
                                                      // await sharedPrefClient.setUserAddressId(SingleToneValue.instance.userAddressId!);
                                                      lat = double.parse(value
                                                          .addressModel!
                                                          .response![index]
                                                          .latitude!);
                                                      long = double.parse(value
                                                          .addressModel!
                                                          .response![index]
                                                          .longitude!);
                                                      // SingleToneValue.instance.deliveryLat=lat.toString();
                                                      // SingleToneValue.instance.deliveryLng=long.toString();
                                                      value.storeLocation(
                                                          lat: lat!,
                                                          lng: long!,
                                                          pageId: SingleToneValue
                                                              .instance
                                                              .deliveryAddress,
                                                          address: value
                                                              .addressModel!
                                                              .response![index]
                                                              .address!,
                                                          addressId: value
                                                              .addressModel!
                                                              .response![index]
                                                              .id!);
                                                    } else if (id ==
                                                        SingleToneValue.instance
                                                            .homePageId) {
                                                      // SingleToneValue.instance.userAddressId=value.addressModel!.response![index].id;
                                                      // await sharedPrefClient.setUserAddressId(SingleToneValue.instance.userAddressId!);
                                                      //  SingleToneValue.instance.currentLat=double.parse(value.addressModel!.response![index].latitude!);
                                                      //   await sharedPrefClient.setLat(value.addressModel!.response![index].latitude!);
                                                      //   await sharedPrefClient.setLng(value.addressModel!.response![index].longitude!);
                                                      //   await sharedPrefClient.setAddress(value.addressModel!.response![index].address!);
                                                      lat = double.parse(value
                                                          .addressModel!
                                                          .response![index]
                                                          .latitude!);
                                                      long = double.parse(value
                                                          .addressModel!
                                                          .response![index]
                                                          .longitude!);
                                                      value.storeLocation(
                                                          lat: lat!,
                                                          lng: long!,
                                                          pageId:
                                                              SingleToneValue
                                                                  .instance
                                                                  .homePageId,
                                                          address: value
                                                              .addressModel!
                                                              .response![index]
                                                              .address!,
                                                          addressId: value
                                                              .addressModel!
                                                              .response![index]
                                                              .id!);
                                                    } else if (id ==
                                                        SingleToneValue.instance
                                                            .loginPageID) {
                                                      SingleToneValue.instance
                                                              .userAddressId =
                                                          value
                                                              .addressModel!
                                                              .response![index]
                                                              .id;
                                                      await sharedPrefClient
                                                          .setUserAddressId(
                                                              SingleToneValue
                                                                  .instance
                                                                  .userAddressId!);
                                                      SingleToneValue.instance
                                                              .currentLat =
                                                          double.parse(value
                                                              .addressModel!
                                                              .response![index]
                                                              .latitude!);
                                                      await sharedPrefClient
                                                          .setLat(value
                                                              .addressModel!
                                                              .response![index]
                                                              .latitude!);
                                                      await sharedPrefClient
                                                          .setLng(value
                                                              .addressModel!
                                                              .response![index]
                                                              .longitude!);
                                                      await sharedPrefClient
                                                          .setAddress(value
                                                              .addressModel!
                                                              .response![index]
                                                              .address!);
                                                      Get.offAll(Home());
                                                    }
                                                  },
                                                  child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: MyColors
                                                              .cardColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            height: mediaQuery
                                                                    .height *
                                                                0.09,

                                                            //  color: Get.theme.colorScheme.secondaryVariant,
                                                            child: Padding(
                                                                padding: const EdgeInsets
                                                                        .all(
                                                                    Dimens
                                                                        .size10),
                                                                child: value
                                                                            .addressModel!
                                                                            .response![
                                                                                index]
                                                                            .title ==
                                                                        'home'
                                                                    ? Image(
                                                                        image: AssetImage(
                                                                            MyImgs.iconHome),
                                                                        width:
                                                                            40,
                                                                        height:
                                                                            40,
                                                                      )
                                                                    : value.addressModel!.response![index].title ==
                                                                            'Work'
                                                                        ? Image(
                                                                            image:
                                                                                AssetImage(MyImgs.work),
                                                                            width:
                                                                                40,
                                                                            height:
                                                                                40,
                                                                          )
                                                                        : Image(
                                                                            image:
                                                                                AssetImage(MyImgs.others),
                                                                            width:
                                                                                40,
                                                                            height:
                                                                                40,
                                                                          )),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width: mediaQuery
                                                                        .width *
                                                                    0.63,
                                                                child:
                                                                    ExpandableText(
                                                                  value
                                                                          .addressModel!
                                                                          .response![
                                                                              index]
                                                                          .address
                                                                          .toString() +
                                                                      ',' +
                                                                      value
                                                                          .addressModel!
                                                                          .response![
                                                                              index]
                                                                          .postalCode
                                                                          .toString(),
                                                                  expandText:
                                                                      'show more',
                                                                  collapseText:
                                                                      'show less',
                                                                  collapseOnTextTap:
                                                                      true,
                                                                  maxLines: 2,
                                                                  linkColor:
                                                                      MyColors
                                                                          .blue50,
                                                                  style: Get
                                                                      .textTheme
                                                                      .subtitle1!
                                                                      .copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              MyColors.textVColor),
                                                                  animation:
                                                                      true,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          id ==
                                                                      SingleToneValue
                                                                          .instance
                                                                          .homePageId ||
                                                                  id ==
                                                                      SingleToneValue
                                                                          .instance
                                                                          .deliveryAddress
                                                              ? SizedBox()
                                                              : Container(
                                                                  height: mediaQuery
                                                                          .height *
                                                                      0.09,
                                                                  width: mediaQuery
                                                                          .width *
                                                                      0.1,
                                                                  //  color: Colors.cyanAccent,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              " delete id of index:${value.addressModel!.response![index].id}");
                                                                          value.onDeleteButton(
                                                                              id: value.addressModel!.response![index].id!);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              mediaQuery.height * 0.09,
                                                                          width:
                                                                              mediaQuery.width * 0.1,
                                                                          //  color: Colors.amberAccent,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(Dimens.size10),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage(MyImgs.iconDelete),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                        ],
                                                      )),
                                                ),
                                              );
                                            },
                                          )),
                                      SizedBox(
                                        height: Dimens.size20,
                                      ),
                                      CustomButton(
                                        height: 0.065,
                                        width: 0.8,
                                        text: 'Add New Location',
                                        onPressed: () {
                                          value.onButtonClick(id);
                                        },
                                        roundCorner: Dimens.size5,
                                      )
                                    ],
                                  ),
                                );
                })),
      ),
    );
  }

  onPopScope() {
    if (id == SingleToneValue.instance.saveAddressId) {
      Get.back();
    } else if (id == SingleToneValue.instance.homePageId) {
      Get.back();
      //  Get.offAll(Home());
    } else if (id == SingleToneValue.instance.loginPageID) {
    } else if (id == SingleToneValue.instance.deliveryAddress) {
      Get.off(Delivery());
    }
  }
}
