


import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/auth_controller/auth_controller.dart';
import 'package:kiwkemart/data/controller/homepage_controller/homepage_controller.dart';
import 'package:kiwkemart/data/controller/schedule_delivery_controller/schedule_delivery_controller.dart';
import 'package:kiwkemart/data/controller/sub_category_controller/sub_category_controller.dart';
import 'package:kiwkemart/data/model/home_data/home_data.dart';

class DataDependency  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(),fenix: true);
   // Get.lazyPut(() => HomeController(),fenix: true);
    Get.lazyPut(() => ScheduleDeliveryController(),fenix: true);

  }


}