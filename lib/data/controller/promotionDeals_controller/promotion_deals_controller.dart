


import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwkemart/data/model/itemModel/items_model.dart';
import 'package:kiwkemart/ui/values/dimens.dart';
import 'package:kiwkemart/ui/values/my_colors.dart';
import 'package:kiwkemart/ui/values/my_imgs.dart';
import 'package:kiwkemart/ui/widgets/custom_button.dart';

class PromotionDealController extends GetxController{
  ScrollController modalController=ScrollController();


  List<SubCatModel> subCatModel=[
    SubCatModel(title: "Fruits", data: [
      ItemModel(image: MyImgs.mango, title: "Mango, Organic fruits without any chemical",category: "citruses", quantity: 1/2, price: 123, oldPrice: 110, offer: true, offPercentage: 10),
      ItemModel(image: MyImgs.banana, title: "Banana, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 100, oldPrice: 110,offer: true, offPercentage: 10),
      ItemModel(image: MyImgs.kiwi, title: "Kiwi, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 90, oldPrice: 110,offer: true, offPercentage: 10,),
      ItemModel(image: MyImgs.kiwi, title: "Kiwi, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 105, oldPrice: 110, offer: false,offPercentage: 10),
      ItemModel(image: MyImgs.dragon, title: "Dragon, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 109, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.apple, title: "Apple, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 25, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.grapes, title: "Grapes, Organic fruits without any chemical",category: "citruses", quantity:2/4, price: 30, oldPrice: 110, offer: false,offPercentage: 10),
      ItemModel(image: MyImgs.kiwi, title: "Kiwi, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 88, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.lemonImg, title: "Lemon, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 45, oldPrice: 110, offer: false,offPercentage: 10),
      ItemModel(image: MyImgs.oragneImg, title: "Orange, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 95, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.lemonImg, title: "Lemon, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 66, oldPrice: 110, offer: true,offPercentage: 10)
    ]),
    SubCatModel(title: "Vegitable", data: [
      ItemModel(image: MyImgs.mango, title: "Mango, Organic fruits without any chemical",category: "citruses", quantity: 1/2, price: 123, oldPrice: 110, offer: true, offPercentage: 10),
      ItemModel(image: MyImgs.banana, title: "Banana, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 100, oldPrice: 110,offer: true, offPercentage: 10),
      ItemModel(image: MyImgs.kiwi, title: "Kiwi, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 90, oldPrice: 110,offer: true, offPercentage: 10,),
      ItemModel(image: MyImgs.kiwi, title: "Kiwi, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 105, oldPrice: 110, offer: false,offPercentage: 10),
      ItemModel(image: MyImgs.dragon, title: "Dragon, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 109, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.apple, title: "Apple, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 25, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.grapes, title: "Grapes, Organic fruits without any chemical",category: "citruses", quantity:2/4, price: 30, oldPrice: 110, offer: false,offPercentage: 10),
      ItemModel(image: MyImgs.kiwi, title: "Kiwi, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 88, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.lemonImg, title: "Lemon, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 45, oldPrice: 110, offer: false,offPercentage: 10),
      ItemModel(image: MyImgs.oragneImg, title: "Orange, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 95, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.lemonImg, title: "Lemon, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 66, oldPrice: 110, offer: true,offPercentage: 10)
    ]),
    SubCatModel(title: "Grocery", data: [
      ItemModel(image: MyImgs.mango, title: "Mango, Organic fruits without any chemical",category: "citruses", quantity: 1/2, price: 123, oldPrice: 110, offer: true, offPercentage: 10),
      ItemModel(image: MyImgs.banana, title: "Banana, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 100, oldPrice: 110,offer: true, offPercentage: 10),
      ItemModel(image: MyImgs.kiwi, title: "Kiwi, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 90, oldPrice: 110,offer: true, offPercentage: 10,),
      ItemModel(image: MyImgs.kiwi, title: "Kiwi, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 105, oldPrice: 110, offer: false,offPercentage: 10),
      ItemModel(image: MyImgs.dragon, title: "Dragon, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 109, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.apple, title: "Apple, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 25, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.grapes, title: "Grapes, Organic fruits without any chemical",category: "citruses", quantity:2/4, price: 30, oldPrice: 110, offer: false,offPercentage: 10),
      ItemModel(image: MyImgs.kiwi, title: "Kiwi, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 88, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.lemonImg, title: "Lemon, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 45, oldPrice: 110, offer: false,offPercentage: 10),
      ItemModel(image: MyImgs.oragneImg, title: "Orange, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 95, oldPrice: 110, offer: true,offPercentage: 10),
      ItemModel(image: MyImgs.lemonImg, title: "Lemon, Organic fruits without any chemical",category: "citruses", quantity: 2/4, price: 66, oldPrice: 110, offer: true,offPercentage: 10)
    ]),
  ];

  void scrollToTop() {
    modalController.animateTo(0,
        duration: Duration(milliseconds: 200), curve: Curves.linear);
  }






}