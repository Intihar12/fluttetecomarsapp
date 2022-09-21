import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/controller/common_controller/common_controller.dart';
import 'package:kiwkemart/data/model/cart_empty/cart_empty.dart';
import 'package:kiwkemart/data/model/map_search_models/id_to_latlng/id_to_latlng.dart';
import 'package:kiwkemart/data/model/map_search_models/map_autocomplete_model/map_auto_complete_model.dart';
import 'package:kiwkemart/data/model/save_store_data/save_store_data.dart';
import 'package:kiwkemart/data/model/store_location_model/store_location_model.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/values/strings.dart';
import 'package:location/location.dart' as loc;
import '../../../ui/address/address_details.dart';
import '../../../ui/address/save_adress.dart';
import '../../../ui/auth/login/login.dart';
import '../../../ui/home/home_homepage1.dart';
import '../../../ui/values/my_colors.dart';
import '../../model/cart_item_save/cart_item_save.dart';
import '../../model/favourite/favourite.dart';
import '../../model/favourite_list_empty/favourite_list_empty.dart';
import '../../repository.dart';
import '../../shared_pref_client.dart';

class LocationMapController extends GetxController  with StateMixin<dynamic>{
  AutoComplete? getAutoComplete;
  final _repository = Repository();
 CommonController commonController=Get.put(CommonController());
  IdtoLatLong? _getPlaceLatLong;
  var lat = 31.4643687.obs;
  var lng = 74.2414678.obs;
  LatLng latLng = LatLng(31.4643687, 74.2414678);
  Rx<AutoComplete>? searchPlaces=AutoComplete(status: "",predict: []).obs;

  String _currentSearch = ' ';
  Set<Marker> Markers = {};
  Completer<GoogleMapController> mapCompleter = Completer();

  /// stream of position

  var address = 'Getting Address..'.obs;
  var customAddress = 'Getting Address..'.obs;
  var street = 'Getting street..'.obs;
  var postCode = 'Getting postCode..'.obs;
  var city = 'Getting city..'.obs;
  var name = 'Getting name..'.obs;
  var customLocation = 'Getting Location..'.obs;

  bool noInternet = false;
  var isLoading = true.obs;
  var value = true.obs;
  late String addressOff;
  var result=true.obs;
  CartEmpty? cartEmpty;
  FavouriteListEmpty ? emptyFav;
  GoogleMapController? mapController;
  String mainText = ' ';
  String secondaryText = ' ';
  Completer<GoogleMapController> controller = Completer();
  final locationTextController = TextEditingController();

  final _sharedPrefClient = SharedPrefClient();

  @override
  Future<void> onInit() async {
    String? lat1 = await _sharedPrefClient.getLat();
    String? lng1 = await _sharedPrefClient.getLng();
    super.onInit();
    await checkLocation().then((value) async {
      if (value) {
        if(lat1 == 'lat' && lng1 == 'lng'){
          await getCurrentLocation()
              .then((value) =>
              _pickLocation().then((value) async {
                {
                  await getAddress().then((value) {
                    locationTextController.text = value;
                    SingleToneValue.instance.currentAddress=value;
                    update();
                  });
                  update();
                }
              }
              ));
        }
        else{
          lat.value=double.parse(lat1.toString());
          lng.value=double.parse(lng1.toString());
          SingleToneValue.instance.currentLat=lat.value;
          SingleToneValue.instance.currentLng=lng.value;
          await  getCustomLocation(lat.value, lng.value);
          _pickLocation();
          // await getAddress().then((value) => {
          // customLocation.value=value,
          //   _pickLocation()
          // });
          update();
          // _pickLocation().then((value) async {
          //   {
          //     await getAddress().then((value) async {
          //       locationTextController.text = value;
          //       SingleToneValue.instance.currentAddress=value;
          //
          //
          //       update();
          //     });
          //     update();
          //   }
          // }
          // );



        }

      }
    });
    update();
  }

  onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    SingleToneValue.instance.currentLat = lat.value;
    SingleToneValue.instance.currentLng = lng.value;
  //  await getCurrentLocation();

  }

  Future getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat.value = position.latitude;
      lng.value = position.longitude;
      SingleToneValue.instance.currentLat = lat.value;
      SingleToneValue.instance.currentLng = lng.value;
      await _sharedPrefClient.setLat(lat.value.toString());
      await _sharedPrefClient.setLng(lng.value.toString());
      print("current lat: ${lat.value}");
      print("current lng: ${lng.value}");
      getCustomLocation(SingleToneValue.instance.currentLat,
          SingleToneValue.instance.currentLng);

      update();
    } catch (e) {
      return LatLng(31.427789, 74.239181);
    }
  }

  /// location permission of the location
  Future<bool> checkLocation() async {
    try {
      final location = loc.Location();
      if (await location.serviceEnabled()) {
        final perm = await location.hasPermission();
        if (perm == loc.PermissionStatus.granted ||
            perm == loc.PermissionStatus.grantedLimited) {
          Strings.locationPermission = 'granted';
          return true;
        } else if (perm == loc.PermissionStatus.denied) {
          final perm = await location.requestPermission();
          if (perm == loc.PermissionStatus.granted ||
              perm == loc.PermissionStatus.grantedLimited) {
            Strings.locationPermission = 'granted';
            return true;
          } else if (perm == loc.PermissionStatus.denied) {
            Strings.locationPermission = 'denied';
            return false;
          } else if (perm == loc.PermissionStatus.deniedForever) {
            Strings.locationPermission = 'deniedForever';
            return false;
          } else {
            return false;
          }
        } else if (perm == loc.PermissionStatus.deniedForever) {
          Strings.locationPermission = 'deniedForever';
          return false;
        } else {
          return false;
        }
      } else {
        final service = await location.requestService();
        if (service) {
          final perm = await location.hasPermission();
          if (perm == loc.PermissionStatus.granted ||
              perm == loc.PermissionStatus.grantedLimited) {
            Strings.locationPermission = 'granted';
            return true;
          } else if (perm == loc.PermissionStatus.denied) {
            final perm = await location.requestPermission();
            if (perm == loc.PermissionStatus.granted ||
                perm == loc.PermissionStatus.grantedLimited) {
              Strings.locationPermission = 'granted';
              return true;
            } else if (perm == loc.PermissionStatus.denied) {
              Strings.locationPermission = 'denied';
              return false;
            } else if (perm == loc.PermissionStatus.deniedForever) {
              Strings.locationPermission = 'deniedForever';
              return false;
            } else {
              return false;
            }
          } else if (perm == loc.PermissionStatus.deniedForever) {
            Strings.locationPermission = 'deniedForever';
            return false;
          } else {
            return false;
          }
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }
  Future<String> getAddress() async {
    try {
      var addresses = await _repository.fetchAddress(
          latitude: latLng.latitude, longitude: latLng.longitude);
      var first = addresses.results.first;

      return first.formattedAddress;
    } catch (e) {
      return 'UnKnown';
    }
  }
  /// function of  convert into the latlng to the address

  getCustomLocation(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      customLocation.value =
          "${placemarks[0].street}, ${' '}${placemarks[0].subLocality}, ${' '}${placemarks[0].locality}, ${' '}${placemarks[0].administrativeArea}, ${' '}${placemarks[0].country}";
      SingleToneValue.instance.postalCode = placemarks[0].postalCode!;
      SingleToneValue.instance.state = placemarks[0].administrativeArea!;
      SingleToneValue.instance.currentAddress = customLocation.value;
      SingleToneValue.instance.city = placemarks[0].locality!;
    //  await _sharedPrefClient.setAddress(customLocation.value);
      locationTextController.text=customLocation.value;
    //  SingleToneValue.instance.currentAddress=customLocation.value;
      print("Address: ${customLocation.value}");
      print("Address List: ${placemarks[0]}");
      update();
      print('Singletone Address:${SingleToneValue.instance.currentAddress}');
    } catch (e) {
      print(e.toString());
    }
  }

  String prr = '   ';

  void callApi(String str) async {
    _currentSearch = str;
    if (_currentSearch != prr) {
      searchPlaces!.value = (await getPlaces(_currentSearch))!;

      prr = _currentSearch;
      update();
    }
  }

  Future callApiLatLong(String placeId) async {
    _getPlaceLatLong = await getPlacesLatLong(placeId);
    lat.value = _getPlaceLatLong!.result.geometry.locationData.lat;
    lng.value = _getPlaceLatLong!.result.geometry.locationData.lng;
    await _pickLocation();
  }

  Future<void> _pickLocation() async {
    mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat.value, lng.value), zoom: 16.151926040649414)));
  }

  void updateText(String str) {
    if (str.isEmpty) {
      callApi(' ');
    }
    callApi(str);
  }

  /// get places of the latlng
  Future<IdtoLatLong> getPlacesLatLong(String str) async {
    final response = await _repository.getPlacesLatLong(
      str,
    );
    return response;
  }

  /// map search through the places google places api
  Future<AutoComplete?> getPlaces(String str) async {
    getAutoComplete = await _repository.getPlacesOnMap(str);
    return getAutoComplete;
  }
