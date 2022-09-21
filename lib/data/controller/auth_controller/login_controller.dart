import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/auth/otpscreen.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';

import '../../shared_pref_client.dart';

class LoginController extends GetxController {
  TextEditingController noController = TextEditingController();
  String code = '+44';
  final phoneController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final _sharedPrefClient = SharedPrefClient();

  ///on login button used it
  onContinueButtonClick() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      Get.back();
      return;
    } else {
      SingleToneValue.instance.userPhone =
          SingleToneValue.instance.cCode! + SingleToneValue.instance.number!;
      Get.back();
      Get.to(() => PhoneVerification());
    }
  }

  ///validation form login
  String? validateFiled(String value, text) {
    if (value.isEmpty) {
      return text;
    }
    return null;
  }

  void onCountryChange(CountryCode countryCode) {
    code = countryCode.toString();
    SingleToneValue.instance.cCode = code;
    update();
  }

  onSkip() async {
    String? lat = await _sharedPrefClient.getLat();
    String? lng = await _sharedPrefClient.getLng();
    if (lat == 'lat' && lng == 'lng') {
      Get.offAll(MapScreen(id: SingleToneValue.instance.guestUserId,));
    } else {
      Get.offAll(Home());
    }
  }
}
