
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/favourite/favourite.dart';
import 'package:kiwkemart/data/model/save_store_data/save_store_data.dart';
import 'package:kiwkemart/data/model/search_keyword/search_keyword.dart';
import 'package:kiwkemart/data/model/searched_product/searched_product.dart';

import '../../repository.dart';
import '../../shared_pref_client.dart';

class ProductSearch extends GetxController{
  final sharedPrefClient = SharedPrefClient();
  TextEditingController searchTextController = TextEditingController();
  SearchKeyword? searchKeyword;
  SearchedProducts? searchedProducts;
  bool isLoading = false;
  bool noInternet = false;
  final _repository = Repository();

  @override
  void onInit() {
    isLoading = true;
    update();
    onKeyWord();
    super.onInit();
  }


  onKeyWord() async {
    try {
      String? token = await sharedPrefClient.getUserToken();
      searchKeyword = await _repository.onSearchedKeyWords('1', token!);
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


  onSearchWord(String word) async {
    try {
      String? token = await sharedPrefClient.getUserToken();
      SaveStoreData storeData =await sharedPrefClient.getStoreData();
      String id= storeData.id.toString();
      searchedProducts = await _repository.onSearchedProducts(id,word,token!);

      final String? cartString = await sharedPrefClient.getCartItem();
      final List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
      Constants.cartCount.value = Constants.itemInCart(cartItemSave);
      final String? favString = await sharedPrefClient.getFavItem();
      final List<FavouriteItem> favItemSave = FavouriteItem.decode(favString!);

      if (cartItemSave.length != 0 && searchedProducts!.response!.products!.length != 0) {
        for (int i = 0; i < searchedProducts!.response!.products!.length; i++) {
              for (int j = 0; j < cartItemSave.length; j++) {
                if (cartItemSave[j].productStoreId ==
                    searchedProducts!.response!.products![i].productStoreId) {
                  searchedProducts!.response!.products![i].itemCount.value =
                      cartItemSave[j].quantity;
                }
              }
        }
      }
      if(favItemSave.length != 0 && searchedProducts!.response!.products!.length != 0){
        favItemSave.forEach((elementF) {
          searchedProducts!.response!.products!.forEach((elementC) {
            if(elementF.productStoreId == elementC.productStoreId){
              elementC.isFav.value = true;
            }
          });
        });
      }

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