/// near store location api call function
  onLatLngPosition(double lat, double lng) async {
     bool okStatus = await _repository.onLatLngToStore(lat.toString(), lng.toString());
    if (okStatus==true) {

      Constants.storeLatitude = lat.toString();
      Constants.storeLongitude = lng.toString();
      Constants.storeAddress = customAddress.value.toString();
      update();
      return result.value=true;

    } else {
     Get.snackbar("Location", "Store Location Not Exit");
     update();
      return result.value=false;
    }

  }

  storeLocation(double lat, double lng,int pageId) async {
SaveStoreData storeData=await _sharedPrefClient.getStoreData();
    await _repository.storeLocation(latitude: lat.toString(), longitude: lng.toString())
        .then((value) async {
      change( value, status: RxStatus.success());
      if (value is StoreLocation) {
        if (value.responseCode == '1') {
          if(value.response!.id==storeData.id){
            SingleToneValue.instance.storeIdSave=value.response!.id;
            if(pageId==SingleToneValue.instance.loginPageID){
              update();
              result.value=true;
              // await _sharedPrefClient.setLat(SingleToneValue.instance.currentLat.toString());
              // await _sharedPrefClient.setLng(SingleToneValue.instance.currentLng.toString());
              // await _sharedPrefClient.setAddress(customLocation.value);
              Get.off(AddressDetails(
                pageId:SingleToneValue.instance.loginPageID,
              ));
            }
            else if(pageId==SingleToneValue.instance.homePageId){
              update();
              result.value=true;
              // await _sharedPrefClient.setLat(SingleToneValue.instance.currentLat.toString());
              // await _sharedPrefClient.setLng(SingleToneValue.instance.currentLng.toString());
              // await _sharedPrefClient.setAddress(customLocation.value);
              Get.off(AddressDetails(
                pageId:SingleToneValue.instance.homePageId,
              ));
            }
            else if (pageId==SingleToneValue.instance.deliveryAddress){
              update();
              result.value=true;
              // await _sharedPrefClient.setLat(SingleToneValue.instance.currentLat.toString());
              // await _sharedPrefClient.setLng(SingleToneValue.instance.currentLng.toString());
              // await _sharedPrefClient.setAddress(customLocation.value);
              Get.off(AddressDetails(
                pageId:SingleToneValue.instance.deliveryAddress,
              ));
            }
            else if(pageId==SingleToneValue.instance.saveAddressId){
              update();
              result.value=true;
              // await _sharedPrefClient.setLat(SingleToneValue.instance.currentLat.toString());
              // await _sharedPrefClient.setLng(SingleToneValue.instance.currentLng.toString());
              // await _sharedPrefClient.setAddress(customLocation.value);
              Get.off(AddressDetails(
                pageId:SingleToneValue.instance.saveAddressId,
              ));
            }
            // update();
            //  result.value=true;
          }
         else{
         Get.defaultDialog(
           barrierDismissible: false,
              title: "your store address changed ",
              middleText: "Are you sure cart is empty ",
              onConfirm: () async {

                  final String? favString = await _sharedPrefClient.getFavItem();

                  final List<FavouriteItem> favItemSave = FavouriteItem.decode(favString!);
 if(Constants.cartCount.value==0 ){
   if(pageId==SingleToneValue.instance.loginPageID){
     commonController.removeData();
     result.value=true;
     update();
     Get.off(AddressDetails(
       pageId:SingleToneValue.instance.loginPageID,
     ));
   }
   else if(pageId==SingleToneValue.instance.homePageId){
     commonController.removeData();
     result.value=true;
     update();
     Get.off(AddressDetails(
       pageId:SingleToneValue.instance.homePageId,
     ));
   }
   else if (pageId==SingleToneValue.instance.deliveryAddress){
     commonController.removeData();
     result.value=true;
     update();
     Get.off(AddressDetails(
       pageId:SingleToneValue.instance.deliveryAddress,
     ));
   }
   else if(pageId==SingleToneValue.instance.saveAddressId){
     commonController.removeData();
     result.value=true;
     update();
     Get.off(AddressDetails(
       pageId:SingleToneValue.instance.saveAddressId,
     ));
   }
   // await _sharedPrefClient.setLat(SingleToneValue.instance.currentLat.toString());
   // await _sharedPrefClient.setLng(SingleToneValue.instance.currentLng.toString());
   // await _sharedPrefClient.setAddress(customLocation.value);
  // commonController.removeData();
  //   result.value=true;
  //   update();
 // Get.back();

}
else{
   if(pageId==SingleToneValue.instance.loginPageID){
  //   commonController. emptyCart();
   //  commonController. emptyFavourite();
    // commonController.removeData();
     result.value=true;
     update();
     Get.off(AddressDetails(
       pageId:SingleToneValue.instance.loginPageID,
     ));
   }
   else if(pageId==SingleToneValue.instance.homePageId){

     commonController. emptyCart();
     commonController. emptyFavourite();
     commonController.removeData();
     result.value=true;
     update();
     Get.off(AddressDetails(
       pageId:SingleToneValue.instance.homePageId,
     ));
   }
   else if (pageId==SingleToneValue.instance.deliveryAddress){

     commonController. emptyCart();
    commonController. emptyFavourite();
     commonController.removeData();
     result.value=true;
     update();
     Get.off(AddressDetails(
       pageId:SingleToneValue.instance.deliveryAddress,
     ));
   }
   else if(pageId==SingleToneValue.instance.saveAddressId){
    // commonController. emptyCart();
     //commonController. emptyFavourite();
   //  commonController.removeData();
     result.value=true;
     update();
     Get.off(AddressDetails(
       pageId:SingleToneValue.instance.saveAddressId,
     ));
   }
  // await _sharedPrefClient.setLat(SingleToneValue.instance.currentLat.toString());
  // await _sharedPrefClient.setLng(SingleToneValue.instance.currentLng.toString());
  // await _sharedPrefClient.setAddress(customLocation.value);

 // commonController. emptyCart();
 // commonController. emptyFavourite();
 //  commonController.removeData();
 //  result.value=true;
 //  update();
 //Get.back();

}
                //  result.value=true;


              },
              onCancel: (){
                result.value=true;

              },
              textConfirm: "Ok",
              textCancel: 'Cancel',

            );
            Get.snackbar("Location", "Store Location changed");
            result.value=false;

          }

        }
        else {
          if (value.responseCode == '0') {

            Get.snackbar("Location", "Store Location Not Exit");
            update();
             result.value=false;
          }
        }
      }
    }, onError: (error) {
      change(value, status: RxStatus.error(error.toString()));
      print("value Erorr $error");
      Get.snackbar("Error ", 'SomeThing Went Wrong');
    });
  }

  /// button choose this address

