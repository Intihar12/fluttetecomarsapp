
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/favourite/favourite.dart';

import '../../shared_pref_client.dart';

class FavouriteController extends GetxController{

  bool isLoading = false;
  final sharedPrefClient = SharedPrefClient();
  List<FavouriteItem> favItemSave = [];
  List<CartItemSave> cartItemSave = [];
  @override
  void onInit() async {
    isLoading = true;
    update();
    final String? cartString = await sharedPrefClient.getCartItem();
    cartItemSave = CartItemSave.decode(cartString!);
    final String? favString =
        await sharedPrefClient.getFavItem();
    favItemSave = FavouriteItem.decode(favString!);
    printInfo(info: favItemSave.length.toString());
    if(Constants.cartCount.value != 0 || cartItemSave.isNotEmpty){
      cartItemSave.forEach((element) {
        favItemSave.forEach((elementF) {
          if(element.productStoreId == elementF.productStoreId){
            elementF.itemCount.value = element.quantity;
          }
        });
      });
    }
    isLoading = true;
    update();
    super.onInit();
  }

}