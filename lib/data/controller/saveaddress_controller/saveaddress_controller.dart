import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/common_controller/common_controller.dart';
import 'package:kiwkemart/data/model/address_models/get_address_model.dart';
import 'package:kiwkemart/data/model/address_type_model/address_type_model.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/address/save_adress.dart';
import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/progress_bar.dart';

import '../../../ui/delivery/delivery.dart';
import '../../../ui/home/home_homepage1.dart';
import '../../constants/constants.dart';
import '../../model/cart_item_save/cart_item_save.dart';
import '../../model/favourite/favourite.dart';
import '../../model/save_store_data/save_store_data.dart';
import '../../model/store_location_model/store_location_model.dart';
import '../../repository.dart';
import '../../shared_pref_client.dart';

class SaveAddressController extends GetxController with StateMixin<dynamic> {
  final _repo = Repository();

  CommonController commonController= Get.put(CommonController());

  final _sharedPrefClient = SharedPrefClient();
  bool noInternet = false;
  GetAddressModel? addressModel;
  var isLoading = true.obs;

/// store Location change and empth cart and fav list


  storeLocation(
  {
    required double lat,
    required double lng,
    required int pageId,
    required String address,
    required int addressId
}
      ) async {
    SaveStoreData storeData=await _sharedPrefClient.getStoreData();
    await _repo.storeLocation(latitude: lat.toString(), longitude: lng.toString())
        .then((value) async {
      change( value, status: RxStatus.success());
      if (value is StoreLocation) {
        if (value.responseCode == '1') {
          if(value.response!.id==storeData.id){
            SingleToneValue.instance.storeIdSave=value.response!.id;

            if(pageId==SingleToneValue.instance.homePageId){
              await _sharedPrefClient.setLat(lat.toString());
                await _sharedPrefClient.setLng(lng.toString());
                 await _sharedPrefClient.setAddress(address);
              await _sharedPrefClient.setUserAddressId(addressId);
              update();
              Get.offAll(Home());
            }
            else if (pageId== SingleToneValue.instance.deliveryAddress){
              Get.off(
                      Delivery(
                        lat: lat.toString() ,
                        lng:  lng.toString() ,
                        address: SingleToneValue.instance.deliveryScreenAddress +" "+
                            SingleToneValue.instance.deliveryScreenPostalCode,

                      )

                  );
              update();
            }
          }
          else{
            Get.defaultDialog(
              barrierDismissible: false,
              title: "your store address changed ",
              middleText: "Are you sure cart is empty ",
              onConfirm: () async {
                if(Constants.cartCount.value==0 ){
                  commonController.removeData();
                  if(pageId==SingleToneValue.instance.homePageId){

                    await _sharedPrefClient.setLat(lat.toString());
                    await _sharedPrefClient.setLng(lng.toString());
                    await _sharedPrefClient.setAddress(address);
                    await _sharedPrefClient.setUserAddressId(addressId);
                    update();
                    Get.snackbar("Location", "Store Location changed");
                    Get.offAll(Home());
                  }
                  else if (pageId== SingleToneValue.instance.deliveryAddress){
                    await _sharedPrefClient.setLat(lat.toString());
                    await _sharedPrefClient.setLng(lng.toString());
                    await _sharedPrefClient.setAddress(address);
                    await _sharedPrefClient.setUserAddressId(addressId);
                    update();
                    // await _sharedPrefClient.setUserAddressId(SingleToneValue.instance.userAddressId!);
                    // //  SingleToneValue.instance.currentLat=double.parse(value.addressModel!.response![index].latitude!);
                    // await _sharedPrefClient.setLat(SingleToneValue.instance.deliveryLat);
                    // await _sharedPrefClient.setLng(SingleToneValue.instance.deliveryLng);
                    // await _sharedPrefClient.setAddress(SingleToneValue.instance.deliveryScreenAddress+SingleToneValue.instance.deliveryScreenPostalCode);
                    Get.offAll(Home());
                    // Get.to(
                    //     Delivery(
                    //       lat: lat.toString() ,
                    //       lng:  lng.toString() ,
                    //       address: SingleToneValue.instance.deliveryScreenAddress +" "+
                    //           SingleToneValue.instance.deliveryScreenPostalCode,
                    //
                    //     )
                    //
                    // );
                  }

                }
                else{

                  commonController.emptyCart();
                  commonController.emptyFavourite();
                  commonController.removeData();
                  update();
                  Get.snackbar("Location", "Store Location changed");
                if(pageId==SingleToneValue.instance.homePageId){
                  await _sharedPrefClient.setLat(lat.toString());
                  await _sharedPrefClient.setLng(lng.toString());
                  await _sharedPrefClient.setAddress(address);
                  await _sharedPrefClient.setUserAddressId(addressId);
                  update();
                  Get.snackbar("Location", "Store Location changed");
                  Get.offAll(Home());
                }
                else if (pageId== SingleToneValue.instance.deliveryAddress){
                  await _sharedPrefClient.setLat(lat.toString());
                  await _sharedPrefClient.setLng(lng.toString());
                  await _sharedPrefClient.setAddress(address);
                  await _sharedPrefClient.setUserAddressId(addressId);
                  update();
                  Get.snackbar("Location", "Store Location changed");
                  // await _sharedPrefClient.setUserAddressId(SingleToneValue.instance.userAddressId!);
                  // await _sharedPrefClient.setLat(SingleToneValue.instance.deliveryLat);
                  // await _sharedPrefClient.setLng(SingleToneValue.instance.deliveryLng);
                  // await _sharedPrefClient.setAddress(SingleToneValue.instance.deliveryScreenAddress+SingleToneValue.instance.deliveryScreenPostalCode);
                  Get.offAll(Home());

                }
                }



              },
              onCancel: (){


              },
              textConfirm: "Ok",
              textCancel: 'Cancel',

            );



          }

        }
        else {
          if (value.responseCode == '0') {

            Get.snackbar("Location", "Store Location Not Exit");
            update();

          }
        }
      }
    }, onError: (error) {
      change(value, status: RxStatus.error(error.toString()));
      print("value Erorr $error");
      Get.snackbar("Error ", 'SomeThing Went Wrong');
    });
  }




