


import 'package:get/get.dart';

import '../../../ui/values/my_colors.dart';
import '../../constants/constants.dart';
import '../../model/cart_empty/cart_empty.dart';
import '../../model/cart_item_save/cart_item_save.dart';
import '../../model/favourite/favourite.dart';
import '../../model/favourite_list_empty/favourite_list_empty.dart';
import '../../repository.dart';
import '../../shared_pref_client.dart';

class CommonController extends GetxController{


  bool noInternet = false;
  var isLoading = true.obs;
  var value = true.obs;
  CartEmpty? cartEmpty;
  FavouriteListEmpty ? emptyFav;
  final _sharedPrefClient = SharedPrefClient();
  final _repository = Repository();
  /// cart empty





 emptyCart() async {

    try {

      isLoading.value = true;
      update();
      cartEmpty  = await _repository.cartEmpty();
      isLoading.value = false;
      if (noInternet) {
        noInternet = false;
      }
      update();
    } catch (e) {
      if (e.toString() == 'Exception: No Internet') {
        isLoading.value = false;
        noInternet = true;
        update();
      } else {
        isLoading.value = false;
        noInternet = false;
        update();
        Get.snackbar("cart", e.toString().replaceAll('Exception:', ''),
          backgroundColor: MyColors.red500,
          colorText: MyColors.white,
        );
      }
    }
  }

  /// favourite  list empty api  function call from repo

  emptyFavourite() async {

    try {

      isLoading.value = true;
      update();
      emptyFav  = await _repository.favouriteEmpty();
      isLoading.value = false;
      if (noInternet) {
        noInternet = false;
      }
      update();
    } catch (e) {
      if (e.toString() == 'Exception: No Internet') {
        isLoading.value = false;
        noInternet = true;
        update();
      } else {
        isLoading.value = false;
        noInternet = false;
        update();
        Get.snackbar("cart", e.toString().replaceAll('Exception:', ''),
          backgroundColor: MyColors.red500,
          colorText: MyColors.white,
        );
      }
    }
  }

  /// remove the data from the local storage

removeData() async {
  final String? cartString = await _sharedPrefClient.getCartItem();
  List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
  cartItemSave = [];
  Constants.cartCount.value = 0;
  final String encodedData = CartItemSave.encode(cartItemSave);
  await _sharedPrefClient.setCartItem(encodedData);
  String? favString = await _sharedPrefClient.getFavItem();
  favString = FavouriteItem.encode([]);
  await _sharedPrefClient.setFavItem(favString);
}

}