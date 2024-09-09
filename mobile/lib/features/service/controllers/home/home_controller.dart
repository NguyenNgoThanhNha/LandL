import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  // variable

  final hideBalance = true.obs;
  final directionTo = TextEditingController();
  final isSearch = false.obs;



  Future<void> onSearch() async{
    try{

      isSearch.value = true;
    }catch(e){}
  }
}
