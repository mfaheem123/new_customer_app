import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart' hide FormData;
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../../View/rides/feedback_screen.dart';
import '../../View/rides/model/booking_get_by_id/booking_get_model.dart';
import '../../api_servies/api_servies.dart' hide Dio;
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


  Future<void> updatePaymentMethodApi(String bookingId) async {

    int paymentTypeId = paymentMethod.value == "Cash" ? 1 : 2;

    var data = FormData.fromMap({
      "payment_type_id": paymentTypeId.toString(),
    });

    var response = await ApiService.post(
      data,
      "bookings/update/$bookingId",
      auth: true,
    );

    if (response != null && response.statusCode == 200) {
      /// 🔥 GET OLD BOOKING
      final box = GetStorage();
      final stored = box.read("booking");

      if (stored != null) {
        final booking = Booking.fromJson(Map<String, dynamic>.from(stored));

        /// 🔥 UPDATE FIELD
        booking.paymentTypeId = paymentTypeId;

        /// 🔥 SAVE BACK (THIS IS THE KEY FIX)
        box.write("booking", booking.toJson());


      }

      BotToast.showText(text: "Payment Method Updated Successfully");
      /// NEXT
      Get.to(ThanksScreen());
    } else {
      BotToast.showText(text: "Failed To Update Payment Method");
    }
  }

  }

