import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart'  hide FormData, Response;
import '../../View/yourtrip/booking_history_model/bookingHistorymodel.dart';
import '../../View/yourtrip/booking_history_model/bookingScheduleModel.dart' ;
import '../../api_servies/api_servies.dart';
import '../../api_servies/session.dart';

class YourTripController extends GetxController{

  RxInt selectedIndex = (0).obs;

  void ChangeIndex(int index) {
    selectedIndex.value = index;

    if (index == 0) {
      getBookingScheduleApi(); // 📅 schedule tab
    } else if (index == 1) {
      getBookingHistoryApi(); // 📜 history tab
    }
  }
  BookingHistoryModel? bookingHistoryModel;
  bool loading = false;

  Future<void> getBookingHistoryApi() async {
    loading = true;
    update();

    var response = await ApiService.get(
        "bookings/customer-bookings/${TokenManager.userId}",
        auth: true,
        isProgressShow: false
    );

    if (response != null && response.statusCode == 200) {

      bookingHistoryModel =BookingHistoryModel.fromJson(response.data);
      print(response.data);
    }

    loading = false;
    update();
  }



  ///=====================================================  booking schedule

  BookingScheduleModel? bookingScheduleModel;
  bool scheduleLoading = false;

  Future<void> getBookingScheduleApi() async {
    scheduleLoading = true;
    update();

    var response = await ApiService.get(
        "bookings/customer-schedule/${TokenManager.userId}",
        auth: true,
        isProgressShow: false
    );

    if (response != null && response.statusCode == 200) {

      bookingScheduleModel =BookingScheduleModel.fromJson(response.data);
      print(response.data);
    }

    scheduleLoading = false;
    update();
  }

  String? selectedBookingId;

  // 2. ID save karne ka function
  void saveBookingId(String id) {
    selectedBookingId = id;
    update(); // UI update karne ke liye
    print("Saved Booking ID: $selectedBookingId");
  }



  Future<void> rideCancelApi() async {
    print(selectedBookingId);
    update();
    FormData formData = FormData.fromMap({
      "booking_status_id": 12,

    });

    var response = await ApiService.post(
      formData,
      "bookings/status/$selectedBookingId",

      multiPart: false,
      auth: false,
    );

    if (response!.statusCode == 200) {
      bookingScheduleModel?.bookings?.removeWhere((item) => item.id == selectedBookingId);
      BotToast.showText(text: "Booking Cancel Success");
      getBookingScheduleApi();
      print("${selectedBookingId}");
      ChangeIndex(0);
      update();
      //Get.toNamed('/DeshBoard_Screen');
      return;
    }


  }
}



