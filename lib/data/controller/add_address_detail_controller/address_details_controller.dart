import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/address_models/get_address_model.dart';
import 'package:kiwkemart/data/model/address_type_model/address_type_model.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/data/validation/validation.dart';
import 'package:kiwkemart/ui/address/save_adress.dart';
import 'package:kiwkemart/ui/auth/login/login.dart';
import 'package:kiwkemart/ui/delivery/delivery.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/progress_bar.dart';

import '../../model/save_address_model/save_address_model.dart';
import '../../repository.dart';
import '../../shared_pref_client.dart';

class AddressDetailController extends GetxController with StateMixin<dynamic> {
  final _repo = Repository();
  final _sharedPrefClient = SharedPrefClient();
  bool noInternet = false;
  GetAddressModel? addressModel;
  var isLoading = true.obs;
  List<AddressTypeModel> typeData = [
    AddressTypeModel(text: "Home", image: MyImgs.iconHome),
    AddressTypeModel(text: "Work", image: MyImgs.work),
    AddressTypeModel(text: "Others", image: MyImgs.others),
  ];

  /// validation form
  GlobalKey<FormState> saveAddressFormKey = GlobalKey<FormState>();
  Validation validation = Validation();
  final firstName = TextEditingController();
  final streetAddressController = TextEditingController();
  final flatNumberController = TextEditingController();
  final postCodeController = TextEditingController();
  final noteController = TextEditingController();
  final cityController = TextEditingController();

  /// save button click
  onSaveButtonClick(int id, int index, String text) async {
    String? userId = await _sharedPrefClient.getUserId();
    final isValid = saveAddressFormKey.currentState!.validate();

    try {
        if (!isValid) {
          return;
        } else {
          Get.dialog(ProgressBar(), barrierDismissible: false);
          addAddress(
            id: id,
            lat: SingleToneValue.instance.currentLat,
            lng: SingleToneValue.instance.currentLng,
            title: text,
            address: SingleToneValue.instance.currentAddress,
            city: cityController.text,
            flatNo: flatNumberController.text,
            postalCode: postCodeController.text,
          );
        }
      }
     catch (ex) {
      print(ex);
    }
  }

  ///
  ///

  addAddress({
    required int id,
    required double lat,
    required double lng,
    required String title,
    required String address,
    String? flatNo,
    required String postalCode,
    required String city,
  }) async {
    await _repo
        .addAddress(
            lat: lat,
            lng: lng,
            title: title,
            address: address,
            flatNo: flatNo,
            city: city,
            postalCode: postalCode)
        .then((value) async {
      change((value), status: RxStatus.success());
      if (value is SaveAddressModel) {
        if (value.responseCode == '1') {
          update();
         SingleToneValue.instance.userAddressId=value.response!.id;
          _sharedPrefClient.setUserAddressId(value.response!.id);

          if(id==SingleToneValue.instance.saveAddressId){
            Get.off(SaveAddress(SingleToneValue.instance.saveAddressId));
          }
          else if(id==SingleToneValue.instance.homePageId ||
              id==SingleToneValue.instance.loginPageID)
          {
            await _sharedPrefClient.setLat(SingleToneValue.instance.currentLat.toString());
            await _sharedPrefClient.setLng(SingleToneValue.instance.currentLng.toString());
            await _sharedPrefClient.setAddress(SingleToneValue.instance.currentAddress);
              Get.offAll(Home());

          }

          else if(id==SingleToneValue.instance.deliveryAddress){

           Get.off(Delivery(userAddressId:value.response!.id,
           address: SingleToneValue.instance.currentAddress,
           ));
          }



          Get.snackbar("Message", value.responseMessage.toString());
        }
      } else {
        if (value.responseCode == '0')
          Get.snackbar("", value.errors.toString());
      }
    }, onError: (error) {
      change(value, status: RxStatus.error(error.toString()));
      print("value Erorr $error");
      Get.snackbar("add address", value.toString());
    });
  }

  itemUpdate() {
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    streetAddressController.text='';
    flatNumberController.text='';
    postCodeController.text='';
    noteController.text='';
    cityController.text='';
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void onClose() {}

  @override
  Future<void> onInit() async {

    streetAddressController.text = SingleToneValue.instance.currentAddress;
    flatNumberController.text = 'bz4';
    postCodeController.text = SingleToneValue.instance.postalCode;
    noteController.text = 'Add a note';
    cityController.text = SingleToneValue.instance.city;
    // TODO: implement onInit
    super.onInit();
  }


  ScrollController controller = ScrollController();
  late int listLength;

}
