import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwkemart/data/model/map_search_models/fetch_address_model/fetch_address_model.dart';
import 'package:kiwkemart/data/model/map_search_models/geomery_latlng/geomatry_latlng.dart';
import 'package:kiwkemart/data/model/map_search_models/id_to_latlng/id_to_latlng.dart';
import 'package:kiwkemart/data/model/map_search_models/location_model/location_model.dart';
import 'package:kiwkemart/data/model/map_search_models/map_autocomplete_model/map_auto_complete_model.dart';
import 'package:kiwkemart/data/model/map_search_models/map_search/map_search.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';
import 'package:kiwkemart/ui/values/strings.dart';
import 'package:rxdart/rxdart.dart';
import '../../repository.dart';
import 'package:location/location.dart' as loc;
import '../../shared_pref_client.dart';


class LocationController extends GetxController {
  final _repository = Repository();
  final sharedPrefClient = SharedPrefClient();
  double minExtent = 0.2;
  double maxExtent = 0.9;
  late double initialExtent;
  late BuildContext draggableSheetContext;
  bool isExpanded = false;
  int flag = 0;

  /// form validation variable declare
  final GlobalKey<FormState> postFormKey = GlobalKey<FormState>();
  late TextEditingController postCodeController = TextEditingController();
  var postCD = '';
  AutoComplete? autoComplete;
  ///

  Position? currentPosition;
  String? currentAddress =
      'Sigi Technologies, Sher Ali Road, Kibria Town Lahore';
  LatLng latLng = LatLng(31.4643687, 74.2414678);
  LatLng moveLng = LatLng(31.31, 31.31);
  CameraPosition kInitialPosition = CameraPosition(
    target: LatLng(31.4643687, 74.2414678),
    zoom: 14,
    bearing: 30,
  );

  final Geolocator geoLocator = Geolocator();

  Completer<GoogleMapController> mapCompleter = Completer();
  late bool permission;

  @override
  void onInit() async {
    postCodeController.text = currentAddress!;
    super.onInit();
    initialExtent = minExtent;
    await checkLocation().then((value) async {
      if (value) {
        await getCurrentLocation()
            .then((value) => animateCamera(value).then((value) async {
                  await getAddress().then((value) {
                    postCodeController.text = value;
                    // currentAddress = value;
                    update();
                  });
                }));
      }
    });

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // streamSubscription.cancel();
    _repository.close();
  }

  @override
  void dispose() {
    // streamSubscription.cancel();
    super.dispose();
  }

  onCameraMoveUpdate() async {
    moveLng = latLng;
    printInfo(info: 'YGJHGJHGJHGH' + latLng.toString());
    await animateCamera(latLng).then((value) async {
      await getAddress().then((value) {
        currentAddress = value;
        postCodeController.text = value;
        update();
      });
    });
  }

  Future<bool> animateCamera(LatLng latLng) async {
    try {
      final GoogleMapController mapController = await mapCompleter.future;
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 16.151926040649414)));
      return true;
    } catch (e) {
      return false;
    }
  }

  /// current location on the map function
  Future<LatLng> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      return LatLng(31.427789, 74.239181);
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

  /// form validation fuction
  ///
  String? validatePostCode(String value) {
    if (value.isEmpty) {
      return "Please Enter the PostCode";
    }
    return null;
  }



  sheetDrag(double value) {
    if (value > 4.5) {
      isExpanded = true;
      printInfo(info: 'GHJHGJH' + "${value}");
      update();
    }
    if (value < 4.5) {
      isExpanded = false;
      printInfo(info: 'GHJHGJH' + "${value}");
      update();
    }
    printInfo(info: 'GHJHGJH' + "${value}");
  }



  getPlaces(String str) async {
    printInfo(info: 'HGJGJGJ'+str);
    if(str.isEmpty || str == '' || str.length == 0){
      autoComplete = null;
      update();
    }else{
      try{
        autoComplete = await _repository.getPlacesOnMap(str);
        update();
      }catch(e){
        autoComplete = null;
        update();
      }

    }
  }

  IdtoLatLong? idtoLatLong;
  Future<IdtoLatLong> getPlacesLatLong(String placeId) async {
    return await _repository.getPlacesLatLong(
      placeId,
    );
  }
}
