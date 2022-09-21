class ItemModel{
  String  image;
  String  title;
  String category;
  double  quantity;
  double  price;
  double  oldPrice;
  int  offPercentage;
  bool  offer;

  ItemModel({required this.image, required this.title ,
    required this.category,
    required this.quantity,
    required this.price,
    required this.oldPrice,
    required this.offer,
  required this.offPercentage});

}

class SubCatModel{

  String  title;
  List <ItemModel> data;
  SubCatModel({
    required this.title ,
    required this.data,

   });

}