import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ui/values/my_imgs.dart';
import '../../constants/constants.dart';
import '../../repository.dart';
import '../../shared_pref_client.dart';

class TrackingOrderController  extends GetxController{
//
String ? driverName;
String ? driverImage;
String ? estimateTime;
String ? driverPhone;
String ? driverId;
double? lat;
double? long;
String? address;
double ?driverLat;
double ?driverLng;
String ? deliveryLat;
String? deliveryLng;
String ? deliveryAddress;
double ? lat2;
double ? lng2;
Map<dynamic, dynamic> mapValue = {};

  final _repository = Repository();

  ///camer position
  late CameraPosition cameraPosition;
  ///polylines
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylinesadd = {};
  Set<Polyline> polyline = {};

  PolylinePoints polylinePoints = PolylinePoints();
  Set<Polyline> polylines = {};
final _sharedPrefClient = SharedPrefClient();
  /// set odd marker
  Set<Marker> markers = {};
  double lat1=31.582045;
  double lng1=74.329376;
  /// driver id
  // late LatLng pickLatLng;
  GoogleMapController? controller;
  final firebase = FirebaseDatabase.instance.ref().child('online_driver');


  /// latlng
  LatLng? latLng;

  void removeMarkers() {
    {
      markers.removeWhere((m) => m.markerId.value == "driver Location");
      update();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Future<void> onInit() async {
    final sharedPref = await SharedPreferences.getInstance();
  driverName=  sharedPref.getString('driver_name');
  driverImage=sharedPref.getString('driver_image');
  driverPhone=sharedPref.getString('driver_phone');
  estimateTime=sharedPref.getString('estimate_time');
  driverId=sharedPref.getString('driver_id');
  lat=sharedPref.getDouble('delivery_lat');
  long=sharedPref.getDouble('delivery_long');
  address=sharedPref.getString('delivery_address');
  deliveryLat= await _sharedPrefClient.getLat();
  deliveryLng= await _sharedPrefClient.getLng();
  deliveryAddress=await _sharedPrefClient.getAddress();
    lat2= double.parse(deliveryLat!);
    lng2=double.parse(deliveryLng!);
    getLatLngDriver();
    super.onInit();
  }

  @override
  Future<void> onReady() async {

    deliveryLat= await _sharedPrefClient.getLat();
    deliveryAddress= await _sharedPrefClient.getLng();
   lat2= double.parse(deliveryLat!);
    lng2=double.parse(deliveryLng!);
     cameraPosition = CameraPosition(target: LatLng(lat2!,lng2!), zoom: 15.0);

update();
    super.onReady();
  }

  @override
  void onClose() {
    removeMarkers();
    _repository.close();
  }

Future<void> makePhoneCall() async {
  final sharedPref = await SharedPreferences.getInstance();
  driverPhone=sharedPref.getString('driver_phone');
  final Uri launchUri = Uri(
    scheme: 'tel',
    path:driverPhone ,
  );
  await launch(launchUri.toString());
}
getLatLngDriver(){
  firebase.child(driverId.toString()).onValue.listen((event) {
    dynamic snapShot = event.snapshot.value;
    if (snapShot["lat"] != null && snapShot["long"] != null){
      driverLat=snapShot['lat'];
      driverLng=snapShot['long'];
      update();
    }
    print('Snapshot: ${event.snapshot.value}');
    print('driverlat:${driverLat}');
    print('driverlng:${driverLng}');

    update();
  });
}

Future<void> addMarkers() async {
  markers.add(Marker(
    icon: await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)),
        MyImgs.pinIcon),
    markerId: MarkerId("driver Location"),
    position: driverLat==null && driverLng==null ?
    LatLng(lat1,lng1)
        :LatLng(driverLat!,driverLng!),
    infoWindow: InfoWindow(
      title: 'Driver Location',

    ),

  ));

