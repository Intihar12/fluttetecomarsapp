import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/login_model/login_model.dart';
import 'package:kiwkemart/data/model/user_save_data_model/user_save_data_model.dart';
import 'package:kiwkemart/data/repository.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/data/validation/validation.dart';
import 'package:kiwkemart/ui/address/save_adress.dart';
import 'package:kiwkemart/ui/auth/otp_screen.dart';
import 'package:kiwkemart/ui/auth/otpscreen.dart';
import 'package:kiwkemart/ui/auth/signup/signup.dart';
import 'package:kiwkemart/ui/deliveryAddress/delivery_address.dart';
import 'package:kiwkemart/ui/home/home_homepage1.dart';
import 'package:kiwkemart/ui/map_search_screen/map_search_screen.dart';

import '../../../ui/widgets/progress_bar.dart';
import '../../shared_pref_client.dart';

class AuthController extends GetxController with StateMixin<OtpDataModel> {
  /// repo
  ///
  ///
  final _repo = Repository();
  final _sharedPrefClient = SharedPrefClient();
  Validation validation = Validation();

  ///login screen
  // final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  ///
  TextEditingController noController = TextEditingController();

  /// sign Up Screen
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController referController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  /// otp screen
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  TextEditingController fourthController = TextEditingController();
  TextEditingController fifthController = TextEditingController();
  TextEditingController sixthController = TextEditingController();

  int count = 60;

  ///  user  check it user is login or not
  Future<bool> isUserLoggedIn() => _repo.isUserLoggedIn();

  ///

  /// set the user login in session
  ///
  Future<void> setUser(LoginModel user) => _repo.setUser(UserDataSaveModel(
      userId: user.response!.id,
      userName: user.response!.firstName! + ' ' + user.response!.lastName!,
      userPhone: user.response!.phone!,
      userEmail: user.response!.email,
      token: user.response!.token,
      referCode: user.response!.referCode,
      coin: user.response!.coin));

  ///  login function

  login({required String phone, required String deviceToken}) async {
    await _repo
        .loginFun(
      phone: phone,
      deviceToken: deviceToken,
    )
        .then((value) async {
      change(OtpDataModel(model: value), status: RxStatus.success());
      if (value is LoginModel) {
        if (value.responseCode == '1') {
          _sharedPrefClient.setUserToken(value.response!.token.toString());
          _sharedPrefClient.setUserName(value.response!.firstName.toString() +
              ' ' +
              value.response!.lastName.toString());
          Get.log(value.response!.firstName.toString() +
              value.response!.lastName.toString());
          String? lat = await _sharedPrefClient.getLat();
          String? lng = await _sharedPrefClient.getLng();
          setUser(value);
       //   if (lat == 'lat' && lng == 'lng')
         // {
            Get.offAll(SaveAddress(
               SingleToneValue.instance.loginPageID,
            ));

        //  }
        // else {
        //     Get.offAll(Home());
        //     Get.snackbar("Login", value.responseMessage.toString());
        //   }
        } else {
          if (value.responseCode == '0') {
            Get.to(SignUp());
            Get.snackbar("Message", value.errors.toString());
          }
        }
      }
    }, onError: (error) {
      change(value, status: RxStatus.error(error.toString()));
      print("value Erorr $error");
      Get.snackbar("Login", 'SomeThing Went Wrong');
    });
  }

  ///     register function
  ///
  register(
      {required String fName,
      required String lName,
      required String email,
      required String phone,
      required String deviceToken,
      String? referCode}) async {
    await _repo
        .registerFun(
            firstName: fName,
            lastName: lName,
            email: email,
            phone: phone,
            deviceToken: deviceToken,
            referCode: referCode)
        .then((value) async {
      change(OtpDataModel(model: value), status: RxStatus.success());
      if (value is LoginModel) {
        if (value.responseCode == '1') {
          setUser(value);
          _sharedPrefClient.setUserToken(value.response!.token.toString());
          _sharedPrefClient.setUserName(value.response!.firstName.toString() +
              ' ' +
              value.response!.lastName.toString());
          Get.log(value.response!.firstName.toString() +
              value.response!.lastName.toString());
          String? lat = await _sharedPrefClient.getLat();
          String? lng = await _sharedPrefClient.getLng();
       //   if (lat == 'lat' && lng == 'lng') {
            Get.offAll(SaveAddress(
               SingleToneValue.instance.loginPageID,
            ));
          // } else {
          //   Get.offAll(Home());
          //   Get.snackbar("SignUp", value.responseMessage.toString());
          // }
        } else {
          if (value.responseCode == '0')
            Get.snackbar("", value.errors.toString());
        }
      }
    }, onError: (error) {
      change(value, status: RxStatus.error(error.toString()));
      print("value Erorr $error");
      Get.snackbar("SingUp", 'Some Thing Went Wrong');
    });
  }

  ///
  otpButton() {
    String otp =
        "${firstController.text}${secondController.text}${thirdController.text}${fourthController.text}${fifthController.text}${sixthController.text}";
    verifyOtp(otp);
  }

  /// form validation on signUp Screen

  onSignUPButton() {
    final isValid = signUpFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      Get.dialog(ProgressBar(), barrierDismissible: false);
      register(
          fName: firstNameController.text,
          lName: lastNameController.text,
          email: emailController.text,
          phone: SingleToneValue.instance.userPhone,
          deviceToken: SingleToneValue.instance.deviceToken!,
          referCode: referController.text);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    verifyPhone(SingleToneValue.instance.userPhone);
  }

  var authState = "".obs;
  String verificationId = "";
  var auth = FirebaseAuth.instance;

  verifyPhone(String phone) async {
    try {
      change(OtpDataModel(timerValue: count), status: RxStatus.success());

      await auth.verifyPhoneNumber(
          phoneNumber: phone,
          verificationCompleted: (AuthCredential authCredential) {
            print("otp $authCredential");
          },
          verificationFailed: (authException) {
            Get.snackbar("Otp Error", "Error when sending the code");

            print("Otp Error $authException");
          },
          codeSent: (String id, int? forceResent) async {
            this.verificationId = id;

            Get.to(PhoneVerification());
            Get.snackbar("Code Sent!", "Code Sent Successfully");
          },
          codeAutoRetrievalTimeout: (id) {
            this.verificationId = id;
          },
          timeout: Duration(seconds: 0));
    } catch (e) {
      Get.snackbar("Code Sent!", e.toString().replaceAll('Exception:', ''));
    }
  }

  verifyOtp(String otp) async {
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));

      if (credential.user != null) {
        Get.dialog(ProgressBar(), barrierDismissible: false);
        login(
            phone: SingleToneValue.instance.userPhone,
            deviceToken: SingleToneValue.instance.deviceToken!);
      }
    } catch (exception) {
      print("Otp match exception: $exception");
    }
  }

  timer() {
    const oneSec = const Duration(seconds: 1);
    Timer _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (count == 0) {
        timer.cancel();
      } else {
        count--;
        change(OtpDataModel(timerValue: count), status: RxStatus.success());
      }
    });
  }
}

class OtpDataModel {
  int? timerValue = 0;
  LoginModel? model;

  OtpDataModel({this.model, this.timerValue});
}
