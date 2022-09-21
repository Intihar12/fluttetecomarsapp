import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:kiwkemart/data/model/cart_item_save/cart_item_save.dart';

class Constants {
  static final String distance = "KM";
  static var cartCount = 0.obs;
  static String countryCode = "+44";
  static String countryCodeEn = "UK";
  static String storeId = '1';
  static String serviceFee = '';
  static String deliveryFee = '';
  static String storeLatitude = '31.4545';
  static String storeLongitude = '74.56854';
  static String storeAddress = 'Sigi Technologies Store';
  static const String mapKey = "AIzaSyD6-w91sKpoad6GLtuleEW_0AoO4ZP1Md8";
  final String mapsearch = "Uk";
  static String currency = "£";

  static int itemInCart(List<CartItemSave> cartItemSave) {
    if (cartItemSave.length == 0) {
      return 0;
    } else {
      int c = 0;
      for (int k = 0; k < cartItemSave.length; k++) {
        c = c + cartItemSave[k].quantity;
      }
      return c;
    }
  }
}
