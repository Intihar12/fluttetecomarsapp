import 'package:flutter/material.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/values/strings.dart';
import 'custom_button.dart';



class NoInternetWgt extends StatelessWidget {

  final void Function()? onTryAgain;

  const NoInternetWgt({
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var mediaQuery=MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Dimens.size200,
          height: Dimens.size200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(MyImgs.noInternetImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: Dimens.size5,
        ),
        Text(
          Strings.noInternetConnection,
        ),
        SizedBox(
          height: Dimens.size10,
        ),
        SizedBox(
          width: Dimens.size225,
          child: CustomButton(
            text: Strings.tryAgain,
            onPressed: onTryAgain!,
            width:mediaQuery.width*0.5 ,
            height: mediaQuery.height*0.8,
          ),
        ),
      ],
    );
  }
}