  update();
}

  Future<void> addMarkers1() async {
    deliveryLat= await _sharedPrefClient.getLat();
    deliveryAddress= await _sharedPrefClient.getLng();
    deliveryAddress=await _sharedPrefClient.getAddress();
    lat2= double.parse(deliveryLat!);
    lng2=double.parse(deliveryLng!);
    markers.add(Marker(
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(100, 100)),
          MyImgs.pinIcon),
      markerId: MarkerId("Delivery Location"),
      position: lat==null && long==null ?
      LatLng(lat1,lng1)
          :LatLng(lat2!,lng2!),
      infoWindow: InfoWindow(
        title: 'Delivery Address',
        snippet: '${deliveryAddress!}',
      ),

    ));
    getLatLngDriver();

    latLng=LatLng(driverLat!,driverLng!) ;
    cameraPosition=CameraPosition(target:latLng!,zoom: 15.0 );
    if(controller!=null)
      controller!.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition));

    markers.removeWhere((m) => m.markerId.value == "driver Location");

    markers.add(Marker(
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(100, 100)),
          MyImgs.pinIcon),
      markerId: MarkerId("driver Location"),
      position: driverLat==null && driverLng==null ?
      LatLng(lat1,lng1)
          :LatLng(driverLat!,driverLng!),
      infoWindow: InfoWindow(
        title: 'Driver Location',

      ),

    ));



    update();
  }

  createPolylines() async {
    // final sharedPref = await SharedPreferences.getInstance();
    // lat=sharedPref.getDouble('delivery_lat');
    // long=sharedPref.getDouble('delivery_long');
    // address=sharedPref.getString('delivery_address');
    getLatLngDriver();
    deliveryLat= await _sharedPrefClient.getLat();
    deliveryAddress= await _sharedPrefClient.getLng();
    deliveryAddress=await _sharedPrefClient.getAddress();
    lat2= double.parse(deliveryLat!);
    lng2=double.parse(deliveryLng!);
    try {

      /// Initializing PolylinePoints

      polylinePoints = PolylinePoints();

      /// Generating the list of coordinates to be used for
      /// drawing the polylines

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.mapKey, // Google Maps API Key
        PointLatLng(lat2!,lng2!),
        driverLat==null && driverLng==null?
        PointLatLng(lat1, lng1) :
        PointLatLng(driverLat!,driverLng!),
        travelMode: TravelMode.driving,
      );

      ///Adding the coordinates to the list
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }

      /// Defining an ID
      PolylineId id = PolylineId('poly');

      /// Initializing Polyline
      Polyline polyline = Polyline(
        polylineId: id,
        color:  Color.fromARGB(255, 40, 122, 198),
        points: polylineCoordinates,
        width: 5,
      );

      /// Adding the polyline to the map
      //  polylines[id] = polyline;
      polylines.add(polyline);

      update();
    }

    on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        print("No map update");
      }
      print(e);
    }
  }




  onMapCreated1(GoogleMapController controller)  async {
    // final sharedPref = await SharedPreferences.getInstance();
    // lat=sharedPref.getDouble('delivery_lat');
    // long=sharedPref.getDouble('delivery_long');
    // address=sharedPref.getString('delivery_address');
  ///  getLatLngDriver();
    deliveryLat= await _sharedPrefClient.getLat();
    deliveryAddress= await _sharedPrefClient.getLng();
    deliveryAddress=await _sharedPrefClient.getAddress();
    lat2= double.parse(deliveryLat!);
    lng2=double.parse(deliveryLng!);
    try {

      controller = (controller);
      addMarkers1();
      createPolylines();
      LatLngBounds bound;
      controller
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      bound = LatLngBounds(
        northeast: LatLng(
            lat2==null ? max(lat1,driverLat!) :
            max(lat2!, driverLat!),
           lng2==null ? max(lng1, driverLng!):
            max(lng2!, driverLng!)),
        southwest: LatLng(
            min(lat2!,driverLat!),
            min(lng2!, driverLng!)),
      );
      CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 60);

      check(u2,controller);
      update();
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        print("No se pudo obtener la ubicación.");
        // currentLocation = null;
      }
      print(e);
    }
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    c.moveCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

}