
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/homepage_controller/homepage_controller.dart';
import 'package:kiwkemart/data/controller/sub_category_controller/sub_category_controller.dart';
import 'package:kiwkemart/data/model/add_to_cart/add_to_cart.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/cart_model/cart_model.dart';
import 'package:kiwkemart/data/model/category_product/category_product.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/cart/cahnges_cart.dart';
import 'package:kiwkemart/ui/delivery/delivery.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

import '../../../ui/auth/login/login.dart';
import '../../../ui/home/home_homepage1.dart';
import '../../../ui/widgets/progress_bar.dart';
import '../../constants/constants.dart';
import '../../model/save_store_data/save_store_data.dart';
import '../../repository.dart';
import '../../shared_pref_client.dart';

class CartController extends GetxController{
   List<CartItemSave> cartdata = [];
  final sharedPrefClient = SharedPrefClient();
 AddToCart ?model;
 int index=0;
  @override
  void onInit() async {
    // TODO: implement onIn
    isLoading = true;
    update();
    final String? cartString = await sharedPrefClient.getCartItem();
    final List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
    printInfo(info: 'KJHKJHK'+cartItemSave.length.toString());
    cartdata = cartItemSave;
    isLoading = false;
    update();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    isLoading = false;
  }


  @override
  void onClose() {

    // TODO: implement onClose
    super.onClose();

    isLoading = false;

  }
  @override
  void dispose(){

    super.dispose();
  }


  Future<void> emptyBasket() async {
    final String? cartString = await sharedPrefClient.getCartItem();
    List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
    cartItemSave = [];
    cartdata = cartItemSave;
    Constants.cartCount.value = 0;
    final String encodedData = CartItemSave.encode(cartdata);
    await sharedPrefClient.setCartItem(encodedData);
    update();
    Get.offAll(Home());
  }

  savedata() async {
    final String? cartString = await sharedPrefClient.getCartItem();
    final List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
    printInfo(info: 'KJHKJHK'+cartItemSave.length.toString());
    cartdata = cartItemSave;
    update();
  }
  bool isLoading = false;
  bool noInternet = false;
  final _repository = Repository();
 // AddToCart? addToCart;

   onAddToCart() async {
     SaveStoreData storeData=await sharedPrefClient.getStoreData();
     String? userid=await sharedPrefClient.getUserId();
    if (userid=='-21'){
      Get.defaultDialog(
        title: "You are not login",
        middleText: "Please login or sign up",
        onConfirm: () async {
          update();
          // final String? cartString = await sharedPrefClient.getCartItem();
          // List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
          // cartItemSave = [];
          // Constants.cartCount.value = 0;
          // final String encodedData = CartItemSave.encode(cartItemSave);
          // await sharedPrefClient.setCartItem(encodedData);
          Get.offAll(Login());
        },
        onCancel: (){



        },
        textConfirm: "Ok",
        textCancel: 'Cancel',

      );

    }
    else{
      isLoading = true;
      List<CartItemClass> list = [];
      try {
        final String? token = await sharedPrefClient.getUserToken();
        int? addressId =  await sharedPrefClient.getUserAddressId();
        cartdata.forEach((element) {
          list.add(CartItemClass(quantity: element.quantity,
              productStoreId: element.productStoreId, price: element.price.toString()
          ));
        });


        // int i=0;
        //
        // cartdata.forEach((element) {
        //
        //   for(i=0;i<=cartdata.length;i++){
        //     Get.log("cart data productID : ${element.productStoreId}");
        //     Get.log("cart data price : ${element.price}");
        //     Get.log("cart data quantity : ${element.quantity}");
        //   }
        // });

        update();

        Get.dialog(ProgressBar(), barrierDismissible: false);
        _repository.onAddToCart(storeData.id!.toString(),addressId.toString(),
            list,token!).then((value)  {
              model=value;

              if(value.response!.products![index].isPriceChanged==1||
              value.response!.products![index].isQuantityChanged==1 ||
              value.response!.products![index].isDeleted==1)
                {
                 Get.to(ChangesInCart());
                 isLoading=false;
                }
              else{

                SingleToneValue.instance.callAtDoor = value.response!.callAtDoor;
                SingleToneValue.instance.ringBell = value.response!.ringBell;

                Get.to(Delivery());
                isLoading=false;
              }

          //   isLoading = false;
        });
        // if()

        if (noInternet) {
          noInternet = false;
        }


        update();
      } catch (e) {
        if (e.toString() == 'Exception: No Internet') {
          isLoading = false;
          noInternet = true;
          update();
        }

        else if(e.toString() == "unauthenticated"){
          Get.snackbar("Authentication Error", "Please login again");
          Get.to(Login());
        }


        else {
          isLoading = false;
          update();
          Get.snackbar("Cart", e.toString().replaceAll('Exception:', ''));
        }
      }
    }

  }

  String calculateTotal(List<CartItemSave> list){
    double total = 0.0;
     for(int i =0; i<list.length ; i++){
       printInfo(info: 'PRICE'+list[i].price.toString());
       total = total + (list[i].price*list[i].quantity);
     }
    return total.toStringAsFixed(2);
  }

  String calculatePrice(double p,int q){
    double total = 0.0;
     printInfo(info: 'PRICE--->{$p}');
     printInfo(info: 'QUANTITY--->{$p}');
      total = p * q;
     return total.toStringAsFixed(2);
  }

}

class CartItemClass{
  int? productStoreId;
  int? quantity;
  String? price;
  CartItemClass({
    this.productStoreId,
     this.quantity,
     this.price
});


  CartItemClass.fromJson(Map<String, dynamic> json){
    productStoreId = json['product_store_id'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_store_id'] = productStoreId;
    _data['quantity'] = quantity;
    _data['price'] = price;
    return _data;
  }

}

