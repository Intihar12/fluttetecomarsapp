
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/cart_model/cart_model.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

class ProfileController extends GetxController{

  final firstName = TextEditingController();
  final secondName = TextEditingController();
  final email = TextEditingController();
  final myFocusNode= FocusNode();

  @override
  void onInit() {
    firstName.text="Noman";
    secondName.text="Javaid";
    email.text="abc@gmail.com";
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
    firstName.dispose();
    secondName.dispose();
    email.dispose();
    myFocusNode.dispose();

    // TODO: implement dispose
    super.dispose();
  }

}