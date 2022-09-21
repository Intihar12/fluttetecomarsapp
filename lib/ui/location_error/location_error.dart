import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/custom_textfield.dart';


class LocationError extends StatelessWidget {
  const LocationError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
appBar: AppBar(
  elevation: 0,
 // backgroundColor: Get.theme.colorScheme.onPrimary,
),
        body: SingleChildScrollView(
          child: Container(
      child: Column(
          children: [
            SizedBox(height: Dimens.size70,),


            Center(
              child: SizedBox(
                height: 100,
                  width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(image: AssetImage(MyImgs.iconSmileFace),),
                ),
              ),
            ),
            SizedBox(height: Dimens.size30,),
            Text('Sorry! We do not deliver there\nyet',
              style: Get.textTheme.headline1!.copyWith(
                color: MyColors.textHeadLine
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Dimens.size70,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(

                height: Dimens.size50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 2,
                  color: Get.theme.colorScheme.primary
                  )

                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25,
                  bottom: 20
                  ),
                  child: CustomTextField(text: 'Enter your email',

                    keyboardType: TextInputType.emailAddress,
                      inputFormatters:FilteringTextInputFormatter.singleLineFormatter, length: 50,
                  border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimens.size30,),
            Text('We will let you know when we serve\nin your area',
              style: Get.textTheme.headline4!.copyWith(
                  color: MyColors.textHeadLine,
                fontWeight: FontWeight.normal
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Dimens.size45,),
            Center(
              child: CustomButton(text: 'Submit', width: 0.7, height: 0.06,
                roundCorner: Dimens.size30,
                onPressed: () {

                },

              ),
            ),
          ],
      ),

    ),
        )
    );
  }
}
