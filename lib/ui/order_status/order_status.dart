import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/singleton/singleton.dart';
import 'package:kiwkemart/ui/order_detail/order_detail.dart';
import 'package:kiwkemart/ui/tracking_order/tracking_order.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';

class OrderStatus extends StatelessWidget {
  final String? orderNumber;

  const OrderStatus({Key? key,  this.orderNumber}) : super(key: key);

  // OrderStatusController orderStatusController = Get.put(OrderStatusController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Status",
        style: Get.textTheme.headline4!.copyWith(
          color: MyColors.white
        ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.size12, 0, Dimens.size12, Dimens.size12),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimens.size15,
                ),
                Image.asset(
                  MyImgs.blueLogo,
                  height: Dimens.size55,
                  width: Dimens.size65,
                ),
                SizedBox(
                  height: Dimens.size45,
                ),
                Text("Order#${orderNumber}",
                    style: textTheme.subtitle1!.copyWith(fontSize: 12)),
                SizedBox(
                  height: Dimens.size16,
                ),
                Text("Order placed successfully", style: textTheme.headline4),
                SizedBox(
                  height: Dimens.size20,
                ),
                Text("We’ve got it. We’ll start packing it\n in a moment",
                    style: textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    )),
                SizedBox(
                  height: Dimens.size12,
                ),
                MyProgressIndicator(
                  status: SingleToneValue.instance.status!.toLowerCase(),
                ),
                SizedBox(
                  height: Dimens.size20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // GestureDetector(
                    //     onTap: () {
                    //       Get.to(
                    //         OrderDetail(
                    //           id: '9',
                    //         ),
                    //         transition: Transition.leftToRightWithFade,
                    //         duration: const Duration(milliseconds: 700),
                    //       );
                    //     },
                    //     child: Text(
                    //       "My Order",
                    //       style: textTheme.headline3,
                    //     )),
                    // GestureDetector(
                    //     onTap: () {
                    //       Get.to(
                    //         ChatSupport(),
                    //         transition: Transition.leftToRightWithFade,
                    //         duration: const Duration(milliseconds: 700),
                    //       );
                    //     },
                    //     child: Text(
                    //       "Get Help",
                    //       style: textTheme.headline3,
                    //     )),
                  ],
                ),
                SizedBox(
                  height: Dimens.size60,
                ),
                SingleToneValue.instance.status == "started"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            height: 0.06,
                            width: 0.9,
                            text: "Track Order",
                            onPressed: () {
                              Get.off(TrackingOrder());
                            },
                            roundCorner: 5,
                          ),
                        ],
                      )
                    : Text(""),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  height: 0.06,
                  width: 0.85,
                  textColor: MyColors.primaryColor,
                  color: MyColors.white,
                  text: "My Order",
                  onPressed: () {
                    Get.back();
                  },
                  roundCorner: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class MyProgressIndicator extends StatefulWidget {
  final String status;

  const MyProgressIndicator({Key? key, required this.status}) : super(key: key);

  @override
  State<MyProgressIndicator> createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator> {
  double _width = 20;

  @override
  void initState() {
    if (widget.status == "packed") {
      setState(() {
        _width = 100;
      });
    } else if (widget.status == "picked") {
      setState(() {
        _width = 220;
      });
    }
    else if (widget.status == "started") {
      setState(() {
        _width = 220;
      });
    }
    else if (widget.status == "arrived") {
      setState(() {
        _width = 220;
      });
    }
    else if (widget.status == "completed") {
      setState(() {
        _width = 400;
      });

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Stack(
          children: [
            Container(
              height: Dimens.size18,
              width: mediaQuery.width * 1.0,
              decoration: BoxDecoration(
                color: MyColors.white200,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Container(
              height: Dimens.size18,
              width: _width,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Dimens.size36,
        ),
        Row(
          children: [
            Container(
              height: Dimens.size42,
              width: Dimens.size42,
              decoration: BoxDecoration(
                color: widget.status == "pending"
                    ? theme.primaryColor
                    : MyColors.white,
                border: Border.all(
                  color: widget.status == "pending"
                      ? theme.primaryColor
                      : MyColors.black,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: widget.status == "pending"
                    ? Image.asset(
                        MyImgs.wcheck,
                        height: Dimens.size30,
                        width: Dimens.size30,
                      )
                    : Image.asset(
                        MyImgs.check,
                        height: Dimens.size30,
                        width: Dimens.size30,
                      ),
              ),
            ),
            Container(
              height: Dimens.size2,
              width: Dimens.size55,
              decoration: BoxDecoration(
                color: theme.primaryColor,
              ),
            ),
            Container(
              height: Dimens.size42,
              width: Dimens.size42,
              decoration: BoxDecoration(
                color: widget.status == "packed"
                    ? theme.primaryColor
                    : MyColors.white,
                border: Border.all(
                  color: widget.status == "packed"
                      ? theme.primaryColor
                      : MyColors.black,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: widget.status == "packed"
                    ? Image.asset(
                        MyImgs.wpacking,
                        height: Dimens.size30,
                        width: Dimens.size30,
                      )
                    : Image.asset(
                        MyImgs.packing,
                        height: Dimens.size30,
                        width: Dimens.size30,
                      ),
              ),
            ),
            Container(
              height: Dimens.size2,
              width: Dimens.size55,
              decoration: BoxDecoration(
                color: theme.primaryColor,
              ),
            ),
            Container(
              height: Dimens.size42,
              width: Dimens.size42,
              decoration: BoxDecoration(
                color: widget.status == "picked"|| widget.status=='started'|| widget.status=='arrived'
                    ? theme.primaryColor
                    : MyColors.white,
                border: Border.all(
                  color: widget.status == "picked"|| widget.status=='started'|| widget.status=='arrived'
                      ? theme.primaryColor
                      : MyColors.black,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: widget.status == "picked" || widget.status=='started'|| widget.status=='arrived'
                    ? Image.asset(
                        MyImgs.wdeliveryBike,
                        height: Dimens.size30,
                        width: Dimens.size30,
                      )
                    : Image.asset(
                        MyImgs.deliveryBike,
                        height: Dimens.size30,
                        width: Dimens.size30,
                      ),
              ),
            ),
            Container(
              height: Dimens.size2,
              width: Dimens.size55,
              decoration: BoxDecoration(
                color: theme.primaryColor,
              ),
            ),
            Container(
              height: Dimens.size42,
              width: Dimens.size42,
              decoration: BoxDecoration(
                color: widget.status == "completed"
                    ? theme.primaryColor
                    : MyColors.white,
                border: Border.all(
                  color: widget.status == "completed"
                      ? theme.primaryColor
                      : MyColors.black,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: widget.status == "completed"
                    ? Image.asset(
                        MyImgs.wflag,
                        height: Dimens.size30,
                        width: Dimens.size30,
                      )
                    : Image.asset(
                        MyImgs.flag,
                        height: Dimens.size30,
                        width: Dimens.size30,
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
