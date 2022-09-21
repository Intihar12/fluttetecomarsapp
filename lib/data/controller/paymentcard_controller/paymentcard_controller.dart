import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/payment_card/payment_card_model.dart';
import 'package:kiwkemart/data/validation/validation.dart';

import '../../repository.dart';
import '../../shared_pref_client.dart';

 class PaymentCardController extends GetxController with StateMixin <dynamic>
 {


  final _repo = Repository();
  bool noInternet = false;
  GetCardListModel? cardListModel;
  bool isLoading = true;
  final sharedPrefClient = SharedPrefClient();

  @override
  void onInit() async {
   await  getCardList();
   // TODO: implement onInit
   super.onInit();
  }


  /// get card list
 ///
  getCardList() async {
   cardListModel = null;
   isLoading = true;
   update();
   try {
    String? token = await sharedPrefClient.getUserToken();
    cardListModel = await _repo.getCardList(token!);
    isLoading = false;
    if (noInternet) {
     noInternet = false;
    }
    update();
   } catch (e) {
    if (e.toString() == 'Exception: No Internet') {
     isLoading = false;
     noInternet = true;
     update();
    } else {
     isLoading = false;
     noInternet = false;
     update();
     Get.snackbar("card", e.toString().replaceAll('Exception:', ''));
    }
   }
  }
/// remove card
  removeCard({required String payId}) async {
   try {
    isLoading = true;
    update();
   String s = await _repo.removeCard(payId: payId);
    Get.snackbar("Delivery", s);
    getCardList();
    isLoading = false;
    if (noInternet) {
     noInternet = false;
    }
    update();
   } catch (e) {
    if (e.toString() == 'Exception: No Internet') {
     isLoading = false;
     noInternet = true;
     update();
    } else {
     isLoading = false;
     noInternet = false;
     update();
     Get.snackbar("card", e.toString().replaceAll('Exception:', ''));
    }
   }
  }
  /// remove button
  removeButton({
    required String payId
 }) async {
    await  removeCard(payId:payId).whenComplete(() async =>await getCardList());
  }


 }
