import 'package:get/get.dart';

class PaymentController extends GetxController {
  var selectedMethod = 0.obs;
  var paymentMethod = 'Cash'.obs;

  void selectMethod(int index) {
    selectedMethod.value = index;
  }

  String getSelectedMethodName() {
    switch (selectedMethod.value) {
      case 0:
        return "Cash";
      case 1:
        return "Account";
      case 2:
        return "Credit Card";
      default:
        return "Unknown";
    }
  }



  void setPaymentMethod(String? value) {
    if (value != null) {
      paymentMethod.value = value;
    }
  }

    // void payNow() {
    //   if (paymentMethod.value == 'Credit Card') {
    //
    //     Get.snackbar("Payment", "Processing Credit Card Payment...");
    //   } else {
    //
    //     Get.snackbar("Payment", "Please pay driver in cash (36€)");
    //   }
    // }
  }

