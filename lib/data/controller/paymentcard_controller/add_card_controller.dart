import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/controller/delivery_controller/delivery_controller.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/payment_card/payment_card_model.dart';
import 'package:kiwkemart/data/model/place_order/PlaceOrder.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/data/validation/validation.dart';
import 'package:kiwkemart/ui/address/save_adress.dart';
import 'package:kiwkemart/ui/delivery/delivery.dart';
import 'package:kiwkemart/ui/orderSuccessful/order_successfull.dart';
import 'package:kiwkemart/ui/payments/card_list.dart';

import '../../../ui/widgets/progress_bar.dart';
import '../../repository.dart';
import '../../shared_pref_client.dart';

class AddCardController extends GetxController with StateMixin<dynamic> {
  final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> paymentFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryMoController = TextEditingController();
  TextEditingController expiryYeController = TextEditingController();
  TextEditingController cVCController = TextEditingController();
  Validation validation = Validation();
  final _repository = Repository();
  bool isLoading = false;
  bool noInternet = false;
  final sharedPrefClient = SharedPrefClient();
  GetCardListModel? paymentModel;
  var value = true.obs;

  late DeliveryController deliveryController;

  @override
  void onInit() async {
    if (Get.isRegistered<DeliveryController>()) {
      deliveryController = Get.find<DeliveryController>();
    }
    // TODO: implement onInit
    super.onInit();
  }

  //add card function
  addCard({
    required String cardNumber,
    required String expMo,
    required String expYe,
    required String cVC,
  }) async {
    isLoading = true;
    update();
    try {
      final String? token = await sharedPrefClient.getUserToken();
      String s = await _repository.addCard(
          cardNumber: cardNumber,
          expMo: expMo,
          expYe: expYe,
          cVC: cVC,
          token: token);
      Get.snackbar("Delivery", s);
    //  Get.off(SavedCards());
      expiryMoController.text = '';
      cVCController.text = '';
      cardNumberController.text = '';
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
        update();
        Get.snackbar("Delivery", e.toString().replaceAll('Exception:', ''));
      }
    }
  }

  /// add Button
  addCardButton() {
    final isValid = cardFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      try {
        String split = expiryMoController.text;
        print("date string $split");
        var a = split.split('/');
        String a1 = a.first;
        String a2 = a.last;
        print('first part:$a1');
        print('last part: $a2');
        addCard(
            cardNumber: cardNumberController.text,
            expMo: a1,
            expYe: a2,
            cVC: cVCController.text);
      } catch (e) {
        print(e);
      }
    }
  }

  onPaymentPay() async {
    final isValid = paymentFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    else{
      isLoading = true;
      update();
      try {

        String split = expiryMoController.text;
        print("date string $split");
        var a = split.split('/');
        String a1 = a.first;
        String a2 = a.last;
        print('first part:$a1');
        print('last part: $a2');
        PlaceOrder? placeOrder;
        final String? token = await sharedPrefClient.getUserToken();
        int? userAddressId=await sharedPrefClient.getUserAddressId();
        printInfo(info: 'Token-->' + token!);
        Get.dialog(ProgressBar(), barrierDismissible: false);
        placeOrder = await _repository.onPlaceOder(

            '$userAddressId',
            deliveryController.scheduleDeliveryDate,
            deliveryController.pickUp ? 'pickup' : 'delivery',
            'stripe',
            'new',
            cardNumberController.text,
            a1,
            a2,
            cVCController.text,
            '',
            '0',
            deliveryController.callWhenAtDoor,
            deliveryController.ringBell,
            deliveryController.callWhenAtDoorText,
            deliveryController.ringBellText,
            deliveryController.pickUp
                ? deliveryController.commentControllerPickUp.text
                : deliveryController.commentController.text,
            token);
        if (placeOrder.responseCode == '1') {
          Get.snackbar("Order", placeOrder.responseMessage.toString());
          final String? cartString = await sharedPrefClient.getCartItem();
          List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
          cartItemSave = [];
          Constants.cartCount.value = 0;
          final String encodedData = CartItemSave.encode(cartItemSave);
          await sharedPrefClient.setCartItem(encodedData);
          SingleToneValue.instance.userAddressId=null;
          Get.back();
          Get.offAll(OrderSuccessful(
              id: placeOrder.response!.id!,
              orderNo: placeOrder.response!.orderNo));
        }
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
          update();
          Get.snackbar("Delivery", e.toString().replaceAll('Exception:', ''));
        }
      }
    }

  }
}