  onButtonClick(int id) {
    if(id==SingleToneValue.instance.saveAddressId)
      {
        Get.to(
          MapScreen(
            id: SingleToneValue.instance.saveAddressId,
          ),
        );
      }
    else if(id==4){
      Get.off(
        MapScreen(
          id: SingleToneValue.instance.deliveryAddress,
        ),
      );
    }

    else if(id== SingleToneValue.instance.homePageId){
      Get.off(
        MapScreen(
          id: SingleToneValue.instance.homePageId,
        ),
      );
    }
    else if(id==SingleToneValue.instance.loginPageID){
      Get.to(
        MapScreen(
          id: SingleToneValue.instance.loginPageID,
        ),
      );
    }
  }

  onDeleteButton({required int id}) async {
    await removeAddress(id).whenComplete(() async => await getAddressList());
  }

  getAddressList() async {
    try {
      isLoading.value = true;
      addressModel = await _repo.getAddressList();
      update();
      isLoading.value = false;
      if (noInternet) {
        noInternet = false;
      }
      update();
    } catch (e) {
      if (e.toString() == 'Exception: No Internet') {
        isLoading.value = false;
        noInternet = true;
        update();
      } else {
        isLoading.value = false;
        noInternet = false;
        update();
        Get.snackbar("Save Address", e.toString().replaceAll('Exception:', ''));
      }
    }
  }

  removeAddress(int id) async {
    try {
      isLoading.value = true;
      update();
      addressModel = await _repo.removeAddress(id: id);
      isLoading.value = false;
      if (noInternet) {
        noInternet = false;
      }
      update();
    } catch (e) {
      if (e.toString() == 'Exception: No Internet') {
        isLoading.value = false;
        noInternet = true;
        update();
      } else {
        isLoading.value = false;
        noInternet = false;
        update();
        Get.snackbar("Save Address", e.toString().replaceAll('Exception:', ''));
      }
    }
  }

  ScrollController controller = ScrollController();
  late int listLength;

  Future<void> onInit() async {
    await getAddressList();
    super.onInit();
  }
}
