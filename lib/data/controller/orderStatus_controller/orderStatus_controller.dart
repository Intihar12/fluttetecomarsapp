
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/cart_model/cart_model.dart';
import 'package:kiwkemart/data/model/order_list/order_list.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

import '../../repository.dart';
import '../../shared_pref_client.dart';

class OrderStatusController extends GetxController{
  OrderList? orderList;
  bool isLoading = false;
  bool noInternet = false;
  final _repository = Repository();
  final sharedPrefClient = SharedPrefClient();

  List order=[
    'Ongoing',
    'Completed',
  ];

  int id=0;

  @override
  void onInit() {
    // SingleToneValue.instance.status ="dispatched";
    onOrderList('on_going');
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


  onOrderList(String status) async {
    isLoading = true;
    update();
    try {
      String? token = await sharedPrefClient.getUserToken();
      orderList = await _repository.onOrderList(status,token!);
      isLoading = false;
      printInfo(info: orderList!.response!.imageUrl.toString());
      if (noInternet) {
        noInternet = false;
      }
      update();
      return true;
    } catch (e) {
      if (e.toString() == 'Exception: No Internet') {
        isLoading = false;
        noInternet = true;
        update();
        return false;
      } else {
        isLoading = false;
        noInternet = true;
        update();
        Get.snackbar("Order", e.toString().replaceAll('Exception:', ''));
        return false;
      }
    }
  }




}