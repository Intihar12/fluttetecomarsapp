import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/shared_pref_client.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/address/save_adress.dart';
import 'package:kiwkemart/ui/auth/login/login.dart';
import 'package:kiwkemart/ui/drawer_screen/my_orders_screen/my_order_screen.dart';
import 'package:kiwkemart/ui/drawer_screen/refer_screen/refer_screen.dart';
import 'package:kiwkemart/ui/favourites/favourites.dart';
import 'package:kiwkemart/ui/help_center/help_center.dart';
import 'package:kiwkemart/ui/payments/card_list.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    Key? key,
  }) : super(key: key);

  final sharedPrefClient = SharedPrefClient();


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Drawer(
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: mediaQuery.height * 0.2,
            width: mediaQuery.width,
            decoration: BoxDecoration(color: Get.theme.primaryColor),
            child: Padding(
              padding: const EdgeInsets.all(Dimens.size12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi",
                    style: TextStyle(
                        fontSize: Dimens.size20,
                        color: MyColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SingleToneValue.instance.userName==null?
             Text('Guest User',
               style: TextStyle(
                   fontSize: Dimens.size20,
                   color: MyColors.white,
                   fontWeight: FontWeight.bold),
             )
                 : Text(
                    // "Zeeshan Nawaz",
                    SingleToneValue.instance.userName!,
                    style: TextStyle(
                        fontSize: Dimens.size20,
                        color: MyColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: Dimens.size40),
                    child: Image.asset(
                      MyImgs.drawerSmile,
                      height: Dimens.size10,
                      width: Dimens.size35,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: Dimens.size20, top: Dimens.size30),
            child: Column(
              children: [
                drawerWidget(
                    image: MyImgs.drawerHomeIcon,
                    text: 'Home',
                    onTap: () {
                      Get.log(DateTime.now().timeZoneName);
                      Get.log(DateTime.now().timeZoneOffset.toString());
                      Get.back();
                    }),
                SizedBox(
                  height: Dimens.size18,
                ),

                drawerWidget(
                    image: MyImgs.drawerVoucherIcon,
                    text: 'My Favourites',
                    onTap: () async {
                     String? userId= await sharedPrefClient.getUserId();
                     if(userId=='-21'){
                       Get.defaultDialog(
                         title: "You are not login",
                         middleText: "Please login or sign up",
                         onConfirm: () async {
                           Get.offAll(Login());
                         },
                         onCancel: (){



                         },
                         textConfirm: "Ok",
                         textCancel: 'Cancel',

                       );
                     }
                     else{
                       Get.to(() => FavouriteScreen());
                     }

                    }),
                SizedBox(
                  height: Dimens.size18,
                ),
                drawerWidget(
                    image: MyImgs.drawerAddressIcon,
                    text: 'My Address',
                    onTap: () async {
                      String? userId= await sharedPrefClient.getUserId();
                      if(userId=='-21'){
                        Get.defaultDialog(
                          title: "You are not login",
                          middleText: "Please login or sign up",
                          onConfirm: () async {
                            Get.offAll(Login());
                          },
                          onCancel: (){



                          },
                          textConfirm: "Ok",
                          textCancel: 'Cancel',

                        );
                      }
                      else{
                        Get.to(() => SaveAddress(SingleToneValue.instance.saveAddressId));
                      }

                    }),
                SizedBox(
                  height: Dimens.size18,
                ),
                drawerWidget(
                    image: MyImgs.drawerHistoryIcon,
                    text: 'My Orders',
                    onTap: () async {
                      String? userId= await sharedPrefClient.getUserId();
                      if(userId=='-21'){
                        Get.defaultDialog(
                          title: "You are not login",
                          middleText: "Please login or sign up",
                          onConfirm: () async {
                            Get.offAll(Login());
                          },
                          onCancel: (){



                          },
                          textConfirm: "Ok",
                          textCancel: 'Cancel',

                        );
                      }
                      else{
                        Get.to(MyOrderScreen());
                      }

                    }),
                SizedBox(
                  height: Dimens.size18,
                ),
                drawerWidget(
                    image: MyImgs.drawerCardIcon,
                    text: 'My Cards',
                    onTap: () async {
                      String? userId= await sharedPrefClient.getUserId();
                      if(userId=='-21'){
                        Get.defaultDialog(
                          title: "You are not login",
                          middleText: "Please login or sign up",
                          onConfirm: () async {
                            Get.offAll(Login());
                          },
                          onCancel: (){



                          },
                          textConfirm: "Ok",
                          textCancel: 'Cancel',

                        );
                      }
                      else{
                        Get.to(SavedCards());
                      }

                    }),
                SizedBox(
                  height: Dimens.size18,
                ),
                drawerWidget(
                    image: MyImgs.drawerReferIcon,
                    text: 'Refer and Earn',
                    onTap: () async {
                      String? userId= await sharedPrefClient.getUserId();
                      if(userId=='-21'){
                        Get.defaultDialog(
                          title: "You are not login",
                          middleText: "Please login or sign up",
                          onConfirm: () async {
                            Get.offAll(Login());
                          },
                          onCancel: (){



                          },
                          textConfirm: "Ok",
                          textCancel: 'Cancel',

                        );
                      }
                      else{
                        Get.to(() => ReferScreen(),);
                      }

                    }),
                SizedBox(
                  height: Dimens.size18,
                ),
                Divider(),
                SizedBox(
                  height: Dimens.size18,
                ),
                textDrawer(
                    text: 'Help Center',
                    onTap: () async {
                      String? userId= await sharedPrefClient.getUserId();
                      if(userId=='-21'){
                        Get.defaultDialog(
                          title: "You are not login",
                          middleText: "Please login or sign up",
                          onConfirm: () async {
                            Get.offAll(Login());
                          },
                          onCancel: (){



                          },
                          textConfirm: "Ok",
                          textCancel: 'Cancel',

                        );
                      }
                      else{
                        Get.to(() => HelpCenter(),);
                      }

                    }),
                SizedBox(
                  height: Dimens.size14,
                ),
                textDrawer(
                    text: 'Privacy Policy',
                    onTap: () {
                      //  Get.to(()=>AddNewCard(),);
                    }),
                SizedBox(
                  height: Dimens.size14,
                ),
                textDrawer(text: 'Terms & Conditions', onTap: () {}),
                SizedBox(
                  height: Dimens.size14,
                ),
                textDrawer(
                    text: 'Logout',
                    onTap: () async {
                      String? userId= await sharedPrefClient.getUserId();
                      if(userId=='-21'){
                        Get.defaultDialog(
                          title: "You are not login",
                          middleText: "Please login or sign up",
                          onConfirm: () async {
                            Get.offAll(Login());
                          },
                          onCancel: (){



                          },
                          textConfirm: "Ok",
                          textCancel: 'Cancel',

                        );
                      }
                      else{
                        await sharedPrefClient.setUserToken('');
                        await sharedPrefClient.setDeviceToken('');
                        await sharedPrefClient.setUserId('-21');
                        await sharedPrefClient.setLng('lng');
                        await sharedPrefClient.setLat('lat');
                        final String? cartString =
                        await sharedPrefClient.getCartItem();
                        List<CartItemSave> cartItemSave =
                        CartItemSave.decode(cartString!);
                        cartItemSave = [];
                        final String encodedData =
                        CartItemSave.encode(cartItemSave);
                        await sharedPrefClient.setCartItem(encodedData);
                        Get.offAll(Login());
                      }

                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerWidget(
      {required String image,
      required String text,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            image,
            width: Dimens.size30,
            height: Dimens.size30,
          ),
          SizedBox(
            width: Dimens.size22,
          ),
          Text(
            text,
            style: Get.textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w500,
                color: Get.theme.colorScheme.secondary),
          )
        ],
      ),
    );
  }

  Widget textDrawer({
    required String text,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(text,
              style: Get.textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Get.theme.colorScheme.secondary)),
        ],
      ),
    );
  }
}
