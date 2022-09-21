
import 'package:kiwkemart/data/model/user_save_data_model/user_save_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/save_store_data/save_store_data.dart';



class SharedPrefClient {
  static const _sheDeviceToken = 'device_token';
  static const _sheUserId = 'user_id';
  static const _sheUserName = 'user_name';
  static const _sheUserEmail = 'user_email';
  static const _sheUserPhone = 'user_phone';
  static const _sheUserToken = 'token';
  static const _sheLat = 'lat';
  static const _sheLng = 'lng';
  static const _walkThrough = 'walk';
  static const _cartItem = 'cart';
  static const _favItem = 'fav';
  static const _sheReferCode='refer_code';
  static const _sheCoins='coins';
  static const _address='address';
  static const _storeId='id';
  static const _storeName='name';
  static const  _storeLat='latitude';
  static const _storeLng='longitude';
  static const _storeAddress='addressS';
  static const _dateNow = 'date_now';
  static const _offerCheck = "offer_check";

static const _userAddressId='u_id';


  Future<bool> isUserLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    final userId = sharedPref.getString(_sheUserId);
    if(userId == null){
      return false;
    }else{
      return true;
    }
  }

  Future <void> setAddress(String address) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_address, address);
  }

  Future<String ?> getAddress() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_address);
  }



  Future<void> setFavItem(String lat) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_favItem, lat);
  }

  Future<String?> getFavItem() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_favItem);
  }

  Future<void> setCartItem(String lat) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_cartItem, lat);
  }

  Future<String?> getCartItem() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_cartItem);
  }

  Future<void> setWalkThrough(String lat) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_walkThrough, lat);
  }

  Future<String?> getWalkThrough() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_walkThrough) ?? '0';
  }

  Future<void> setLat(String lat) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheLat, lat);
  }

  Future<String?> getLat() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheLat) ?? 'lat';
  }
  Future<void> setLng(String lng) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheLng, lng);
  }

  Future<String?> getLng() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheLng) ?? 'lng';
  }

  Future<void> setDeviceToken(String deviceToken) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheDeviceToken, deviceToken);
  }

  Future<String?> getDeviceToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheDeviceToken);
  }

  Future<void> setUser(UserDataSaveModel user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserName, user.userName!);
    sharedPref.setString(_sheUserEmail, user.userEmail!);
    sharedPref.setString(_sheUserPhone, user.userPhone!);
    sharedPref.setString(_sheUserToken, user.token!);
    sharedPref.setString(_sheUserId, user.userId!);
    sharedPref.setString(_sheReferCode, user.referCode!);
    sharedPref.setString(_sheCoins, user.coin!);
  }

  Future<void>  setStoreData(SaveStoreData storeData) async {
    final sharedPref = await SharedPreferences.getInstance();
sharedPref.setInt(_storeId,storeData.id !);
sharedPref.setString(_storeName,storeData.name! );
sharedPref.setString(_storeLat, storeData.lat!);
sharedPref.setString(_storeLng, storeData.lng!);
sharedPref.setString(_storeAddress, storeData.address!);

  }

Future<void>setUserAddressId(int id) async {
  final sharedPref = await SharedPreferences.getInstance();
  sharedPref.setInt(_userAddressId, id);
}
Future<int? >getUserAddressId() async {
  final sharedPref = await SharedPreferences.getInstance();
  return sharedPref.getInt(_userAddressId);
}
  Future<void> setUserName(String user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserName, user);
  }
  Future<String?> getUserName() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheUserName);
  }


  Future<void> setUserId(String user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserId, user);
  }
  Future<String?> getUserId() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheUserId) ?? '-21';
  }

  Future<void> setUserEmail(String user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserEmail, user);
  }
  Future<String?> getUserEmail() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheUserEmail);
  }

  Future<void> setUserPhone(String user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserPhone, user);
  }
  Future<String?> getUserPhone() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheUserPhone);
  }

  Future<void> setUserToken(String user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserToken, user);
  }
  Future<String?> getUserToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheUserToken);
  }

  Future<UserDataSaveModel> getUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    return UserDataSaveModel(
      userId: sharedPref.getString(_sheUserId),
      userName: sharedPref.getString(_sheUserName),
      userEmail: sharedPref.getString(_sheUserEmail),
      userPhone: sharedPref.getString(_sheUserPhone),
      token: sharedPref.getString(_sheUserToken),
      referCode: sharedPref.getString(_sheReferCode),
      coin: sharedPref.getString(_sheCoins)
    );
  }

 Future<SaveStoreData>  getStoreData()async {
   final sharedPref = await SharedPreferences.getInstance();
   return  SaveStoreData(

     id: sharedPref.getInt(_storeId),
     name: sharedPref.getString(_storeName),
     lat: sharedPref.getString(_storeLat),
     lng: sharedPref.getString(_storeLng),
     address: sharedPref.getString(_storeAddress),
   );

}

 Future<void> setCurrentDateTime(String now) async {
   final sharedPref = await SharedPreferences.getInstance();
   sharedPref.setString(_dateNow, now);
 }

 Future<String?>getCurrentDateTime() async {
   final sharedPref = await SharedPreferences.getInstance();
   return sharedPref.getString(_dateNow);
 }
 
 Future<void>setOfferCheck(int offerId)async{
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setInt(_offerCheck, offerId);
 }

 Future<int?>getOfferCheck()async{
   final sharedPref = await SharedPreferences.getInstance();
   return sharedPref.getInt(_offerCheck) ?? 0;
 }


  Future<void> clearUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.clear();


  }
}