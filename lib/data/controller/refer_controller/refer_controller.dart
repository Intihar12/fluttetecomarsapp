

import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/user_save_data_model/user_save_data_model.dart';


import '../../shared_pref_client.dart';


class ReferCodeController extends GetxController{



  final _sharedPrefClient = SharedPrefClient();
  var   referCode=''.obs;

  @override
 Future<void>  onInit() async {
    UserDataSaveModel user = await _sharedPrefClient.getUser() ;
     referCode.value=user.referCode!;
     print('refer Code: ${referCode.value}');
    // TODO: implement onInit
    super.onInit();
  }

    Future<void> share() async {
      await FlutterShare.share(
          title: 'Code Share',
          text: referCode.toString(),
          chooserTitle: 'Choose the code '
      );

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}