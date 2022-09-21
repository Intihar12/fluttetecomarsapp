import 'package:get/get_utils/src/get_utils/get_utils.dart';

class Validation {


  String? validateStreetAddress(String value) {
    if (value.isEmpty) {
      return "Enter Your Street Address";
    }
    return null;
  }

  String? validatePostalCode(String value) {
    if (value.isEmpty) {
      return "Enter Postal Code";
    }
    return null;
  }
  String? validateCity(String value) {
    if (value.isEmpty) {
      return "Enter City";
    }
    return null;
  }
  String? validateFirstName(String value) {
    if (value.isEmpty) {
      return "Enter First Name";
    }
    return null;
  }
  String? emailValidation(String value) {
    if (!GetUtils.isEmail(value)) {
      return " Enter Valid Email";
    }
    if (value.isEmpty) {
      return 'please Enter Email';
    }
    return null;
  }

  String? validateLatName(String value) {
    if (value.isEmpty) {
      return "Enter Last Name";
    }
    return null;
  }

  String? validateCardNumber(String value) {
    if (value.isEmpty) {
      return "Enter card Number";
    }
    return null;
  }
  String? validateCVC(String value) {
    if (value.isEmpty) {
      return "Enter CVC";
    }
    return null;
  }

  String? validateDateExp(String value) {
    if (value.length < 5) {
      return "Enter valid expiry date";
    } else {
      return null;
    }
  }
  String? validateFullName(String value) {
    if (value.isEmpty) {
      return "Enter Full Name";
    }
    return null;
  }
   String ? validateVoacher(String value){
     if(value.isEmpty){
       return 'Enter voucher code';
     }
     else if(value.length<6){
       return 'length is less than 6';
     }
     else if(value.length<6){
       return 'length is less than 6';
     }
     else {
       return null;
     }
   }
}