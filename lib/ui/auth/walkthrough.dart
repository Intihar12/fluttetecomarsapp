import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';
import 'package:kiwkemart/data/model/favourite/favourite.dart';
import 'package:kiwkemart/data/shared_pref_client.dart';
import 'package:kiwkemart/ui/auth/login/login.dart';
import 'package:kiwkemart/ui/deliveryAddress/delivery_address.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';

import 'delivery_location_set.dart';



class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final _sharedPrefClient = SharedPrefClient();
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 10),
      margin: EdgeInsets.symmetric(horizontal: Dimens.size6),
      height: Dimens.size6,
      width: isActive ? Dimens.size25 : Dimens.size6,
      decoration: BoxDecoration(
        color: isActive ? Get.theme.colorScheme.primary : MyColors.grey,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.size6)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    height: 350.0,
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        _photos(
                          photo: MyImgs.imgWalk,
                          headline: 'Need Groceries Now?',
                          subtitle: 'Select wide range of product from fresh fruits to delicious snacks', ),
                        _photos(
                            photo: MyImgs.imgWalk1,
                            headline: 'Hassle free payments',
                            subtitle: 'Pay as your per conveniences, we accept all credits and debit card'
                        ),
                        _photos(
                            photo: MyImgs.imgWalk2
                            ,
                            headline: 'Fast doorstep deliveries',
                            subtitle:'Our delivery executive will deliver your order under 24 hour'
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage == _numPages - 1
                    ? Padding(
                  padding: const EdgeInsets.only(
                      top: Dimens.size4,
                      left: Dimens.size15,
                      right: Dimens.size15),
                  child: GestureDetector(
                    onTap: () async {
                      final String encodedData = CartItemSave.encode([]);
                      final String favData = FavouriteItem.encode([]);
                      await _sharedPrefClient.setCartItem(encodedData);
                      await _sharedPrefClient.setFavItem(favData);
                      _sharedPrefClient.setWalkThrough('1');
                      String? userId = await _sharedPrefClient.getUserId();
                      if ( userId == '-21' ) {
                        Get.offAll(Login());
                      } else {
                        Get.offAll(DeliveryAddress());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.size5),
                            color: Get.theme.colorScheme.primary
                        ),
                        child: Center(
                          child: Text(
                            'Get Started',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.only(
                      top: Dimens.size4,
                      left: Dimens.size15,
                      right: Dimens.size15),
                  child: GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // color: Colors.transparent,
                            borderRadius: BorderRadius.circular(Dimens.size5),
                            color: Get.theme.colorScheme.primary

                        ),
                        child: Center(
                          child: Text(
                            'Next',
                            style: Get.theme.textTheme.bodyText1!
                                .copyWith(color: Get.theme.colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _photos(
      {required String photo,
        required String headline,
        required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height*0.27,
          decoration:BoxDecoration(
            //  borderRadius: BorderRadius.only(
            // //   bottomLeft: Radius.circular(120),
            // //   bottomRight:  Radius.circular(120),
            //  ),
              image: DecorationImage(
                image: AssetImage(
                  photo,
                ),
                fit: BoxFit.contain,
              )

          ),

        ),
        SizedBox(height: Dimens.size15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size15),
          child: Text(
            headline,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                color: Get.theme.colorScheme.primary
            ),
            textAlign: TextAlign.center,

          ),
        ),
        SizedBox(height: Dimens.size15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size15),
          child: Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.black38),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
