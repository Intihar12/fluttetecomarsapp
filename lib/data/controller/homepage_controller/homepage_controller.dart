import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/favourite/favourite.dart';
import 'package:kiwkemart/data/model/home_data/home_data.dart';
import 'package:kiwkemart/data/model/home_page_model/home_page_model.dart';
import 'package:kiwkemart/data/model/itemModel/items_model.dart';
import 'package:kiwkemart/data/model/new_offer_model.dart';
import 'package:kiwkemart/data/model/user_save_data_model/user_save_data_model.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/auth/login/login.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';

import '../../card_counter.dart';
import '../../model/save_store_data/save_store_data.dart';
import '../../repository.dart';
import '../../shared_pref_client.dart';

class HomeController extends GetxController {
  ScrollController modalController = ScrollController();
  var scrollController = ScrollController();
String ? address='';
  int id = 2;
  bool isLoading = false;
  bool noInternet = false;
  final _repository = Repository();
  HomeData? homeData;

  Future<void> setStoreData(HomeData data) => _repository.setStore(SaveStoreData(
      id: data.response!.store!.id,
      name: data.response!.store!.name,
      lat: data.response!.store!.lat,
    lng: data.response!.store!.lng,
    address: data.response!.store!.address

  ));
  BuildContext? context;
  HomeController({  this.context});

  final _sharedPrefClient = SharedPrefClient();
  CardCounter cardCounter = CardCounter();



  @override
  void onInit() async {
  address  =await _sharedPrefClient.getAddress();
  String? token = await _sharedPrefClient.getUserToken();

  print("Token: $token");

    SingleToneValue.instance.userName = await _sharedPrefClient.getUserName();
    isLoading = true;
    update();
    super.onInit();
    //WidgetsBinding.instance!.addPostFrameCallback((_) => showDialog(context!));
    final String? cartString = await _sharedPrefClient.getCartItem();
    final List<CartItemSave> cartItemSave = CartItemSave.decode(cartString!);
    final String? favString = await _sharedPrefClient.getFavItem();
    final List<FavouriteItem> favItemSave = FavouriteItem.decode(favString!);
    Constants.cartCount.value = Constants.itemInCart(cartItemSave);
    await onHomeData().then((value) {
      isLoading = true;
      update();
      if (value) {
        if (cartItemSave.length != 0 &&
            homeData!.response!.featuredProduct!.length != 0) {
          for (int j = 0; j < cartItemSave.length; j++) {
            for (int i = 0;
                i < homeData!.response!.featuredProduct!.length;
                i++) {
              if (cartItemSave[j].productStoreId ==
                  homeData!.response!.featuredProduct![i].productStoreId) {
                homeData!.response!.featuredProduct![i].itemCount.value =
                    cartItemSave[j].quantity;
              }
            }
          }
        }
        if (favItemSave.length != 0 &&
            homeData!.response!.featuredProduct!.length != 0) {
          favItemSave.forEach((elementF) {
            homeData!.response!.featuredProduct!.forEach((elementC) {
              if (elementF.productStoreId == elementC.productStoreId) {
                elementC.isFav.value = true;
              }
            });
          });
        }
      }
      isLoading = false;
      update();
    });
  }

  @override
  void onReady() {
    getLatestOfferDialog();
    super.onReady();
  }

  void showDialog(BuildContext context,NewOffersModel model) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: Get.height * 0.7,
            width: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImgs.popup), fit: BoxFit.cover),
              color: MyColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.clear,
                            size: 30,
                          ))),
                ),
                Text(
                  "${model.response!.title}",
                  style: Get.textTheme.headline5!
                      .copyWith(color: MyColors.appBackground),
                ),

                /*"New customers get 40% off with code:\n"
                  "KWIK40 * First order only. Minimum spend \$10,\n"
                  "maximum discount \$50."*/

                Text(
                  "${model.response!.body}",
                  textAlign: TextAlign.center,
                  style: Get.textTheme.caption,
                ),
                SizedBox(
                  height: Get.height * 0.35,
                ),
                CustomButton(
                    height: 0.03,
                    width: 0.2,
                    text: "Order now",
                    onPressed: () {}),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  Future<bool> onHomeData() async {
    UserDataSaveModel user=await _sharedPrefClient.getUser();
    String? lat=await _sharedPrefClient.getLat();
    String ? lng=await _sharedPrefClient.getLng();
    try {
      isLoading = true;
      update();
       await _repository.onHomeData(lat!,lng!).then((value){

         if(value.responseCode=="1"){
           Get.log("home api response on repo 1${value.response!.featuredProduct}");

           homeData=value;
           Get.log("home api response on repo 2${value.response}");
           // print('user token:${user.token!}');
           setStoreData(value);
           Constants.storeId = value.response!.store!.id.toString();
           Constants.serviceFee = value.response!.store!.serviceFee ?? '0.0';
           Constants.deliveryFee = value.response!.store!.deliveryFee ?? '0.0';
           isLoading = false;
           if (noInternet) {
             noInternet = false;
           }
           update();

         }

      });
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
        Get.log("home error $e");
        Get.log("home value ${homeData!.response!.featuredProduct}");
        Get.snackbar("Error", e.toString().replaceAll('Exception:', ''));
        return false;
      }
    }
  }

  getLatestOfferDialog(){
    _repository.newOffersDialog().then((value) async {
      if(value.responseCode =="1"){
       int? offerCheck =  await _sharedPrefClient.getOfferCheck();
        if(value.response!.id != offerCheck) {
          WidgetsBinding.instance!.addPostFrameCallback((_) =>
              showDialog(context!,value));

         await _sharedPrefClient.setOfferCheck(value.response!.id!);
        }else if(value.response!.id != null && offerCheck == 0){

          WidgetsBinding.instance!.addPostFrameCallback((_) =>
              showDialog(context!,value));

          await _sharedPrefClient.setOfferCheck(value.response!.id!);
        }
      }
    });
  }

}
