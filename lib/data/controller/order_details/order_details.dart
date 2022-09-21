
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/order_details/order_details.dart' as order;
import '../../repository.dart';
import '../../shared_pref_client.dart';
class OrderDetailController extends GetxController{
  String? id;
  OrderDetailController({
    this.id,
 });
  final sharedPrefClient = SharedPrefClient();
  order.OrderDetails? orderDetails;
  bool isLoading = false;
  bool noInternet = false;
  final _repository = Repository();


  @override
  void onInit() {
    isLoading = true;
    update();
    onOrderDetail(id!);
    super.onInit();
  }


  onOrderDetail(String id) async {
    try {
      String? token = await sharedPrefClient.getUserToken();
      orderDetails = await _repository.onOrderDetail(id, token!);
      isLoading = false;
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
        Get.snackbar("Home", e.toString().replaceAll('Exception:', ''));
        return false;
      }
    }
  }


}