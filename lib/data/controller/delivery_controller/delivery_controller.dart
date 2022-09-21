
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/cart_model/cart_model.dart';
import 'package:kiwkemart/data/model/save_store_data/save_store_data.dart';
import 'package:kiwkemart/data/model/voucher/voucher.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/data/validation/validation.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

import '../../../ui/home/home_homepage1.dart';
import '../../../ui/payments/payment_screen.dart';
import '../../../ui/values/my_colors.dart';
import '../../../ui/widgets/progress_bar.dart';
import '../../model/cart_empty/cart_empty.dart';
import '../../repository.dart';
import '../../shared_pref_client.dart';

class DeliveryController extends GetxController{

  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
  TextEditingController voucherController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController voucherControllerPickUp = TextEditingController();
  TextEditingController commentControllerPickUp = TextEditingController();
  final sharedPrefClient = SharedPrefClient();
  final _repository = Repository();
  Validation validation=Validation();
   String ? userAddress;
  var value = true.obs;
  late String addressOff;
  var result=true.obs;
  CartEmpty? cartEmpty;
  bool isLoading = false;
  bool noInternet = false;
  List<CartItemSave>? cartItemSave;
  SaveStoreData? saveStoreData;
  bool pickUp = false;
  double? serviceFee = 0;
  double? subTotal = 0;
  double? deliveryFee = 0;
  double? total = 0;
  String orderType = 'delivery';
  bool pickUpVoucher = false;
  bool instantDelivery = true;
  bool scheduleDelivery = false;
  bool callWhenAtDoor = false;
  bool ringBell = false;
  String callWhenAtDoorText = "";
  String ringBellText = "";
  String scheduleDeliveryDate = '${DateTime.now()}';
  String scheduleTime = '${DateTime.now().day}'+'${DateTime.now().day}'+'${DateTime.now().day}';

  @override
  void onInit() async {
 saveStoreData=await sharedPrefClient.getStoreData();
 userAddress=await sharedPrefClient.getAddress();
    isLoading = true;
    update();
    final String? cartString = await sharedPrefClient.getCartItem();
    final List<CartItemSave> itemSave = CartItemSave.decode(cartString!);
    printInfo(info: 'HGFHHGF'+itemSave[0].title);
    cartItemSave = itemSave;
    totalCalculation();
    isLoading = false;
    update();
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


   totalCalculation(){
    serviceFee = double.parse(Constants.serviceFee);
    deliveryFee = double.parse(Constants.deliveryFee);
    subTotal = 0;
    for(int i=0;i<cartItemSave!.length;i++){
      subTotal = subTotal!+(cartItemSave![i].price * cartItemSave![i].quantity);
    }
     total = subTotal! + serviceFee! + deliveryFee!;
    update();
  }


  onApplyVoucher() async {
    isLoading = true;
    update();
    try {

      Voucher? voucher;
      final String? token = await sharedPrefClient.getUserToken();
      printInfo(info: 'Token-->'+token!);

      Get.dialog(ProgressBar(), barrierDismissible: false);
    voucher = await _repository.onVoucher(pickUpVoucher ? voucherControllerPickUp.text :voucherController.text, token);
    if(voucher.responseCode == '1'){
      subTotal = subTotal! - double.parse(voucher.response!.voucherDiscount ?? '0');
      total = total! - double.parse(voucher.response!.voucherDiscount ?? '0');
    }
  //  isLoading = false;
    if (noInternet) {
      noInternet = false;
    }
    // Get.to(Delivery(),);
    update();
    } catch (e) {
      if (e.toString() == 'Exception: No Internet') {
        isLoading = false;
        noInternet = true;
        update();
      } else {
        printInfo(info: "LJLJLHHL");
        isLoading = false;
        update();
        Get.snackbar("Delivery", e.toString().replaceAll('Exception:', ''));
      }
    }
  }

  /// proceed payment button



buttonProceed() async {

  pickUp = false;
  update();
  Get.to(PaymentScreen(),);


}

  emptyCart() async {

    try {
      isLoading = true;
      update();
      cartEmpty  = await _repository.cartEmpty();
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
        Get.snackbar("cart", e.toString().replaceAll('Exception:', ''),
          backgroundColor: MyColors.red500,
          colorText: MyColors.white,
        );
      }
    }
  }


}