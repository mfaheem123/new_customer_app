import 'package:get/get.dart';

class YourTripController extends GetxController{

  RxInt selectedIndex = (0).obs;

  void ChangeIndex(int index) {
    selectedIndex.value = index;
  }

}

