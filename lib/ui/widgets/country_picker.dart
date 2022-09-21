
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:kiwkemart/data/constants/constants.dart';
import 'package:kiwkemart/ui/values/dimens.dart';


class CountryPicker extends StatelessWidget {
  CountryPicker({this.callback,this.height,this.width});
  Function? callback;
  double? height;
  double? width;
//   @override
//   _CountryPickerState createState() => _CountryPickerState();
// }

// class _CountryPickerState extends State<CountryPicker> {
  String val=Constants.countryCode;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: CountryCodePicker(
        onChanged:(value) {
          callback!(value);
        },
        textStyle: TextStyle(
          fontSize: Dimens.size12,
        ),

        showFlag: true,
        showOnlyCountryWhenClosed: false,
        enabled: true,
        initialSelection: Constants.countryCodeEn,
        showFlagMain: false,
        showDropDownButton: true,
        // autofocus: true,
        showCountryOnly: true,
        favorite: [Constants.countryCode, Constants.countryCodeEn],
      //  alignLeft: true,
      ),
    );
  }
}