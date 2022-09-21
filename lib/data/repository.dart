import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwkemart/data/model/address_models/get_address_model.dart';
import 'package:kiwkemart/data/model/cart_empty/cart_empty.dart';
import 'package:kiwkemart/data/model/home_data/home_data.dart';
import 'package:kiwkemart/data/model/login_model/login_model.dart';
import 'package:kiwkemart/data/model/new_offer_model.dart';
import 'package:kiwkemart/data/model/product_details/product_details.dart';
import 'package:kiwkemart/data/model/save_store_data/save_store_data.dart';
import 'package:kiwkemart/data/model/show_slots_model/show_slots_model.dart';
import 'package:kiwkemart/data/model/store_location_model/store_location_model.dart';
import 'package:kiwkemart/data/model/voucher/voucher.dart';

import 'package:kiwkemart/data/shared_pref_client.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'api/api_with_getx.dart';
import 'closable.dart';
import 'controller/cart_controller/cart_controller.dart';
import 'firebase_db_client.dart';
import 'maps_clients.dart';
import 'model/add_to_cart/add_to_cart.dart';
import 'model/category_product/category_product.dart';
import 'model/favourite_list_empty/favourite_list_empty.dart';
import 'model/map_search_models/fetch_address_model/fetch_address_model.dart';
import 'model/map_search_models/geomery_latlng/geomatry_latlng.dart';
import 'model/map_search_models/id_to_latlng/id_to_latlng.dart';
import 'model/map_search_models/location_model/location_model.dart';
import 'model/map_search_models/map_autocomplete_model/map_auto_complete_model.dart';
import 'model/map_search_models/map_search/map_search.dart';
import 'model/order_details/order_details.dart';
import 'model/order_list/order_list.dart';
import 'model/payment_card/payment_card_model.dart';
import 'model/place_order/PlaceOrder.dart';
import 'model/save_address_model/save_address_model.dart';
import 'model/search_keyword/search_keyword.dart';
import 'model/searched_product/searched_product.dart';
import 'model/user_save_data_model/user_save_data_model.dart';

class Repository implements Closable {
  final _sharedPrefClient = SharedPrefClient();
  final _firebaseDbClient = FirebaseDbClient();
  final _apiProvider = ApiProvider();

  final _mapClient = MapClient();

  ///search map api on google map used is Google places api used

  Future<MapSearchModel> getPlaces(
    String str,
  ) async {
    final response = await _mapClient.getPlaces(
      str,
    );
    return response;
  }

  /// get places of lat lng get places
  Future<IdtoLatLong> getPlacesLatLong(String str) =>
      _mapClient.getPlacesLatLong(str);

  Future<AutoComplete> getPlacesOnMap(String str) =>
      _mapClient.getPlacesOnMap(str);

  Future<SaveAddressModel> addAddress({
    required double lat,
    required double lng,
    required String title,
    required String address,
    String? flatNo,
    required String city,
    required String postalCode,
  }) async {
    return await _apiProvider.addAddress(
        title: title,
        address: address,
        lat: lat,
        lng: lng,
        flatNo: flatNo,
        city: city,
        postalCode: postalCode);
  }

  Future<FetchAddress> fetchAddress(
      {required double latitude, required double longitude}) async {
    return await _apiProvider.fetchAddress(
        latitude: latitude, longitude: longitude);
  }

  Future<HomeData> onHomeData(String lat, String lng) =>
      _apiProvider.onHomeData(lat, lng);

  Future<CategoryProduct> onCategoryProduct(String subCatId, String storeId) =>
      _apiProvider.onCategoryProduct(subCatId, storeId);

  Future<ProductDetailModel> onProductDetail(String id) =>
      _apiProvider.onProductDetail(id);

