
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/favourite/favourite.dart';
import 'package:kiwkemart/data/model/product_details/product_details.dart';

import '../../repository.dart';
import '../../shared_pref_client.dart';

class ProductDesController extends GetxController{
  ProductDesController({
    this.productId
  });
  int? productId;

  bool isLoading = false;
  bool noInternet = false;
  final _repository = Repository();

  ProductDetailModel? model;
  final sharedPrefClient = SharedPrefClient();
  @override
  void onInit() async {
    Get.log("feature product index: $productId");
    await onProductDetail(productId.toString()).then((value) async {
      if(value){
       await manageCount();
      }
    });

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


  manageCount() async {
    isLoading = true;
    update();
    final String? cartString = await sharedPrefClient.getCartItem();
    final List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
    Constants.cartCount.value = Constants.itemInCart(cartItemSave);
    final String? favString = await sharedPrefClient.getFavItem();
    final List<FavouriteItem> favItemSave = FavouriteItem.decode(favString!);
    isLoading = false;
    update();
    if(cartItemSave.length != 0 && model!.response!.otherProducts!.length != 0){
      for (int j = 0; j < cartItemSave.length; j++){
        for (int k = 0; k < model!.response!.otherProducts!.length; k++){
          if(cartItemSave[j].productStoreId == model!.response!.otherProducts![k].productStoreId){
            model!.response!.otherProducts![k].itemCount.value = cartItemSave[j].quantity;
          }
        }
      }
    }

    if(favItemSave.length != 0 && model!.response!.otherProducts!.length != 0){
      favItemSave.forEach((elementF) {
        model!.response!.otherProducts!.forEach((elementC) {
          if(elementF.productStoreId == elementC.productStoreId){
            elementC.isFav.value = true;
          }
        });
      });
    }

    isLoading = false;
    update();
  }



  Future<bool> onProductDetail(String id) async {
    try {
      isLoading = true;
      update();
      model = await _repository.onProductDetail(id);
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
        Get.snackbar("Product Detail", e.toString().replaceAll('Exception:', ''));
        return false;
      }
    }
  }




}