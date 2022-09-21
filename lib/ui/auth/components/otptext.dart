import 'package:flutter/material.dart';
import 'package:kiwkemart/ui/values/dimens.dart';




class TextFieldWidget extends StatelessWidget {
  final FocusNode focusNode;
  final void Function(String) onchanged;
  final TextEditingController controller;

  const TextFieldWidget({
    required this.focusNode,
    required this.onchanged,
    required this.controller,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
      ),
      child: Column(
        children: [
          Container(
            width: Dimens.size50,
            height: Dimens.size60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: Dimens.size1, color: Theme.of(context).colorScheme.onSecondary),
              borderRadius: BorderRadius.circular(Dimens.size5),
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color:  Theme.of(context).colorScheme.onSecondary,
                  fontSize: 17
              ),
              // style: TextStyle(
              //     color: MyColors.primary,
              //     fontSize: 17,
              //     // fontFamily: 17,
              //     fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
              ),
              onChanged: onchanged,
            ),
          ),
        ],
      ),
    );
  }
}