  Future<AddToCart> onAddToCart(
          String storeId,String addressId, List<CartItemClass> list, String token) =>
      _apiProvider.onAddToCart(storeId, addressId,list, token);

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
          String token) =>
      _apiProvider.onPlaceOder(
          userAddressId,
          scheduleDate,
          orderType,
          paymentMethod,
          cardType,
          cardNumber,
          expMonth,
          expYear,
          cVc,
          pmId,
          cardSave,
          callAtDoor,
          ringBell,
          callAtDoorText,
          ringBellText,
          description,
          token);

  Future<SearchKeyword> onSearchedKeyWords(String storeId, String token) =>
      _apiProvider.onSearchedKeyWords(storeId, token);

  Future<SearchedProducts> onSearchedProducts(
          String storeId, String keyword, String token) =>
      _apiProvider.onSearchedProducts(storeId, keyword, token);

  Future<OrderDetails> onOrderDetail(String id, String token) =>
      _apiProvider.onOrderDetail(id, token);

  Future<OrderList> onOrderList(String status, String token) =>
      _apiProvider.onOrderList(status, token);

  Future<Voucher> onVoucher(String voucherCode, String token) =>
      _apiProvider.onVoucher(voucherCode, token);

  Future<bool> onLatLngToStore(String latitude, String longitude) =>
      _apiProvider.onLatLngToStore(latitude, longitude);

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    try {
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permantly denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return Future.error(
              'Location permissions are denied (actual value: $permission).');
        }
        /*if(permission is PermissionRequestInProgressException){
        return await Geolocator.getCurrentPosition();
      }*/
      }
    } catch (e) {
      print(e.toString());
    }

    return await Geolocator.getCurrentPosition();

    // } on PermissionRequestInProgressException catch (e) {
    //   if (e is PermissionRequestInProgressException) {
    //     print('nothing');
    //   }
    //   print("from catch");
    // }
  }

  Future<LocationModel> getLocation() async {
    final Position position = await _determinePosition();
    // print(position.toString());
    final deliveryAddresses = await fetchAddress(
        latitude: position.latitude, longitude: position.longitude);

    final loc = LocationModel(
        name: 'current location',
        address: deliveryAddresses.results.first.formattedAddress != null
            ? deliveryAddresses.results.first.formattedAddress
            : 'current location',
        lat: position.latitude,
        lng: position.longitude);
    return loc;
  }

  Future<AutoComplete> getPlaces1(
    String str, {
    String? key,
    String? language,
    bool refresh = false,
  }) async =>
      await _mapClient.getPlaces1(str, key: key, language: language);

  Future<GeomatryLatLng> getPlacesLatLong1(
    String str, {
    bool refresh = false,
  }) async =>
      await _mapClient.getPlacesLatLong1(str);

  /// check the user is already login

  Future<bool> isUserLoggedIn() async =>
      await _sharedPrefClient.isUserLoggedIn();

  /// set device  token
  void firebaseCloudMessagingListeners() {
    FirebaseMessaging.instance.getToken().then((token) async {
      if (token != null) {
        await _sharedPrefClient.setDeviceToken(token);
        SingleToneValue.instance.deviceToken = token;
        print('Device Token:${SingleToneValue.instance.deviceToken}');
      }
    }).catchError((onError) {
      print("the error is ${onError}");
    });
  }

  /// set the user data save into the model through the model
  Future<void> setUser(UserDataSaveModel user) async =>
      await _sharedPrefClient.setUser(user);

  /// get the user data from the sharePref
  Future<UserDataSaveModel> getUser() async =>
      await _sharedPrefClient.getUser();

  /// get the device token
  getDeviceToken() async {
    await _sharedPrefClient.getDeviceToken();
  }

  /// login api call
  Future<LoginModel> loginFun(
      {required String phone, required String deviceToken}) async {
    return await _apiProvider.login(phone: phone, deviceToken: deviceToken);
  }

  /// register api call

  Future<LoginModel> registerFun(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String deviceToken,
      String? referCode}) async {
    return await _apiProvider.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        deviceToken: deviceToken,
        referCode: referCode);
  }

  /// get address list
  Future<GetAddressModel> getAddressList() async {
    return await _apiProvider.getAddressList();
  }

  /// remove address
  Future<GetAddressModel> removeAddress({required int id}) async {
    return await _apiProvider.removeAddress(id: id);
  }

  ///add card
  Future<String> addCard(
      {required String cardNumber,
      required String expMo,
      required String expYe,
      required String cVC,
      String? token}) async {
    return await _apiProvider.addCard(
        cardNumber: cardNumber,
        expMo: expMo,
        expYe: expYe,
        cVC: cVC,
        token: token);
  }

  /// get card list
  Future<GetCardListModel> getCardList(String token) async {
    return await _apiProvider.getCardList(token);
  }

  /// remove card
  Future<String> removeCard({required String payId}) async {
    return await _apiProvider.removeCard(payID: payId);
  }

  Future <StoreLocation> storeLocation ({required String latitude, required String longitude}) async {
    return await _apiProvider.storeLocation(latitude: latitude, longitude: longitude);
  }
  Future<CartEmpty> cartEmpty() async {
    return await _apiProvider.emptyCart();
  }

  Future<FavouriteListEmpty> favouriteEmpty() async {
    return await _apiProvider.emptyFavouriteList();
  }

  Future<ShowSlotsModel>showRetailersTimeSlots(int storeId)async{
    return await _apiProvider.showRetailersTimeSlots(storeId);
  }

  Future<NewOffersModel>newOffersDialog()async{
    return await _apiProvider.newOffersDialog();
  }

  Future<void> setStore(SaveStoreData storeData) async =>
      await _sharedPrefClient.setStoreData(storeData);
  @override
  void close() {}
}
