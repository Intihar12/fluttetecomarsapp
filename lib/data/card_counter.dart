import 'package:get/get.dart';


class CardCounter {

  RxInt _counter=10.obs;

  RxInt get getCounter {
    print(" print the get counter  value:${_counter.value}");
   return _counter;

  }

 set setCounter(int value) {
    _counter.value = value;
    print(" print the set value:${_counter.value}");

  }



}