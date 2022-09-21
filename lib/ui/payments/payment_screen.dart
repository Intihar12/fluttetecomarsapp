import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/controller/paymentcard_controller/add_card_controller.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/ui_size_config.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';
import 'package:kiwkemart/ui/widgets/date_formate/date_formate.dart';
import 'package:kiwkemart/ui/widgets/progress_bar.dart';
import '../widgets/custom_textfield2.dart';

class PaymentScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Payment",
            style: Get.textTheme.headline2!.copyWith(color: MyColors.white),
          ),
        ),
        body: GetBuilder<AddCardController>(
            init: AddCardController(),
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.size15),
                    child: Form(
                      key: controller.paymentFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: getHeight(Dimens.size50),
                          ),
                          Center(
                            child: Text(
                              'Add Card Details',
                              style: textTheme.headline2,
                            ),
                          ),
                          SizedBox(
                            height: getHeight(Dimens.size10),
                          ),
                          CustomTextField2(
                              height: 50,
                              text: 'Card number',
                              length: 16,
                              controller: controller.cardNumberController,
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                return controller.validation
                                    .validateCardNumber(val!);
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter
                              ]),
                          SizedBox(
                            height: getHeight(Dimens.size25),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: CustomTextField2(
                                  controller: controller.expiryMoController,
                                  keyboardType: TextInputType.number,
                                  length: 5,
                                  validator: (val) {
                                    return controller.validation
                                        .validateDateExp(val!);
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(8),
                                    DateFormatter(),
                                  ],
                                  text: 'Expiry date',
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: CustomTextField2(
                                    text: 'CVV',
                                    length: 3,
                                    controller: controller.cVCController,
                                    validator: (val) {
                                      return controller.validation
                                          .validateCVC(val!);
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .singleLineFormatter
                                    ]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getHeight(Dimens.size25),
                          ),
                          SizedBox(
                            height: getHeight(Dimens.size25),
                          ),
                          CustomButton(
                              height: 0.055,
                              width: 1.0,
                              roundCorner: 5,
                              text: "Payment",
                              onPressed: () {
                             //   Get.dialog(ProgressBar());
                                controller.onPaymentPay();
                                // Get.to(OrderStatus());
                                //   controller.addCardButton();
                                // Get.to(() => HomePage());
                              }),
                          SizedBox(
                            height: getHeight(Dimens.size25),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     controller.addCardButton();
                          //   },
                          //   child: Container(
                          //       height: getHeight(Dimens.size45),
                          //       width: getWidth(mediaQuery.width * 0.82),
                          //       decoration: BoxDecoration(
                          //           borderRadius:
                          //           BorderRadius.circular(Dimens.size5),
                          //           border: Border.all(
                          //               color: MyColors.primaryColor,
                          //               width: 0.5)),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Container(
                          //             height: 30,
                          //             width: 30,
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: MyColors.primaryColor),
                          //                 borderRadius:
                          //                 BorderRadius.circular(20)),
                          //             child: Icon(
                          //               Icons.add,
                          //               size: 20,
                          //               color: MyColors.primaryColor,
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             width: getWidth(20),
                          //           ),
                          //           Text(
                          //             'Save Card',
                          //             style: Get.textTheme.headline3!
                          //                 .copyWith(color: MyColors.primaryColor),
                          //           )
                          //         ],
                          //       )),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
