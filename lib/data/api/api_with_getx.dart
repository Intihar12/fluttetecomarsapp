import 'dart:convert';

import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/data/controller/cart_controller/cart_controller.dart';
import 'package:kiwkemart/data/model/add_to_cart/add_to_cart.dart';
import 'package:kiwkemart/data/model/address_models/get_address_model.dart';
import 'package:kiwkemart/data/model/category_product/category_product.dart';
import 'package:kiwkemart/data/model/home_data/home_data.dart';
import 'package:kiwkemart/data/model/login_model/login_model.dart';
import 'package:kiwkemart/data/model/map_search_models/fetch_address_model/fetch_address_model.dart';
import 'package:kiwkemart/data/model/new_offer_model.dart';
import 'package:kiwkemart/data/model/order_details/order_details.dart';
import 'package:kiwkemart/data/model/order_list/order_list.dart';
import 'package:kiwkemart/data/model/payment_card/payment_card_model.dart';
import 'package:kiwkemart/data/model/place_order/PlaceOrder.dart';
import 'package:kiwkemart/data/model/product_details/product_details.dart';
import 'package:kiwkemart/data/model/search_keyword/search_keyword.dart';
import 'package:kiwkemart/data/model/searched_product/searched_product.dart';
import 'package:kiwkemart/data/model/show_slots_model/show_slots_model.dart';
import 'package:kiwkemart/data/model/user_save_data_model/user_save_data_model.dart';
import 'package:kiwkemart/data/model/voucher/voucher.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/auth/login/login.dart';
import 'package:kiwkemart/ui/order_detail/order_detail.dart';

import '../model/cart_empty/cart_empty.dart';
import '../model/favourite_list_empty/favourite_list_empty.dart';
import '../model/save_address_model/save_address_model.dart';
import '../model/store_location_model/store_location_model.dart';
import '../shared_pref_client.dart';

class ApiProvider extends GetConnect {
  ///base url
  static const _baseUrl = "https://devglocal.com/KwikeMart/api/";
  static const _address =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=';

  /// apiAccessToken for dual validation
  static const String _apiAccessToken =
      'base64:kjYDJTrMrvMJ8+5vfI+XzTO9zAJ1OkV48QDD33MuqMY=';

  /// end points
  static const _endPLogin = 'login';
  static const _endPRegister = 'register';
  static const _endPHome = 'guest/user/home';
  static const _endPAddAddress = 'address/add';
  static const _endProductDetails = 'guest/user/product/detail/';
  static const _endCategoryProduct = 'guest/user/category/products';
  static const _endPGetAddress = 'address';
  static const _endPRemoveAddress = 'address/remove';
  static const _endPStripeCardList = 'stripe/card/list';
  static const _endPCardRemove = 'stripe/remove/card';
  static const _endPAddCard = 'stripe/add/card';
  static const _endPAddToCart = 'cart/add';
  static const _endPSearchStore = 'guest/user/store/search';
  static const _endPApplyVocher = 'apply/voucher';
  static const _endPPlaceOrder = 'order/place';
  static const _endPOrderList = 'orders/list';
  static const _endPSearch = 'search';
  static const _endPSearchList = 'search/list';
  static const _endPOrdersDetail = 'orders/detail';
  static const _endPCartEmpty='cart/empty';
  static const _endPFavouriteEmpty='favorites/remove_all';
  static const _endWorkingDaySlots='workingDaySlots';
  static const _latestOffer='guest/user/latest_offer';


  //
  ///  parameter define
  static const _pPhone = 'phone';
  static const _pDeviceToken = 'device_token';
  static const _pTimeZone = 'time_zone';
  static const _pEmail = 'email';
  static const _pFName = 'first_name';
  static const _pLName = 'last_name';
  static const _pLat = 'latitude';
  static const _pLng = 'longitude';
  static const _pId = 'id';
  static const _pTitle = 'title';
  static const _pAddress = 'address';
  static const _pSubCateId = 'sub_cate_id';
  static const _pStoreId = 'store_id';
  static const _pCity = 'city';
  static const _pPostCode = 'postal_code';
  static const _pFlatNo = 'flat_no';
  static const _pCardNo = 'card_number';
  static const _pExpM = 'exp_month';
  static const _pExpY = 'exp_year';
  static const _pCVC = 'cvc';
  static const _pPmId = 'pm_id';
  static const _preferCode = 'refer_code';

