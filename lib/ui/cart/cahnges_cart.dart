import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/constants/constants.dart';

import '../../data/controller/cart_controller/cart_controller.dart';
import '../delivery/delivery.dart';
import '../values/my_colors.dart';
import '../widgets/custom_button.dart';


class ChangesInCart extends StatelessWidget {
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('Changes Cart',
                  style: Get.textTheme.headline2!.copyWith(
                    color: MyColors.white
                  ),

                  ),
                ),
        body: GetBuilder<CartController>(

          builder: (controller) {
            return
              controller.model==null?SizedBox():
              Container(

               child: Column(
                 children: [

                   Text('sorry Some Thing changes',
                     style: Get.textTheme.headline4!.copyWith(
                         color: MyColors.black
                     ),
                   ),
                   SizedBox(height: 20,),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: Container(
                       height: Get.height*0.7,
                       child: ListView.builder(
                         // controller: _scrollController,
                           physics: BouncingScrollPhysics(),
                           shrinkWrap: true,
                           itemCount: cartController.model!.response!.products!.length,
                           itemBuilder: (context, index) {
                             return Container(
                               height: 120,
                               color: MyColors.textVColor.withOpacity(0.5),
                               child: Row(
                                 children: [
                                   controller.model!.response!.products![index].isPriceChanged==1||
                                       controller.model!.response!.products![index].isQuantityChanged==1
                                       ||   controller.model!.response!.products![index].isDeleted==1?
                                   Container(
                                     height: 100,
                                     width: 100,
                                     color: MyColors.primaryColor,
                                     child: Image.network(

                                      '${controller.model!.response!.baseUrl}${controller.model!.response!.products![index].product!.image}'),

                                   ):Container(),
                                   controller.model!.response!.products![index].isPriceChanged==1||
                                       controller.model!.response!.products![index].isQuantityChanged==1
                                       ||   controller.model!.response!.products![index].isDeleted==1
                                       ?
                                   Padding(
                                     padding: const EdgeInsets.only(left: 20),
                                     child: Column(
                                       children: [
                                         Text(cartController.model!.response!.products![index].product!.title.toString()),
                                         Text('${Constants.currency}${cartController.model!.response!.products![index].product!.price.toString()}'),
                                       ],
                                     ),
                                   ) :Column(
                                     children: [
                                       Text('')
                                     ],
                                   )
                                 ],
                               ),
                             );
                           }),

                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: Row(children: [
                       Text('New total',
                       style: Get.textTheme.subtitle1!.copyWith(
                         color: MyColors.textVColor.withOpacity(0.7),
                       ),
                       ),

                       Text('${Constants.currency}${cartController.model!.response!.total.toString()}',
                         style: Get.textTheme.subtitle1!.copyWith(
                           color: MyColors.black,
                         ),
                       )
                     ],),
                   ),
                   SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                     child: CustomButton(
                       text: 'Choose this address',
                       height: 0.055,
                       width: Get.width,
                       roundCorner: 10,
                       onPressed: () async {
                         Get.to(Delivery());
                       },
                     ),
                   )
                 ],
               ),
            );
          }
        ));
  }
}
