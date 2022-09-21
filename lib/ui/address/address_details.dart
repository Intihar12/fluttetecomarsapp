import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/add_address_detail_controller/address_details_controller.dart';
import 'package:kiwkemart/data/model/address_type_model/address_type_model.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/values/strings.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/custom_textfield.dart';

import '../../data/controller/saveaddress_controller/saveaddress_controller.dart';

class AddressDetails extends StatelessWidget {
  int? pageId;

  AddressDetails({this.pageId});

  final AddressDetailController controller = Get.put(AddressDetailController());
 // final SaveAddressController controller1 = Get.put(SaveAddressController());
  int id = 0;
  String text = 'home';

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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                  onPopScope();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: Dimens.size25,
                    color: MyColors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Dimens.size100),
                  child: Text(Strings.addAddress),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimens.size12),
              child: Form(
                key: controller.saveAddressFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Strings.locationTag,
                        style: textTheme.bodyText1!
                            .copyWith(fontSize: Dimens.size18)),
                    SizedBox(
                      height: Dimens.size5,
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.14,
                      width: mediaQuery.width * 1.0,
                      child: GetBuilder<AddressDetailController>(
                        builder: (value) => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.typeData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      id = index;
                                      controller.update();
                                      text = value.typeData[index].text;
                                    },
                                    child: AddressType(
                                      image: value.typeData[index].image,
                                      text: value.typeData[index].text,
                                      color: id == index
                                          ? MyColors.yellow
                                          : MyColors.white,
                                    ),
                                  ));
                            }),
                      ),
                    ),
                    SizedBox(
                      height: Dimens.size15,
                    ),
                    Text(Strings.streetAddress,
                        style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: Dimens.size12)),
                    CustomTextField(
                        text: Strings.enterStreetAddress,
                        length: 100,
                        controller: controller.streetAddressController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          return controller.validation
                              .validateStreetAddress(value!);
                        },
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                    SizedBox(
                      height: Dimens.size15,
                    ),
                    Text(Strings.flatNumber,
                        style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: Dimens.size12)),
                    CustomTextField(
                        text: Strings.streetNo,
                        length: 100,
                        controller: controller.flatNumberController,
                        keyboardType: TextInputType.text,
                        // validator: (value) {
                        //   return controller.validation.validateFlatNO(value!);
                        // },
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                    SizedBox(
                      height: Dimens.size15,
                    ),
                    Text(Strings.postCode,
                        style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: Dimens.size12)),
                    CustomTextField(
                        text: Strings.enterPostcode,
                        length: 50,
                        controller: controller.postCodeController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          return controller.validation.validatePostalCode(value!);
                        },
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                    SizedBox(
                      height: Dimens.size15,
                    ),
                    Text(Strings.noteOptional,
                        style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: Dimens.size12)),
                    CustomTextField(
                        text: Strings.anyNoteToAdd,
                        length: 100,
                        controller: controller.noteController,
                        keyboardType: TextInputType.text,
                        inputFormatters: FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z- ]'))),
                    SizedBox(
                      height: Dimens.size15,
                    ),
                    Text(Strings.city,
                        style: textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: Dimens.size12)),
                    CustomTextField(
                        text: Strings.enterCity,
                        length: 50,
                        controller: controller.cityController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          return controller.validation.validateCity(value!);
                        },
                        inputFormatters: FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z- ]'))),
                    SizedBox(
                      height: Dimens.size30,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          roundCorner: 5,
                          height: 0.065,
                          width: 0.8,
                          text: Strings.save,
                          onPressed: () {
                            //controller1.getAddressList();
                            controller.onSaveButtonClick(pageId!, id, text);

                            // Get.offAll(Home());
                          },
                        )),
                    SizedBox(
                      height: Dimens.size15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  onPopScope() {
if(pageId==SingleToneValue.instance.saveAddressId){
  Get.off(MapScreen(id: SingleToneValue.instance.saveAddressId));
}
    else if(pageId==SingleToneValue.instance.deliveryAddress){
  Get.off(MapScreen(id:SingleToneValue.instance.deliveryAddress));
}
    else if(pageId==SingleToneValue.instance.homePageId){
  Get.off(MapScreen(id:SingleToneValue.instance.homePageId));
}

  }
}

class AddressType extends StatelessWidget {
  const AddressType({
    Key? key,
    required this.image,
    required this.text,
    required this.color,
  }) : super(key: key);

  final Color color;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Container(
      height: mediaQuery.height * 0.18,
      width: mediaQuery.height * 0.12,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Dimens.size10),
          border: Border.all(color: MyColors.black, width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: Dimens.size40,
          ),
          Text(text)
        ],
      ),
    );
  }

}
