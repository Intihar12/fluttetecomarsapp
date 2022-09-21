

import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/user_save_data_model/user_save_data_model.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared_pref_client.dart';




class FirebaseNotifications{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static String? deviceToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _sharedPrefClient = SharedPrefClient();
  UserDataSaveModel? model;
  static FirebaseNotifications get instance => FirebaseNotifications();

  final firebaseCloudvapidKey =
      "AAAAFMtqPwk:APA91bGXUUoTzYmiHqjpDRSC2mUpP6n8qRM7tAY0rsZJQJgzamcXCbJIvDn348iCAeJobuj6EU0hRDDdBkv_9mR2V8Gdd4mYvi5C_5ZA8gZKNfvaRSfpJlx_lJgw7GeKf9DZm8p14wt7";

  Future<String?> getDeviceToken() async {

    await  FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) {
        deviceToken = token;
        SingleToneValue.instance.deviceToken=deviceToken;
      }
    }).catchError((onError) {
      print("the error is ${onError}");
    });
    return deviceToken;
  }


  Future initLocalNotification() async {
    model = await _sharedPrefClient.getUser();
    await _firebaseMessaging
        .getToken(vapidKey: firebaseCloudvapidKey)
        .then((val) async {
      deviceToken = val!;

      print('FCMTOKEN ${val.toString()}');
    });

    if (Platform.isIOS) {
      // set iOS Local notification.
      var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    } else {
      var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: _selectNotification);
    }
  }



  Future _selectNotification(String? payload) async {}

  Future _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {

    print('Handling a background message $body');
  }

  Future generateNotifications() async {
    try {
      NotificationSettings settings =
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
        if(message.notification!.title=='Order picked') {
          final sharedPref = await SharedPreferences.getInstance();

          sharedPref.setString('driver_name',message.data['name']);
          sharedPref.setString('driver_image',message.data['image']);
          sharedPref.setString('driver_phone',message.data['phone']);
          sharedPref.setString('driver_id',message.data['id']);
          sharedPref.setString('driver_device_token',message.data['device_token']);
          sharedPref.setString('estimate_time',message.data['esttime']);
          sharedPref.setDouble('distance_off',double.parse(message.data['distance']));
          sharedPref.setString('delivery_address',message.data['delivery_address']);
          sharedPref.setDouble('delivery_lat',double.parse(message.data['delivery_lat']));
          sharedPref.setDouble('delivery_long',double.parse(message.data['delivery_long']));


        }

        else if(message.notification!.title=='Order completed'){
          final sharedPref = await SharedPreferences.getInstance();
          sharedPref.remove('driver_name');
          sharedPref.remove('driver_image');
          sharedPref.remove('driver_phone');
          sharedPref.remove('driver_id');
          sharedPref.remove('driver_device_token');
          sharedPref.remove('estimate_time');
          sharedPref.remove('distance_off');
          sharedPref.remove('delivery_lat');
          sharedPref.remove('delivery_long');
          sharedPref.remove('delivery_address');

        }
        else if(message.notification!.title=='chat messages'){

        }

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification!.android;


        print('Message title: ${notification!.title}');

        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

        const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          // description
          importance: Importance.max,
        );
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: 'launch_background',
                ),
                iOS: IOSNotificationDetails(
                  presentSound: true,
                  presentAlert: true,
                )
            ),
          );
        }
        void pushShowNotification(int code, String title, String message) {
          _flutterLocalNotificationsPlugin.show(
            code,
            title,
            message,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,

                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: 'launch_background',
                ),
                iOS: IOSNotificationDetails(
                  presentSound: true,
                  presentAlert: true,
                )
            ),


          );
        }

      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('app is open');
        // if(message.notification!.title=='chat messages'){
        //
        //   Get.to(ChatScreen(requestId: Singleton.instance.req_id!, theirName:model!.userName! ));
        // }
        //
        //
        //
      });
    } catch (e) {
      print(e.toString());
    }
  }
}