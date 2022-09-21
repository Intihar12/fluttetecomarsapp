class SingleToneValue {
  String? status;

  String? cCode;
  String? number;
  bool? orderPlaced = true;

  double currentLat = 31.4643687;
  double currentLng = 74.2414678;
  String currentAddress = 'Sigi Technologies lahore Kibria Town Lahore,';
  double pickLat = 0.0;
  double pickLng = 0.0;
  double? dropLat;
  double? dropLng;
  String? pickAddress;
  String? dropAddress;
  String? deviceToken;
  String? userName;
  int loginPageID = 1;
  int homePageId = 2;
  int saveAddressId = 3;
  int deliveryAddress=4;
  bool isShowDialog = true;
 int? userAddressId;
 int guestUserId=21;
 int ?storeIdSave;
  String city = '';
  String userPhone = '0000000';

  String customLocation = "";
  String postalCode = "";
  String state = "";
  String? flat;
  String? driverName;
  String? driverImage;
  String? driverPhone;
  String? driverId;
  String? driverDbToken;
  double? distance;
  String? estimateTime;
  String deliveryScreenAddress='';
  String deliveryScreenPostalCode='';
  String deliveryLat='';
  String deliveryLng='';

  String? callAtDoor;

  String? ringBell;

  SingleToneValue._privateConstructor();

  static SingleToneValue get instance => _instance;

  static final SingleToneValue _instance =
      SingleToneValue._privateConstructor();

  factory SingleToneValue() {
    return _instance;
  }
}