  final _sharedPrefClient = SharedPrefClient();

  /// cal login api
  Future<LoginModel> login(
      {required String phone, required String deviceToken}) async {
    httpClient.timeout = Duration(seconds: 100);
    final response = await post("$_baseUrl$_endPLogin", {
      _pPhone: phone,
      _pDeviceToken: deviceToken,
      _pTimeZone: 'asia/karachi'
    }, headers: {
      'Accept': 'application/json',
      'APP_KEY': _apiAccessToken
    }).whenComplete(() => Get.back());
    printInfo(info: response.body.toString());
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      LoginModel model = LoginModel.fromJson(response.body);
      print("value $model");
      return model;
    }
  }

  /// call register Api

  Future<LoginModel> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      String? referCode,
      required String deviceToken}) async {
    httpClient.timeout = Duration(seconds: 100);
    final response = await post("$_baseUrl$_endPRegister", {
      _pPhone: phone,
      _pDeviceToken: deviceToken,
      _pEmail: email,
      _pFName: firstName,
      _pLName: lastName,
      _preferCode: referCode,
      _pTimeZone: 'asia/karachi'
    }, headers: {
      'Accept': 'application/json',
      'APP_KEY': _apiAccessToken
    }).whenComplete(() => Get.back());
    printInfo(info: response.body.toString());
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      LoginModel model = LoginModel.fromJson(response.body);
      print("value $model");
      return model;
    }
  }

  /// guest user api call
  Future<HomeData> onHomeData(String lat, String lng) async {
    HomeData? homeData;
    httpClient.timeout = Duration(seconds: 100);
    try {
      final response = await post(
          "$_baseUrl$_endPHome", {_pLat: lat, _pLng: lng},
          headers: {'Accept': 'application/json', 'APP_KEY': _apiAccessToken});
      printInfo(info: response.body.toString());
      Get.log("home error api response : ${response.body}");


      if (response.statusCode == 200) {
        homeData = HomeData.fromJson(response.body);
    return homeData;
      } else {
        throw Exception(homeData!.errors![0].toString());
      }
    } catch (e) {
      if (e.toString() == 'Exception :' + homeData!.errors![0].toString()) {
        throw Exception(homeData.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }

  /// category product
  Future<CategoryProduct> onCategoryProduct(
      String subCatId, String storeId) async {
    printInfo(
        info: 'SUBCATEGORY--ID---->{$subCatId}-->STORE--ID--->{$storeId}');
    CategoryProduct? categoryProduct;
    httpClient.timeout = Duration(seconds: 200);
    try {
      final response = await post("$_baseUrl$_endCategoryProduct",
          {_pSubCateId: subCatId, _pStoreId: storeId},
          headers: {'Accept': 'application/json', 'APP_KEY': _apiAccessToken});
      printInfo(info: response.body.toString());
      if (response.statusCode == 200) {
        categoryProduct = CategoryProduct.fromJson(response.body);
        if (categoryProduct.responseCode! == '1') {
          return categoryProduct;
        } else {
          throw Exception(categoryProduct.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() ==
          'Exception :' + categoryProduct!.errors![0].toString()) {
        throw Exception(categoryProduct.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }
/// product details
  Future<ProductDetailModel> onProductDetail(String id) async {
    ProductDetailModel? productDetails;
    httpClient.timeout = Duration(seconds: 100);
    try {
      final response = await get(_baseUrl + _endProductDetails + id,
          headers: {'Accept': 'application/json', 'APP_KEY': _apiAccessToken});
      printInfo(info: response.body.toString());
      if (response.statusCode == 200) {
        productDetails = ProductDetailModel.fromJson(response.body);
        if (productDetails.responseCode! == '1') {
          return productDetails;
        } else {
          throw Exception(productDetails.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() ==
          'Exception :' + productDetails!.errors![0].toString()) {
        throw Exception(productDetails.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }
/// add to cart
  Future<AddToCart> onAddToCart(
      String storeId,String addressId ,List<CartItemClass> list, String token) async {





    Get.log("address id: $addressId}");

    AddToCart? addToCart;
    try {
      final response = await post("$_baseUrl$_endPAddToCart", {
        'store_id': storeId,
        'address_id':addressId,
        'products': list
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${token}'
      }).whenComplete(() => Get.back());
      printInfo(info: response.body.toString());
      if (response.statusCode == 200) {
        addToCart = AddToCart.fromJson(response.body);
        if (addToCart.responseCode!.toString() == '1') {
          return addToCart;
        } else {
          printInfo(info: 'KJHKJHKJ');
          throw addToCart.errors![0].toString();
        }
      }

      else if(response.statusCode == 401){
        throw "unauthenticated";
      }


      else {
        throw 'No Internet';
      }
    } catch (e) {
      printInfo(info: 'DSDDFDS' + e.toString());
      if (e.toString() == addToCart!.errors![0].toString()) {
        throw Exception(addToCart.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }

/// on voacher api
  Future<Voucher> onVoucher(String voucherCode, String token) async {
    Voucher? voucher;
    try {
      final response = await post("$_baseUrl$_endPApplyVocher", {
        'code': voucherCode
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${token}'
      }).whenComplete(() => Get.back());
      printInfo(info: 'APPLY VOUCHER' + response.body.toString());
      if (response.statusCode == 200) {
        voucher = Voucher.fromJson(response.body);
        if (voucher.responseCode! == '1') {
          return voucher;
        } else {
          throw voucher.errors![0].toString();
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      printInfo(info: e.toString());
      if (e.toString() == voucher!.errors![0].toString()) {
        throw Exception(voucher.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }


  /// order place
  Future<PlaceOrder> onPlaceOder(
      String userAddressId,
      String scheduleDate,
      String orderType,
      String paymentMethod,
      String cardType,
      String cardNumber,
      String expMonth,
      String expYear,
      String cVc,
      String pmId,
      String cardSave,
      bool callAtDoor,
      bool ringBell,
      String callAtDoorText,
      String ringBellText,
      String description,
      String token) async {
    PlaceOrder? placeOrder;
    printInfo(
        info: jsonEncode({
      'user_address_id': userAddressId,
      'schedule_date': "",
          'slot':scheduleDate,
      'order_type': orderType,
      'payment_method': paymentMethod,
      'card_type': cardType,
      'card_number': cardNumber,
      'exp_month': expMonth,
      'exp_year': expYear,
      'cvc': cVc,
      'pm_id': pmId,
      'card_save': cardSave,
      'call_at_door': callAtDoor,
      'ring_bell': ringBell,
          "call_at_door_description":callAtDoorText,
          "ring_bell_description":ringBellText,
      'description': description
    }));

    try {
      final response = await post("$_baseUrl$_endPPlaceOrder", {
        'user_address_id': userAddressId,
        'schedule_date': "",
        'slot':scheduleDate,
        'order_type': orderType,
        'payment_method': paymentMethod,
        'card_type': cardType,
        'card_number': cardNumber,
        'exp_month': expMonth,
        'exp_year': expYear,
        'cvc': cVc,
        'pm_id': pmId,
        'card_save': cardSave,
        'call_at_door': callAtDoor,
        'ring_bell': ringBell,
        "call_at_door_description":callAtDoorText,
        "ring_bell_description":ringBellText,
        'description': description
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${token}'
      }).whenComplete(() => Get.back());
      printInfo(info: response.body.toString());
      if (response.statusCode == 200) {
        placeOrder = PlaceOrder.fromJson(response.body);
        if (placeOrder.responseCode! == '1') {
          return placeOrder;
        } else {
          throw placeOrder.errors![0].toString();
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      printInfo(info: e.toString());
      if (e.toString() == placeOrder!.errors![0].toString()) {
        throw Exception(placeOrder.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }
/// add address in location api hit
  Future<SaveAddressModel> addAddress({
    required double lat,
    required double lng,
    required String title,
    required String address,
    required String city,
    String? flatNo,
    required String postalCode,
  }) async {
    UserDataSaveModel model = await _sharedPrefClient.getUser();
    print('User Token:${model.token}');
    SaveAddressModel? saveAddressModel;
    try {
      final response = await post(_baseUrl + _endPAddAddress, {
        _pLat: lat,
        _pLng: lng,
        _pTitle: title,
        _pAddress: address,
        _pCity: city,
        _pFlatNo: flatNo,
        _pPostCode: postalCode
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${model.token}'
      }).whenComplete(() => Get.back());
      if (response.statusCode == 200) {
        saveAddressModel = SaveAddressModel.fromJson(response.body);
        if (saveAddressModel.responseCode! == '1') {
          return saveAddressModel;
        } else {
          throw Exception(saveAddressModel.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      throw Exception(e.toString());
      /*if (e.toString() ==
          'Exception :' + saveAddressModel!.errors![0].toString()) {
        throw Exception(saveAddressModel.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }*/
    }
  }

  /// get address api

  Future<GetAddressModel> getAddressList() async {
    GetAddressModel? getAddressModel;
    UserDataSaveModel model = await _sharedPrefClient.getUser();
    print('User Token:${model.token}');
    httpClient.timeout = Duration(seconds: 200);
    try {
      final response = await get(
        _baseUrl + _endPGetAddress,
        headers: {
          'Accept': 'application/json',
          'APP_KEY': _apiAccessToken,
          'Authorization': 'Bearer ${model.token}'
        },
      );
      printInfo(info: response.body.toString());
      if (response.statusCode == 200) {
        getAddressModel = GetAddressModel.fromJson(response.body);
        if (getAddressModel.responseCode! == '1') {
          return getAddressModel;
        } else {
          throw Exception(getAddressModel.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() ==
          'Exception :' + getAddressModel!.errors![0].toString()) {
        throw Exception(getAddressModel.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }

  /// remove address
  Future<GetAddressModel> removeAddress({required int id}) async {
    GetAddressModel? getAddressModel;
    UserDataSaveModel model = await _sharedPrefClient.getUser();
    print('User Token:${model.token}');
    httpClient.timeout = Duration(seconds: 100);
    try {
      final response = await post(
        _baseUrl + _endPRemoveAddress,
        {_pId: id},
        headers: {
          'Accept': 'application/json',
          'APP_KEY': _apiAccessToken,
          'Authorization': 'Bearer ${model.token}'
        },
      );
      printInfo(info: response.body.toString());
      if (response.statusCode == 200) {
        getAddressModel = GetAddressModel.fromJson(response.body);
        if (getAddressModel.responseCode! == '1') {
          return getAddressModel;
        } else {
          throw Exception(getAddressModel.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() ==
          'Exception :' + getAddressModel!.errors![0].toString()) {
        throw Exception(getAddressModel.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }

  ///  fetch address from the lat lng

  Future<FetchAddress> fetchAddress(
      {required double latitude, required double longitude}) async {
    final response = await get(
      _address +
          '${latitude.toString()},${longitude.toString()}&key=${Constants.mapKey}',
    );
    return FetchAddress.fromJson(response.body);
  }

  /// add card
  ///

  Future<String> addCard(
      {required String cardNumber,
      required String expMo,
      required String expYe,
      required String cVC,
      String? token}) async {
    GetCardListModel? getModel;
    try {
      final response = await post(_baseUrl + _endPAddCard, {
        _pCardNo: cardNumber,
        _pExpM: expMo,
        _pExpY: expYe,
        _pCVC: cVC
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${token}'
      });
      if (response.statusCode == 200) {
        if (response.body['ResponseCode'].toString() == '1') {
          return 'Card Save Successfully';
        } else {
          throw Exception('Something went wrong');
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() == 'Exception :' + 'Something went wrong') {
        throw Exception('Something went wrong');
      } else {
        throw Exception('No Internet');
      }
    }
  }

  /// remove card
  ///
  Future<String> removeCard({
    required String payID,
  }) async {
    UserDataSaveModel model = await _sharedPrefClient.getUser();
    print('User Token:${model.token}');
    GetCardListModel? getModel;
    try {
      final response = await post(_baseUrl + _endPCardRemove, {
        _pPmId: payID
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${model.token}'
      });
      if (response.statusCode == 200) {
        if (response.body['ResponseCode'].toString() == '1') {
          return 'Card Remove Successfully';
        } else {
          throw Exception('Something went wrong');
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() == 'Exception :' + 'Something went wrong') {
        throw Exception('Something went wrong');
      } else {
        throw Exception('No Internet');
      }
    }
  }

  /// get card list
  ///
  Future<GetCardListModel> getCardList(String token) async {
    GetCardListModel? getCardListModel;
    try {
      final response = await get(
        _baseUrl + _endPStripeCardList,
        headers: {
          'Accept': 'application/json',
          'APP_KEY': _apiAccessToken,
          'Authorization': 'Bearer ${token}'
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        getCardListModel = GetCardListModel.fromJson(response.body);
        if (getCardListModel.responseCode! == '1') {
          return getCardListModel;
        } else {
          throw Exception(getCardListModel.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() ==
          'Exception :' + getCardListModel!.errors![0].toString()) {
        throw Exception(getCardListModel.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }

  Future<bool> onLatLngToStore(String latitude, String longitude) async {
    // printInfo(info: latitude+'LATLNG'+longitude);
    try {
      final response = await post(_baseUrl + _endPSearchStore, {
        'latitude': latitude,
        'longitude': longitude
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
      });
      if (response.statusCode == 200) {
        if (response.body['ResponseCode'] == '1') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  /// location store exit or not
  Future<StoreLocation> storeLocation({required String latitude, required String longitude}) async {
    StoreLocation? storeLocation;
    UserDataSaveModel model = await _sharedPrefClient.getUser();
    print('User Token:${model.token}');
    httpClient.timeout = Duration(seconds: 100);
//try{
  final response = await post(
    _baseUrl + _endPSearchStore,
    {
      'latitude': latitude,
      'longitude': longitude
    },
    headers: {
      'Accept': 'application/json',
      'APP_KEY': _apiAccessToken,
      //  'Authorization': 'Bearer ${model.token}'
    },
  );
  printInfo(info: response.body.toString());
  if (response.status.hasError) {
    return Future.error(response.statusText!);
  }
  else {
    storeLocation =  StoreLocation.fromJson(response.body);
    printInfo(info: storeLocation.toString());
    print("value $storeLocation");
    return storeLocation;
  }
  //  if (response.statusCode == 200) {
  // storeLocation = StoreLocation.fromJson(response.body);
  //    if (storeLocation.responseCode! == '1') {
  //      return storeLocation;
  //    } else {
  //      throw Exception(storeLocation.errors![0].toString());
  //    }
  //  } else {
  //    throw Exception('No Internet');
  //  }
//}

    //  catch (e) {
    //   if (e.toString() ==
    //       'Exception :' + storeLocation!.errors![0].toString()) {
    //     throw Exception(storeLocation.errors![0].toString());
    //   } else {
    //     throw Exception('No Internet');
    //   }
    // }
  }

  ///on order detail

  Future<OrderDetails> onOrderDetail(String id, String token) async {
    OrderDetails? orderDetails;
    try {
      final response = await post(_baseUrl + _endPOrdersDetail, {
        'id': id,
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${token}'
      });
      if (response.statusCode == 200) {
        print(response.body);
        orderDetails = OrderDetails.fromJson(response.body);
        if (orderDetails.responseCode! == '1') {
          SingleToneValue.instance.status =
              orderDetails.response!.order!.status!;
          return orderDetails;
        } else {
          throw Exception(orderDetails.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() == 'Exception :' + orderDetails!.errors![0].toString()) {
        throw Exception(orderDetails.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }
/// search product
  Future<SearchedProducts> onSearchedProducts(
      String storeId, String keyword, String token) async {
    SearchedProducts? searchedProducts;
    try {
      final response = await post(_baseUrl + _endPSearch, {
        'store_id': storeId,
        'keyword': keyword
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${token}'
      });
      if (response.statusCode == 200) {
        printInfo(info: response.body.toString());
        searchedProducts = SearchedProducts.fromJson(response.body);
        if (searchedProducts.responseCode! == '1') {
          return searchedProducts;
        } else {
          throw Exception(searchedProducts.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() ==
          'Exception :' + searchedProducts!.errors![0].toString()) {
        throw Exception(searchedProducts.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }
///search keyword
  Future<SearchKeyword> onSearchedKeyWords(String storeId, String token) async {
    SearchKeyword? searchKeyword;
    try {
      final response = await get(_baseUrl + _endPSearchList, query: {
        'store_id': storeId
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${token}'
      });
      if (response.statusCode == 200) {
        printInfo(info: response.body.toString());
        searchKeyword = SearchKeyword.fromJson(response.body);
        if (searchKeyword.responseCode! == '1') {
          return searchKeyword;
        } else {
          throw Exception(searchKeyword.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() ==
          'Exception :' + searchKeyword!.errors![0].toString()) {
        throw Exception(searchKeyword.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }

  Future<OrderList> onOrderList(String status, String token) async {
    OrderList? orderList;
    try {
      final response = await post(_baseUrl + _endPOrderList, {
        'status': status,
      }, headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${token}'
      });
      printInfo(info: response.body.toString());
      if (response.statusCode == 200) {
        // printInfo(info: response.body);
        orderList = OrderList.fromJson(response.body);
        if (orderList.responseCode! == '1') {
          return orderList;
        } else {
          throw Exception(orderList.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() == 'Exception :' + orderList!.errors![0].toString()) {
        throw Exception(orderList.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }


///empty cart

  Future<CartEmpty> emptyCart() async {
    UserDataSaveModel user = await _sharedPrefClient.getUser();
    CartEmpty? cartEmpty;

    final response = await get(
      _baseUrl + _endPCartEmpty,
      headers: {
        'Accept': 'application/json',
        'APP_KEY': _apiAccessToken,
        'Authorization': 'Bearer ${user.token}'
      },
    );
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      cartEmpty = CartEmpty.fromJson(response.body);
      print("value $cartEmpty");
      return cartEmpty;
    }
      //  cartEmpty = CartEmpty.fromJson(response.body);
      //     if (cartEmpty.responseCode! == '1') {
      //       return cartEmpty;
      //     } else {
      //       throw Exception(cartEmpty.errors![0].toString());
      //     }
      //   } else {
      //     throw Exception('No Internet');
      //   }
      // } catch (e) {
      //   if (e.toString() ==
      //       'Exception :' + cartEmpty!.errors![0].toString()) {
      //     throw Exception(cartEmpty.errors![0].toString());
      //   } else {
      //     throw Exception('No Internet');
      //   }
      // }
    }



/// empty favourite list

  Future<FavouriteListEmpty> emptyFavouriteList() async {
    UserDataSaveModel user=await _sharedPrefClient.getUser();
    FavouriteListEmpty? favEmpty;
    try {
      final response = await get(
        _baseUrl + _endPFavouriteEmpty,
        headers: {
          'Accept': 'application/json',
          'APP_KEY': _apiAccessToken,
          'Authorization': 'Bearer ${user.token}'
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        favEmpty =FavouriteListEmpty.fromJson(response.body);
        if (favEmpty.responseCode! == '1') {
          return favEmpty;
        } else {
          throw Exception(favEmpty.errors![0].toString());
        }
      } else {
        throw Exception('No Internet');
      }
    } catch (e) {
      if (e.toString() ==
          'Exception :' + favEmpty!.errors![0].toString()) {
        throw Exception(favEmpty.errors![0].toString());
      } else {
        throw Exception('No Internet');
      }
    }
  }

  Future<ShowSlotsModel>showRetailersTimeSlots(int storeId) async {
    UserDataSaveModel user=await _sharedPrefClient.getUser();
    final response = await post("$_baseUrl$_endWorkingDaySlots",{
      "store_id":storeId
    },
        headers: {
          'Accept': 'application/json',
          'APP_KEY': _apiAccessToken,
          'Authorization': 'Bearer ${user.token}'
        }
    );

    if(response.status.hasError){
      return Future.error(response.statusText!);
    }else{
      ShowSlotsModel model = ShowSlotsModel.fromJson(response.body);
      return model;
    }

  }


  Future<NewOffersModel>newOffersDialog()async{
    UserDataSaveModel user=await _sharedPrefClient.getUser();
    final response = await get("$_baseUrl$_latestOffer",headers: {
      'Accept': 'application/json',
      'APP_KEY': _apiAccessToken,
      'Authorization': 'Bearer ${user.token}'
    });
    if(response.status.hasError){
      return Future.error(response.statusText!);
    }else{
      NewOffersModel model = NewOffersModel.fromJson(response.body);
      return model;
    }
  }



}
