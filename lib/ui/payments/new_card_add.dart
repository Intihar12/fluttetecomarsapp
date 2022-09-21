
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/paymentcard_controller/add_card_controller.dart';
import 'package:kiwkemart/data/controller/paymentcard_controller/paymentcard_controller.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/ui_size_config.dart';
import 'package:kiwkemart/ui/widgets/date_formate/date_formate.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class AddNewCard extends StatelessWidget {
  AddNewCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Card Save",
        style: Get.textTheme.headline2!.copyWith(
          color: MyColors.white
        ),
        ),
      ),
      body: GetBuilder< AddCardController>(
        init: AddCardController(),
        builder: (controller) {
          return controller.isLoading ? Center(child: CircularProgressIndicator()) :GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                child: Form(
                  key: controller.cardFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getHeight(Dimens.size50),
                      ),
                      Center(
                        child: Text(
                          'Add card Details ',
                          style: textTheme.headline1!
                              .copyWith(color: MyColors.primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(Dimens.size20),
                      ),
                      Text(
                        'Card Number',
                        style: textTheme.headline3!
                            .copyWith(color: MyColors.primaryColor),
                      ),
                      SizedBox(
                        height: getHeight(Dimens.size5),
                      ),
                      CustomTextField(
                          text: 'XXXXXXXXXXX',
                          length: 16,
                          controller: controller.cardNumberController,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            return controller.validation.validateCardNumber(val!);
                          },
                          inputFormatters:
                          FilteringTextInputFormatter.singleLineFormatter),
                      SizedBox(
                        height: getHeight(Dimens.size25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20,),
                              Text(
                                'Expiry Date',
                                style: textTheme.headline3!
                                    .copyWith(color: MyColors.primaryColor),
                              ),
                              SizedBox(
                                height: getHeight(Dimens.size5),
                              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: controller.expiryMoController,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(),
                      border: UnderlineInputBorder(),
                      hintText: 'MM/YY',
                    ),
                    validator: (val) {
                         return controller.validation.validateDateExp(val!);
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                      DateFormatter(),
                    ],
                  ),
              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CVV',
                                style: textTheme.headline3!
                                    .copyWith(color: MyColors.primaryColor),
                              ),
                              SizedBox(
                                height: getHeight(Dimens.size5),
                              ),
                              Container(
                                width: getWidth(Dimens.size150),
                                child: CustomTextField(
                                    text: '***',
                                    length: 3,
                                    controller: controller.cVCController,
                                    validator: (val) {
                                      return controller.validation.validateCVC(val!);
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: FilteringTextInputFormatter
                                        .singleLineFormatter),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getHeight(Dimens.size25),
                      ),
                      CustomButton(
                          height: 0.055,
                          width: 0.9,
                          roundCorner: 5,
                          text: "Card Save",
                          onPressed: () {
                            controller.addCardButton();
                            // Get.to(() => HomePage());
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}