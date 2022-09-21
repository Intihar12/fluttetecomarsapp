import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:kiwkemart/data/controller/delivery_controller/delivery_controller.dart';
import 'package:kiwkemart/data/controller/schedule_delivery_controller/schedule_delivery_controller.dart';
import 'package:kiwkemart/data/model/day_modal/day_modal.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';

class ScheduledDeliveryStats extends GetView<ScheduleDeliveryController> {
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var textTheme=theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
        //  backgroundColor: MyColors.primaryColor,
          title: Text("Scheduled Delivery",style: TextStyle(
            fontSize: Dimens.size18,
          ),),
        ),
        backgroundColor: MyColors.appBackground,
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimens.size15,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Select Delivery Date',
                  style: Get.textTheme.headline4!,
                  ),
                ),
                SizedBox(height: Dimens.size15,),

                Obx(
                   () => Container(
                        height: mediaQuery.height*0.13,
                        child:controller.idDay.value==0 && controller.daylist.length==0 ? Center(child: Text("No Dates Available")): ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: Dimens.size10),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.daylist.length,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimens.size4,vertical: Dimens.size10),
                                child: InkWell(
                                  onTap: (){
                                    controller.idDay.value=index;
                                    controller.idLoop.value=index;
                                    controller.id.value=0;
                                    controller.update();
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(Dimens.size10),
                                   // elevation: 3,
                                    child: controller.daylist.length>0? Container(
                                        width: mediaQuery.width*0.15,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimens.size5),
                                            color:controller.idDay.value==index ? MyColors.primaryColor :MyColors.lightPrimary  ,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(controller.daylist[index].name!, style: TextStyle( color:MyColors.black, fontSize: Dimens.size12),),
                                            Text(controller.daylist[index].date!, style: TextStyle( color:MyColors.black, fontSize: Dimens.size12),),
                                          ],
                                        ),
                                      ):Container(),
                                  ),
                                ),
                              );
                            })
                    ),
                ),
                SizedBox(height: Dimens.size15,),
                  Container(
                   // height: mediaQuery.height*0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,
                          bottom: 10
                          ),
                          child: Text('Select Time Slot',
                            style: Get.textTheme.headline4!,
                          ),
                        ),
                        controller.obx(
                             (value)=>
                               Container(
                              height: mediaQuery.height*0.5,
                              child: controller.daylist.length==0? Center(child: Text("No Slots Available")): ListView.separated(
                                physics: BouncingScrollPhysics(),
                                separatorBuilder: (context, index) => SizedBox(height: Dimens.size10,),
                                  itemCount: value!.response![controller.idDay.value].timeslots!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: (){
                                        controller.id.value=index;
                                        controller.scheduleSlot = "${value.response![controller.idDay.value].timeslots![index].openSlotAt}-${value.response![controller.idDay.value].timeslots![index].closeSlotAt}";
                                        controller.scheduleTimeAndDate = "${value.response![controller.idDay.value].day!.date} ${controller.scheduleSlot}";
                                          controller.update();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: Dimens.size20),
                                        child: Material(
                                         // elevation: 5,
                                          child: Container(

                                            height: mediaQuery.height*0.07,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimens.size5),
                                              color:controller.id.value==index ? MyColors.primaryColor :MyColors.lightPrimary  ,
                                            ),
                                           // width: mediaQuery.width* 0.01,
                                        //    color: value.id==index ? MyColors.primaryColor: MyColors.lightPrimary,
                                            child: Center(
                                              child: Text(
                                                "${value.response![controller.idDay.value].timeslots![index].openSlotAt}-${value.response![controller.idDay.value].timeslots![index].closeSlotAt}",style: Get.textTheme.subtitle1!.copyWith(),
                                              ),

                                              )

                                            ),
                                          ),
                                        ),
                                      );

                                  },),
                            ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.size50),
                  child: CustomButton(height: mediaQuery.height*0.00008, width: mediaQuery.width,
                    text: 'Confirm', onPressed: (){
                    Get.find<DeliveryController>().scheduleDelivery = true;
                    Get.find<DeliveryController>().scheduleDeliveryDate = controller.scheduleTimeAndDate!;
                    Get.find<DeliveryController>().instantDelivery = false;
                    Get.find<DeliveryController>().update();
                    Get.back();
                    },
                    roundCorner: Dimens.size5,fontSize: Dimens.size25,
                    color: MyColors.primaryColor,),
                ),
                SizedBox(height: Dimens.size15,),
              ],
            ),
          ),

      ),
    );
  }
}
