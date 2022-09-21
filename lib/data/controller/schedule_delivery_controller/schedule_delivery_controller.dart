
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/cart_model/cart_model.dart';
import 'package:kiwkemart/data/model/day_modal/day_modal.dart';
import 'package:kiwkemart/data/model/save_store_data/save_store_data.dart';
import 'package:kiwkemart/data/model/show_slots_model/show_slots_model.dart' as slots;
import 'package:kiwkemart/data/repository.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

import '../../shared_pref_client.dart';

class ScheduleDeliveryController extends GetxController with StateMixin<slots.ShowSlotsModel>{
 Repository _repository = Repository();
  RxInt id=0.obs;
  RxInt idLoop=0.obs;
  RxInt idDay=0.obs;
 final _sharedPrefClient = SharedPrefClient();

 List<slots.Day> daylist = <slots.Day>[].obs;

  String? scheduleTimeAndDate;
  String? scheduleSlot;



  @override
  void onInit() {
    showStoreSlots();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }

  showStoreSlots() async {

   SaveStoreData storeData =  await _sharedPrefClient.getStoreData();

    _repository.showRetailersTimeSlots(storeData.id!).then((value) async {
      if(value.responseCode == "1"){
        if(value.response!.length>0 &&value.response![0].timeslots!.length>0){
          scheduleSlot = "${value.response![0].timeslots![0].openSlotAt}-${value.response![0].timeslots![0].closeSlotAt}";
          scheduleTimeAndDate = "${value.response![0].day!.date} $scheduleSlot";
        }
        await populateDayList(value);

        change(value,status: RxStatus.success());
      }
    },onError: (error){
      Get.snackbar("Error", "Something went wrong");
    });
  }

 Future populateDayList(slots.ShowSlotsModel model)async{
    for(int i=0;i<model.response!.length;i++){
      daylist.add(model.response![i].day!);
    }
 }

}