chooseButton(int id ) async {

  if (id == SingleToneValue.instance.loginPageID) {
    String? lat1 = await _sharedPrefClient.getLat();
    String? lng1 = await _sharedPrefClient.getLng();
    if(lat1 == 'lat' && lng1 == 'lng'){
      Get.off(AddressDetails(
        pageId:SingleToneValue.instance.loginPageID,
      ));
    }
    else{
      storeLocation(SingleToneValue.instance.currentLat,
          SingleToneValue.instance.currentLng,
          SingleToneValue.instance.loginPageID
      );
    }
    // await sharedPrefClient.setLat(
    //     SingleToneValue.instance.currentLat.toString());
    // await sharedPrefClient.setLng(
    //     SingleToneValue.instance.currentLng.toString());
    // await sharedPrefClient.setAddress(locationController.customLocation.value);

    // Get.to(AddressDetails(
    //   pageId:SingleToneValue.instance.loginPageID,
    // ));

  }
  else if(id==SingleToneValue.instance.guestUserId){
    await _sharedPrefClient.setLat(
        SingleToneValue.instance.currentLat.toString());
    await _sharedPrefClient.setLng(
        SingleToneValue.instance.currentLng.toString());
    await _sharedPrefClient.setAddress(customLocation.value);
    Get.offAll(Home());
  }
  else if(id== SingleToneValue.instance.homePageId){


    storeLocation(
        SingleToneValue.instance.currentLat,
        SingleToneValue.instance.currentLng,
        SingleToneValue.instance.homePageId
    );

      // await _sharedPrefClient.setLat(
      //     SingleToneValue.instance.currentLat.toString());
      // await _sharedPrefClient.setLng(
      //     SingleToneValue.instance.currentLng.toString());
      // await _sharedPrefClient.setAddress(customLocation.value);
      //
      // Get.to(AddressDetails(
      //   pageId:SingleToneValue.instance.homePageId,
      // ));

  }
  else if(id==SingleToneValue.instance.deliveryAddress){

    storeLocation(
        SingleToneValue.instance.currentLat,
        SingleToneValue.instance.currentLng,
      SingleToneValue.instance.deliveryAddress

    );
    // Get.off(AddressDetails(
    //   pageId:SingleToneValue.instance.deliveryAddress ,
    // ));
  }
  else {

    storeLocation(
        SingleToneValue.instance.currentLat,
        SingleToneValue.instance.currentLng,
      SingleToneValue.instance.saveAddressId

    );
    // Get.off(AddressDetails(
    //   pageId: SingleToneValue.instance.saveAddressId,
    // ));
  }
}

/// on pop scope button

onPopScopeButton( int id) async {


  if (id == SingleToneValue.instance.loginPageID)
  {
    await _sharedPrefClient.setLat(
      SingleToneValue.instance.currentLat.toString());
  await _sharedPrefClient.setLng(
      SingleToneValue.instance.currentLng.toString());
  await _sharedPrefClient.setAddress(customLocation.value);
    //  Get.offAll(Home());
  }

  else if(id== SingleToneValue.instance.homePageId)
  {
    await _sharedPrefClient.setLat(
        SingleToneValue.instance.currentLat.toString());
    await _sharedPrefClient.setLng(
        SingleToneValue.instance.currentLng.toString());
    await _sharedPrefClient.setAddress(customLocation.value);

    Get.off(SaveAddress(SingleToneValue.instance.homePageId));
  }
  else if(id== SingleToneValue.instance.saveAddressId){
  //  Get.back();
    Get.off(SaveAddress(SingleToneValue.instance.saveAddressId));
  }
  else if(id==SingleToneValue.instance.deliveryAddress){
    Get.off(SaveAddress(SingleToneValue.instance.deliveryAddress));
   // Get.back();
  }
  else {
    Get.offAll(Login());
  }

}


}
